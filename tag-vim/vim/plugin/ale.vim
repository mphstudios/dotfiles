"
" ALE (Asynchronous Lint Engine) settings
"
if executable('bash-language-server')
  au User lsp_setup call lsp#register_server({
    \'name': 'bash-language-server',
    \'cmd': {server_info->[&shell, &shellcmdflag, 'bash-language-server start']},
    \'whitelist': ['sh'],
   \})
endif

let g:airline#extensions#ale#enabled = 1 "show errors or warnings in statusline

let g:ale_linters = {
  \'css': ['csslint', 'prettier', 'stylelint'],
  \'cucumber': ['cucumber'],
  \'erb': ['erb'],
  \'html': ['HTMLHint', 'tidy'],
  \'javascript': ['eslint', 'standard'],
  \'json': ['fixjson', 'jsonlint', 'prettier'],
  \'jsx': ['stylelint', 'eslint'],
  \'markdown': ['markdownlint'],
  \'python': ['flake8', 'pylint', 'vulture'],
  \'r': ['lintr'],
  \'ruby': ['rails_best_practices', 'rubocop'],
  \'sh': ['language_server'],
  \'sql': ['sqllint'],
  \'vim': ['vint'],
  \'yaml': ['prettier', 'yamllint']
  \}


let g:ale_linter_aliases = {}
let g:ale_linters_explicit = 1   "only run linters named in ale_linters setting
let g:ale_sign_column_always = 1 "keep lint gutter open

let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0

let g:ale_open_list = 1          "open quick fix list at bottom of window
