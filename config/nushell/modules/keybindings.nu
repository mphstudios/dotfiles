# Custom key bindings
# https://www.nushell.sh/book/line_editor.html#keybindings
export-env {
    $env.config = ($env.config | upsert keybindings [
        {
            name: delete_one_word_backward
            modifier: alt
            keycode: backspace
            mode: [emacs vi_insert vi_normal]
            event: { edit: backspaceword }
        }
    ])
}
