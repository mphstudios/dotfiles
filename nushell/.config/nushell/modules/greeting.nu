# Word-wrap a string into lines of at most `width` characters.
# Newlines in the input are treated as paragraph breaks and preserved in output.
# A single word wider than `width` is emitted as-is on its own line (soft overflow).
def word-wrap [width: int]: string -> list<string> {
    $in | split row "\n" | each {|paragraph|
        if ($paragraph | str trim | is-empty) {
            [""]
        } else {
            let words = $paragraph | split row ' ' | where {|w| $w != ""}
            let result = $words | reduce -f {lines: [], current: ""} {|word, acc|
                let sep = if ($acc.current | is-empty) { "" } else { " " }
                let candidate = $"($acc.current)($sep)($word)"
                if ($candidate | visible-length) <= $width {
                    {lines: $acc.lines, current: $candidate}
                } else {
                    {lines: ($acc.lines | append $acc.current), current: $word}
                }
            }
            $result.lines | append $result.current | where {|l| $l != ""}
        }
    } | flatten
}

# Visible character count of a string, ignoring ANSI escape codes
def visible-length []: string -> int {
    $in | ansi strip | split chars | length
}

# Return spaces to left-pad `content_width` chars to the centre of `total_width`
def left-pad [total_width: int, content_width: int]: nothing -> string {
    let w = ($total_width - $content_width) / 2 | into int
    if $w > 0 { "" | fill -c ' ' -w $w } else { "" }
}

# Compute the left-indent (in spaces) that block-centres a list of lines within
# `container_width`. All lines share the same indent; the widest line is centred
# and shorter lines retain their left-alignment relative to the block.
def block-indent [container_width: int]: list<string> -> int {
    let block_width = [$container_width, ($in | each {|l| $l | visible-length} | math max)] | math min
    [0, (($container_width - $block_width) / 2 | into int)] | math max
}

# Number of terminal rows the card renderer will occupy for the given text and footer
def card-height [text: string, footer: string, reflow: bool = true]: nothing -> int {
    let term_width = (term size).columns
    let card_width = ([$term_width 80] | math min)
    let inner_width = $card_width - 4
    let content_lines = if $reflow {
        $text | word-wrap $inner_width | length
    } else {
        $text | split row "\n" | length
    }
    let footer_lines = if ($footer | is-not-empty) { 2 } else { 0 }
    6 + $content_lines + $footer_lines  # leading blank + ╭─╮ + blank interior + content + [footer] + blank interior + ╰─╯ + trailing blank
}

# Render piped text in a centered card with an optional footer line
def card [footer: string = "", reflow: bool = true] {
    let content = $in
    let term_width = (term size).columns
    let card_width = ([$term_width 80] | math min)
    let inner_width = $card_width - 4
    let margin  = left-pad $term_width $card_width

    let h_rule = "" | fill -c '─' -w ($card_width - 2)
    let blank   = "" | fill -c ' ' -w ($card_width - 2)

    let content_rows = if $reflow {
        $content | word-wrap $inner_width | each {|line|
            let padding_right = [($inner_width - ($line | visible-length)), 0] | math max
            $"($margin)│ ($line)($"" | fill -c ' ' -w $padding_right) │"
        }
    } else {
        # Block centering: all lines share the margin of the widest line,
        # preserving the poem's own left-alignment within the card.
        let lines = $content | split row "\n"
        let padding_left = $lines | block-indent $inner_width
        $lines | each {|line|
            let padding_right = [0, ($inner_width - $padding_left - ($line | visible-length))] | math max
            $"($margin)│ ($"" | fill -c ' ' -w $padding_left)($line)($"" | fill -c ' ' -w $padding_right) │"
        }
    }

    let footer_rows = if ($footer | is-not-empty) {
        let footer_width = $footer | visible-length
        let padding_left = [0, (($inner_width - $footer_width) / 2 | into int)] | math max
        let padding_right = [0, ($inner_width - $footer_width - $padding_left)] | math max
        [
            $"($margin)│($blank)│"
            $"($margin)│ ($"" | fill -c ' ' -w $padding_left)($footer)($"" | fill -c ' ' -w $padding_right) │"
        ]
    } else { [] }

    [
        ""
        $"($margin)╭($h_rule)╮"
        $"($margin)│($blank)│"
    ]
    | append $content_rows
    | append $footer_rows
    | append [
        $"($margin)│($blank)│"
        $"($margin)╰($h_rule)╯"
        ""
    ]
    | str join "\n"
    | print
}

