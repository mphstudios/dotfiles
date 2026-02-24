# Nushell overlay for exiftool — structured EXIF/metadata access
#
# Design scope: this wrapper presents a narrow API — read metadata as structured
# Nushell data. Write operations, binary extraction (e.g. thumbnails), and
# conditional processing are out of scope; the external ^exiftool command
# should be used for everything beyond this design boundary.
#
# Tag selection is passed to exiftool as -TagName flags (server-side) rather
# than filtering in Nushell after parsing. This matters for bulk operations
# where serialising hundreds of tags per file would be wasteful. All presets
# use the same mechanism.
#
# Presets are named tag sets stored in the `exif_presets` constant. The default
# preset is used when no --preset is given. --tags is always additive: it appends
# to whichever preset is active. Subcommand aliases (exif film, exif scan, …) are
# ergonomic shorthands for --preset; both forms are equivalent.
#
# Internal flag pipeline — three naming stages flow through the implementation:
#
#   tag names   →  compile-flags  →  param_flags  →  (+ exclusions)  →  command_flags  →  ^exiftool
#   ISO, Make      merge+format      -ISO, -Make                         -ISO --Directory
#
# tag names    raw exiftool identifiers; appear in presets and --tags input
# param_flags  tag names formatted as -TagName inclusion flags by compile-flags
# command_flags  param_flags plus hardcoded exclusion flags resolved by exif-run
#
# To process all files matching a pattern, spread a glob into the rest parameter:
#   exif ...(glob *.jpg)
#   exif scan ...(glob scans/*.tif)
#   exif exposure --tags ShutterSpeedValue ...(glob *.jpg)
#
# FileName (the basename of each file) is the default row identifier. Pass
# --show-path to use SourceFile (the full path as given to exiftool) instead,
# which is useful when processing files across multiple directories.

# Coerce a --tags value to list<string>: list<string> requires bracket syntax in
# Nushell, but a bare string (the natural shell idiom) is also accepted.
def coerce-tag-names [tags: any] {
  if ($tags | describe) == "string" { [$tags] } else { $tags | default [] }
}

# Compile param flags: merge preset tag names with caller-supplied tag names,
# deduplicate, and format each as an exiftool -TagName inclusion flag.
def compile-flags [preset: list<string>, user_tags: any] {
  ($preset ++ (coerce-tag-names $user_tags)) | uniq | each { |tag| $"-($tag)" }
}

# Convert an EXIF date string (YYYY:MM:DD HH:MM:SS) to a humanized relative date.
# Non-string values and strings that do not match the EXIF date pattern are
# returned unchanged, as are dates that parse successfully but fail humanization.
def humanize-exif-date [] {
  let value = $in
  if ($value | describe) == "string" and ($value =~ '^\d{4}:\d{2}:\d{2} \d{2}:\d{2}:\d{2}') {
    try {
      $value
      | str replace --regex '^(\d{4}):(\d{2}):(\d{2})' '$1-$2-$3'
      | into datetime
      | date humanize
    } catch {
      $value
    }
  } else {
    $value
  }
}

# Named tag presets. The `default` preset is used by `exif` when no --preset is
# given. Fields are accessible as data: $exif_presets.film, $exif_presets.scan, …
export const exif_presets = {
  default: [
    FileSize FileType
    ImageWidth ImageHeight
    Make Model LensMake LensModel
    DateTimeOriginal
    ISO ExposureTime FNumber FocalLength
    GPSLatitude GPSLongitude
  ]
  exposure: [
    Make Model LensMake LensModel
    ISO ExposureTime FNumber FocalLength
    DateTimeOriginal
  ]
  film: [
    Label Subject Description UserComment
    Make Model LensMake LensModel
    ISO ExposureTime FNumber FocalLength
    DateTimeOriginal FileSource
  ]
  location: [
    GPSLatitude GPSLongitude GPSAltitude
    DateTimeOriginal
  ]
  scan: [
    FileSize FileType
    ImageWidth ImageHeight
    FileSource SensingMethod Software
    Make Model
    DateTimeOriginal
  ]
}

