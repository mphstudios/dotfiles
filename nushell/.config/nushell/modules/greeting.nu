# Word-wrap a string into lines of at most `width` characters
def word-wrap [width: int]: string -> list<string> {
    let words = $in | split row ' ' | where {|w| $w != ""}
    let result = $words | reduce -f {lines: [], current: ""} {|word, acc|
        let sep = if ($acc.current | is-empty) { "" } else { " " }
        let candidate = $"($acc.current)($sep)($word)"
        if ($candidate | split chars | length) <= $width {
            {lines: $acc.lines, current: $candidate}
        } else {
            {lines: ($acc.lines | append $acc.current), current: $word}
        }
    }
    $result.lines | append $result.current | where {|l| $l != ""}
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

# Number of terminal rows the card renderer will occupy for the given text and footer
def card-height [text: string, footer: string]: nothing -> int {
    let term_width = (term size).columns
    let card_width = ([$term_width 80] | math min)
    let inner_width = $card_width - 4
    let content_lines = $text | word-wrap $inner_width | length
    let footer_lines = if ($footer | is-not-empty) { 2 } else { 0 }
    6 + $content_lines + $footer_lines  # blank + top + blank + content + [footer] + blank + bottom + blank
}

# Render piped text in a centered card with an optional footer line
def card [footer: string = ""] {
    let content = $in
    let term_width = (term size).columns
    let card_width = ([$term_width 80] | math min)
    let inner_width = $card_width - 4
    let margin  = left-pad $term_width $card_width

    let h_rule = "" | fill -c '─' -w ($card_width - 2)
    let blank   = "" | fill -c ' ' -w ($card_width - 2)

    let content_rows = $content | word-wrap $inner_width | each {|line|
        let pad_w = [($inner_width - ($line | split chars | length)), 0] | math max
        $"($margin)│ ($line)($"" | fill -c ' ' -w $pad_w) │"
    }

    let footer_rows = if ($footer | is-not-empty) {
        let pad_w = [($inner_width - ($footer | visible-length)), 0] | math max
        [
            $"($margin)│($blank)│"
            $"($margin)│ ($"" | fill -c ' ' -w $pad_w)($footer) │"
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
def center [footer: string = ""] {
    let content = $in
    let term_width = (term size).columns
    let max_width = ([$term_width 76] | math min)

    print ""
    for line in ($content | word-wrap $max_width) {
        print $"(left-pad $term_width ($line | split chars | length))($line)"
    }

    if ($footer | is-not-empty) {
        print ""
        print $"(left-pad $term_width ($footer | visible-length))($footer)"
    }
    print ""
}

# Render piped text as plain lines with an optional footer line
def plain [footer: string = ""] {
    print $in
    if ($footer | is-not-empty) { print $footer }
}

# Clear the screen, render a vertically centred card, and wait for a keypress;
# the greeting remains in the terminal scrollback buffer after being dismissed.
def splash [footer: string = ""] {
    let text = $in
    let size = term size
    let pad = ([0, (($size.rows - (card-height $text $footer)) / 2 | into int)] | math max)

    clear
    if $pad > 0 { for _ in 1..$pad { print "" } }
    $text | card $footer

    let hint_text = "Press any key…"
    let hint = $"(ansi {attr: d})($hint_text)(ansi reset)"
    print $"(left-pad $size.columns ($hint_text | split chars | length))($hint)"
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

# Dispatch text to the appropriate renderer
# To swap in gum: replace card, center, plain, and splash above — this function stays unchanged
def render [text: string, footer: string, style: string] {
    match $style {
        "card"   => { $text | card $footer }
        "center" => { $text | center $footer }
        "splash" => { $text | splash $footer }
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

# Display a random quote, optionally filtered by author or tag
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

# Display a random greeting from the local quotes data
export def greet [
    --style (-s): string = "plain"  # Output style: plain, center, card, or splash (splash clears screen and waits for a keypress)
] {
    quotes --style $style
}