# Render piped text centered in the terminal with an optional footer line
def center [footer: string = "", reflow: bool = true] {
    let content = $in
    let term_width = (term size).columns
    let max_width = ([$term_width 76] | math min)

    print ""
    if $reflow {
        for line in ($content | word-wrap $max_width) {
            if ($line | is-empty) { print "" } else {
                print $"(left-pad $term_width ($line | visible-length))($line)"
            }
        }
    } else {
        # Block centering: all lines share the margin of the widest line,
        # preserving the poem's own left-alignment within the block.
        let lines = $content | split row "\n"
        let margin_left = $lines | block-indent $term_width
        for line in $lines {
            if ($line | is-empty) { print "" } else { print $"($"" | fill -c ' ' -w $margin_left)($line)" }
        }
    }

    if ($footer | is-not-empty) {
        print ""
        print $"(left-pad $term_width ($footer | visible-length))($footer)"
    }
    print ""
}

# Render piped text as plain lines with an optional footer line.
# The `reflow` parameter accepted by other renderers is not used here.
def plain [footer: string = ""] {
    print $in
    if ($footer | is-not-empty) { print $footer }
}

# Clear the screen, render a vertically centred card, and wait for a keypress;
# the greeting remains in the terminal scrollback buffer after being dismissed.
def splash [footer: string = "", reflow: bool = true] {
    let text = $in
    let size = term size

    clear
    if $reflow {
        let margin_top = ([0, (($size.rows - (card-height $text $footer true)) / 2 | into int)] | math max)
        if $margin_top > 0 { for _ in 1..$margin_top { print "" } }
        $text | card $footer
    } else {
        # Borderless rendering for pre-formatted content; vertically centre only
        # if the content fits — otherwise render from the top and let it scroll.
        let line_count = ($text | split row "\n" | length) + (if ($footer | is-not-empty) { 3 } else { 2 })
        let margin_top = ([0, (($size.rows - $line_count) / 2 | into int)] | math max)
        if $margin_top > 0 { for _ in 1..$margin_top { print "" } }
        $text | center $footer false
    }

    let hint_text = "Press any key…"
    let hint = $"(ansi {attr: d})($hint_text)(ansi reset)"
    print $"(left-pad $size.columns ($hint_text | visible-length))($hint)"
    # Nota bene: the card is not redrawn on terminal resize. Reedline does not
    # emit resize events via `input listen`, so there is no way to detect a
    # resize and recalculate the layout without polling or an external signal.
    for _ in (input listen --types [key]) { break }
    # Use natural scrolling rather than \e[2J or `clear`. Printing rows - 1
    # newlines pushes each visible row off the top of the viewport into the scrollback
    # buffer without erasing it. Erase-display sequences may wipe the scrollback as a
    # side-effect depending on the terminal emulator and its terminfo entry.
    if $size.rows > 1 {
        1..($size.rows - 1) | each {|_| ""} | str join "\n" | print
    }
    # send cursor to home; no trailing newline so the prompt lands at row 0
    print --no-newline "\e[H"
}

# Dispatch text to the appropriate renderer.
# Pass reflow: false for pre-formatted content (poems, passages) to preserve line
# breaks. With reflow: false, card block-centres the poem within the box; splash
# renders borderless and block-centred.
def render [text: string, footer: string, style: string, reflow: bool = true] {
    match $style {
        "card"   => { $text | card $footer $reflow }
        "center" => { $text | center $footer $reflow }
        "splash" => { $text | splash $footer $reflow }
        _        => { $text | plain $footer }
    }
}

# Format attribution and source into a display string
def attribution-string [attribution: string, source: string]: nothing -> string {
    if ($attribution | is-not-empty) and ($source | is-not-empty) {
        $"— ($attribution), (ansi {attr: i})($source)(ansi reset)"
    } else if ($attribution | is-not-empty) {
        $"— ($attribution)"
    } else if ($source | is-not-empty) {
        $"— (ansi {attr: i})($source)(ansi reset)"
    } else { "" }
}

# Parse a poem markdown file with YAML frontmatter into a display record.
#
# File location: $XDG_DATA_HOME/poems/*.md  (default ~/.local/share/poems/)
#
# Frontmatter schema:
#   title   string        title of the poem or passage; displayed above the body in italic
#   author  string        attribution shown in the footer
#   source  string        source work shown in italic after the author in the footer
#   tags    string        space- or comma-separated values; matched by `poems --tag`
#   reflow  bool = false  false → preserve original line breaks (verse)
#                         true  → word-wrap to terminal width (prose passages)
def parse-poem [path: string]: nothing -> record {
    let raw = open --raw $path | decode utf-8
    if not ($raw | str starts-with "---\n") {
        error make {
            msg: "Malformed poem file — missing opening frontmatter delimiter"
            help: $"($path)\nFile must begin with ---"
        }
    }
    # Strip the opening `---\n`, then split on the closing `\n---\n`.
    # Rejoining any further parts preserves `---` that appear in the poem body.
    let after_open = $raw | str substring 4..
    let parts = $after_open | split row "\n---\n"
    if ($parts | length) < 2 {
        error make {
            msg: "Malformed poem file — missing or unparseable frontmatter delimiters"
            help: $"($path)\nCheck for non-Unix line endings or missing frontmatter delimiters"
        }
    }
    let meta = try { $parts | first | from yaml } catch {|err|
        error make {
            msg: $"Malformed poem file — YAML frontmatter could not be parsed"
            help: $"($path)\n($err.msg)"
        }
    }
    let body = $parts | skip 1 | str join "\n---\n" | str trim
    # Normalise tags to a string regardless of whether YAML parsed them as a scalar or list.
    let tags = do {
        let raw_tags = $meta.tags? | default ""
        if ($raw_tags | describe | str starts-with "list") { $raw_tags | str join " " } else { $raw_tags | into string }
    }
    let footer = attribution-string ($meta.author? | default "") ($meta.source? | default "")
    {
        title: ($meta.title? | default "")
        text: $body
        footer: $footer
        author: ($meta.author? | default "")
        tags: $tags
        reflow: ($meta.reflow? | default false)
    }
}