# Handles the full lifecycle of an exiftool invocation across five stages:
#   guard     verify exiftool is installed
#   resolve   build command_flags from param_flags, show_path, and show_all
#   invoke    run ^exiftool -json and parse the JSON output
#   transform humanize EXIF date strings in every row value
#   filter    conditionally reject the SourceFile column
#
# show_path and show_all each affect two stages: resolve (which flags are
# sent to exiftool) and filter (whether SourceFile is retained). This
# coupling is intentional — both concerns are driven by the same user intent.
#
# Nota bene: files precedes show_path in the parameter list while callers
# declare --show-path before ...files; Nushell requires rest params last.
def exif-run [
  param_flags: list<string>
  files: list<path>
  show_path: bool = false
  show_all: bool = false
] {
  if (which exiftool | is-empty) {
    error make { msg: "exiftool not found — install with: brew install exiftool" }
  }
  # ExifToolVersion and Directory are injected by exiftool and are not subject to
  # tag selection. Strip them at source via exiftool exclude flags (--TagName) rather
  # than in Nushell, which avoids closure variable-capture limitations entirely.
  # In preset mode, prepend -FileName so the basename appears as the first column.
  # In --show-path mode, omit -FileName and keep SourceFile (full path) instead.
  # In --all mode (show_all), exiftool outputs FileName naturally; no flag needed.
  let command_flags = if $show_all {
    $param_flags
  } else if $show_path {
    $param_flags ++ [--ExifToolVersion --Directory]
  } else {
    [-FileName] ++ $param_flags ++ [--ExifToolVersion --Directory]
  }
  let rows = (^exiftool -json ...$command_flags ...$files
  | from json
  | each { |row|
      # Nushell has no map-values primitive for records; standard approach is
      # to transpose into a key/value table, transform values, then fold back.
      if ($row | columns | is-empty) {
        {}
      } else {
        $row
        | transpose col value
        | update value { |entry| $entry.value | humanize-exif-date }
        | reduce -f {} { |entry, collector| $collector | upsert $entry.col $entry.value }
      }
  })
  if $show_all or $show_path or ($rows | is-empty) { $rows } else { $rows | reject SourceFile }
}

# Read EXIF metadata from one or more image files as a structured table.
# --tags is additive: it extends whichever preset is active (default by default).
# Use --all to bypass preset selection and return every tag exiftool finds.
export def main [
  --all (-a)             # Show all metadata columns
  --preset (-p): string  # Use a named tags preset: 'default', 'exposure', 'film', 'location', 'scan'
  --tags (-t): any       # Tag name(s) added to the preset (bare string or list)
  --show-path            # Show full path (SourceFile) as the row identifier instead of basename (FileName)
  ...files: path         # Files to inspect; spread a glob for bulk use: ...(glob *.jpg)
] {
  if $all and $preset != null {
    error make { msg: "--preset is meaningless with --all; use one or the other" }
  }
  let preset_name = $preset | default "default"
  if $preset_name not-in ($exif_presets | columns) {
    let valid = $exif_presets | columns | sort | str join ", "
    error make { msg: $"Unknown preset '($preset_name)'. Valid presets: ($valid)" }
  }
  let param_flags = if $all { [] } else { compile-flags ($exif_presets | get $preset_name) $tags }
  exif-run $param_flags $files $show_path $all
}

# Show exposure and lens metadata (alias for --preset exposure)
export def "exif exposure" [
  --tags (-t): any  # Additional tag name(s) to include alongside the preset
  --show-path       # Show SourceFile (full path) as row identifier instead of FileName (basename)
  ...files: path    # Files to inspect; spread a glob for bulk use: ...(glob *.jpg)
] {
  exif-run (compile-flags $exif_presets.exposure $tags) $files $show_path
}

# Show XMP editorial metadata and film photographic settings (alias for --preset film)
export def "exif film" [
  --tags (-t): any  # Additional tag name(s) to include alongside the preset
  --show-path       # Show SourceFile (full path) as row identifier instead of FileName (basename)
  ...files: path    # Files to inspect; spread a glob for bulk use: ...(glob *.tif)
] {
  exif-run (compile-flags $exif_presets.film $tags) $files $show_path
}

# Show GPS location metadata (alias for --preset location)
export def "exif location" [
  --tags (-t): any  # Additional tag name(s) to include alongside the preset
  --show-path       # Show SourceFile (full path) as row identifier instead of FileName (basename)
  ...files: path    # Files to inspect; spread a glob for bulk use: ...(glob *.jpg)
] {
  exif-run (compile-flags $exif_presets.location $tags) $files $show_path
}

# Show scanner and file technical metadata (alias for --preset scan)
export def "exif scan" [
  --tags (-t): any  # Additional tag name(s) to include alongside the preset
  --show-path       # Show SourceFile (full path) as row identifier instead of FileName (basename)
  ...files: path    # Files to inspect; spread a glob for bulk use: ...(glob *.tif)
] {
  exif-run (compile-flags $exif_presets.scan $tags) $files $show_path
}
