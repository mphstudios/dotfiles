# PDF utility functions

export def is-pdf [file: path] {
  let path = ($file | path expand)
  if not ($path | path exists) { return false }
  let file_type = (^file --mime-type --brief $path)
  ($file_type == 'application/pdf')
}

# Merge PDF files
export def mergepdf [
  ...files: string      # Input PDF files to merge
  --output (-o): path   # Output file path (required)
  --force (-f)          # Overwrite output if the file already exists
] {
  # Use *.pdf as default if no file paths are provided
  let files = $files | if ($files | is-empty) { ["*.pdf"] } else { . }
  let output = (($output | default 'merged.pdf') | path expand)
  let tool = "/System/Library/Automator/Combine PDF Pages.action/Contents/MacOS/join"

  # Check if join tool exists
  if not ($tool | path exists) {
    error make { msg: $"PDF join tool not found at: ($tool)" }
  }

  # Expand globs and validate files in one pass
  let inputs = (
    $files
    | each { |path|
      if ($path | str contains "*") or ($path | str contains "?") {
        glob $path
      } else {
        $path
      }
    }
    | flatten
    | each { |path|
      let file = ($path | path expand)
      if not ($file | path exists) {
        error make { msg: $"Input file not found: ($file)" }
      }
      if not (is-pdf $file) {
        error make {msg: $"File is not a valid PDF: ($file)"}
      }
      $file
    }
  )

  if ($inputs | length) <= 1 {
    error make { msg: "At least one input file is required" }
  }

  # Check output file
  if ($output | path exists) and not $force {
    error make {
      msg: $"Output file already exists: ($output). Use --force to overwrite."
    }
  }

  # Execute the merge
  try {
    ^$tool ...$inputs -o $output
    let file_count = ($inputs | length)
    print $"✓ Successfully merged ($file_count) PDF files to: ($output)"
  } catch { |error|
    error make { msg: $"Failed to merge PDFs: ($error.msg)" }
  }
}