# Display a random quote, optionally filtered by author or tag
#
# File location: $XDG_DATA_HOME/quotes.csv  (default ~/.local/share/quotes.csv)
#
# CSV columns (header row required):
#   QUOTE        text of the quote
#   ATTRIBUTION  person attributed; matched by `quotes --author`
#   SOURCE       source work shown in italic in the footer
#   TAGS         space- or comma-separated values; matched by `quotes --tag`
export def quotes [
    --author (-a): string      # Filter by attribution (partial, case-insensitive)
    --tag (-t): string         # Filter by tag (partial, case-insensitive)
    --style (-s): string = "plain"  # Output style: plain, center, card, or splash (splash clears screen and waits for a keypress)
] {
    let data_dir = $env.XDG_DATA_HOME? | default ($env.HOME | path join ".local/share")
    let quotes_file = $data_dir | path join "quotes.csv"
    if not ($quotes_file | path exists) {
        error make { msg: $"Quotes file not found: ($quotes_file)" }
    }
    mut rows = open $quotes_file

    if $author != null {
        $rows = $rows | where {|row|
            $row.ATTRIBUTION | default "" | str contains --ignore-case $author
        }
    }

    if $tag != null {
        $rows = $rows | where {|row|
            $row.TAGS | default "" | str contains --ignore-case $tag
        }
    }

    if ($rows | is-empty) {
        error make { msg: "No matching quotes found" }
    }

    let q = $rows | shuffle | first

    let footer = attribution-string ($q.ATTRIBUTION | default "") ($q.SOURCE | default "")
    render $q.QUOTE $footer $style
}

# Display a random poem or passage from the local poems directory,
# optionally filtered by author or tag
export def poems [
    --author: string           # Filter by author (partial, case-insensitive)
    --title: string            # Filter by title (partial, case-insensitive)
    --tag: string              # Filter by tag (partial, case-insensitive)
    --style: string = "plain"  # Output style: plain, center, card, or splash
] {
    let data_dir = $env.XDG_DATA_HOME? | default ($env.HOME | path join ".local/share")
    let poems_dir = $data_dir | path join "poems"
    if not ($poems_dir | path exists) {
        error make { msg: $"Poems directory not found: ($poems_dir)" }
    }

    let files = glob (($poems_dir | path join "*.md") | into glob)
    if ($files | is-empty) {
        error make { msg: "No poems found" }
    }

    let poem = if $author != null or $title != null or $tag != null {
        mut candidates = $files | each {|f| parse-poem $f }
        if $author != null {
            $candidates = $candidates | where {|p| $p.author | str contains --ignore-case $author }
        }
        if $title != null {
            $candidates = $candidates | where {|p| $p.title | default "" | str contains --ignore-case $title }
        }
        if $tag != null {
            $candidates = $candidates | where {|p| $p.tags | default "" | str contains --ignore-case $tag }
        }
        if ($candidates | is-empty) {
            error make { msg: "No matching poems found" }
        }
        $candidates | shuffle | first
    } else {
        $files | shuffle | first | parse-poem $in
    }

    let display_text = if ($poem.title | is-not-empty) {
        $"(ansi {attr: i})($poem.title)(ansi reset)\n\n($poem.text)"
    } else {
        $poem.text
    }
    render $display_text $poem.footer $style $poem.reflow
}

# Display a random greeting drawn from quotes and poems
export def greet [
    --style (-s): string = "plain"  # Output style: plain, center, card, or splash (splash clears screen and waits for a keypress)
] {
    let data_dir = $env.XDG_DATA_HOME? | default ($env.HOME | path join ".local/share")
    let poems_dir = $data_dir | path join "poems"
    let has_poems = ($poems_dir | path exists) and (glob (($poems_dir | path join "*.md") | into glob) | is-not-empty)

    if $has_poems and ((random int 0..1) == 0) {
        poems --style $style
    } else {
        quotes --style $style
    }
}
