"
" Vim Plugins
"
let g:has_async = v:version >= 800 || has('nvim')

" vim-plug minimalist plugin manager
"(https://github.com/junegunn/vim-plug)
" Specify a plugins directory, avoid standard Vim directories such as 'plugin'
call plug#begin('~/.vim/vim-plugins')

" Colour schemes
Plug 'altercation/solarized', {'as': 'solarized'}
Plug 'lifepillar/vim-solarized8', {'as': 'solarized8'}
Plug 'romainl/flattened', {'as': 'flattened'}
Plug 'dracula/vim', {'as': 'dracula'}

" Full path fuzzy file, buffer, mru, tag finder
Plug 'mileszs/ack.vim', {'as': 'ack'}
Plug 'junegunn/fzf.vim', {'as': 'fzf'}
Plug 'ctrlpvim/ctrlp.vim', {'as': 'ctrlp'}
Plug 'nixprime/cpsm' "matcher for CtrlP
"Plug 'wincent/command-t', {'as': 'command-t'}

" Core Unix file operations as Vim commands in the context of the current file
Plug 'tpope/vim-eunuch', {'as': 'eunuch'}

" wrap selected region with with a matching pair of characters
Plug 'tpope/vim-surround', {'as': 'surround'}

Plug 'tpope/vim-unimpaired', {'as': 'unimpaired'}
Plug 'Valloric/YouCompleteMe' "code completion engine

" A salvo of edit and search enhancement plugins ...
Plug 'chrisbra/vim-autoread', {'as': 'autoread'}
Plug 'ddrscott/vim-side-search', {'as': 'side-search'}
Plug 'dhruvasagar/vim-table-mode', {'as': 'table-mode'}
Plug 'easymotion/vim-easymotion', {'as': 'easymotion'}
Plug 'editorconfig/editorconfig-vim', {'as': 'editorconfig'}
Plug 'ervandew/supertab', {'as': 'supertab'} "autocomplete using tab
Plug 'godlygeek/tabular', {'as': 'tabular'}
Plug 'jceb/vim-orgmode', {'as': 'orgmode'}
Plug 'jiangmiao/auto-pairs', {'as': 'auto-pairs'}
Plug 'jlanzarotta/bufexplorer', {'as': 'bufexplorer'}
Plug 'junegunn/rainbow_parentheses.vim', {'as': 'rainbow_parentheses'}
Plug 'junegunn/vim-easy-align', {'as': 'easy-align'}
Plug 'junegunn/vim-slash', {'as': 'slash'}
Plug 'kana/vim-textobj-user', {'as': 'textobj-user'}
Plug 'machakann/vim-highlightedyank', {'as': 'highlightedyank'}
Plug 'majutsushi/tagbar', {'as': 'tagbar'}
Plug 'nathanaelkane/vim-indent-guides', {'as': 'indent-guides'}
Plug 'rhysd/clever-f.vim', {'as': 'clever-f'}
Plug 'ryanoasis/vim-devicons', {'as': 'devicons'}
Plug 'scrooloose/nerdcommenter', {'as': 'nerdcommenter'}
Plug 'skywind3000/vim-preview'
Plug 'sophacles/vim-processing', {'as': 'processing'}
Plug 'terryma/vim-multiple-cursors', {'as': 'multiple-cursors'}
Plug 'tpope/vim-repeat', {'as': 'repeat'}
Plug 'vim-scripts/bash-support.vim', {'as': 'bash-support'}
Plug 'vim-scripts/CursorLineCurrentWindow'

" enhancements for netrw built-in file explorer
Plug 'tpope/vim-vinegar', {'as': 'vinegar'}

" NERDTree file system explorer
Plug 'scrooloose/nerdtree', {'as': 'nerdtree'}
Plug 'Xuyuanp/nerdtree-git-plugin', {'as': 'nerdtree-git'}
Plug 'gabenespoli/vim-cider-vinegar', {'as': 'cider-vinegar'}

" Ranger console file manager integration
Plug 'francoiscabrol/ranger.vim', {'as': 'ranger'}
Plug 'rbgrouleff/bclose.vim', {'as': 'bclose'}

"extends mode keybindings to view contents of the registers
Plug 'junegunn/vim-peekaboo', {'as': 'peekaboo'}

" status/tabline line
Plug 'vim-airline/vim-airline', {'as': 'airline'}
"Plug 'itchyny/lightline.vim', {'as': 'lightline'}

if has('mac')
  Plug 'rizzatti/dash.vim', {'as': 'dash'}
  Plug 'itchyny/dictionary.vim', {'as': 'dictionary'}
  Plug 'koron/minimap-vim', {'as': 'minimap'}
  Plug 'junegunn/vim-xmark', {'as': 'xmark'}
endif


" Linting
if g:has_async
    Plug 'w0rp/ale' "ALE (Asynchronous Lint Engine)
    Plug 'prabirshrestha/async.vim'
    Plug 'prabirshrestha/vim-lsp' "async language server protocol
endif


" ================ Language extensions ================

Plug 'sheerun/vim-polyglot', {'as': 'polyglot'}

" ChucK audio programming language
Plug 'wilsaj/chuck.vim', {'as': 'chuck'}

" Git
Plug 'airblade/vim-gitgutter', {'as': 'gitgutter'}  "git diff information
Plug 'junegunn/gv.vim', {'as': 'gv'}                "a git commit browser
Plug 'tpope/vim-fugitive', {'as': 'fugitive'}       "an awesome git wrapper
Plug 'vim-scripts/gitignore'

" GraphQL
Plug 'jparise/vim-graphql', {'as': 'graphql'}

" HTML
Plug 'mattn/emmet-vim', {'as': 'emmet'} "Completion tool for HTML/CSS/JavaScript
Plug 'slim-template/vim-slim', {'as': 'slim'}
Plug 'mustache/vim-mustache-handlebars', {'as': 'mustache-handlebars'}

" JavaScript
Plug 'pangloss/vim-javascript', {'as': 'javascript'}
Plug 'elzr/vim-json', {'as': 'json'}
Plug 'mxw/vim-jsx', {'as': 'jsx'}

" Markdown
Plug 'plasticboy/vim-markdown', {'as': 'markdown'}

" Node.js
Plug 'moll/vim-node', {'as': 'node'}

" Ruby/Rails
Plug 'kurtpreston/vim-autoformat-rails', {'as': 'autoformat-rails'}
Plug 'jgdavey/vim-blockle', {'as': 'blockle'}
Plug 'tpope/vim-bundler', {'as': 'bundler'}
Plug 'tpope/vim-endwise', {'as': 'endwise'}
Plug 'tpope/vim-rails', {'as': 'rails'}
Plug 'tpope/vim-rake', {'as': 'rake'}
Plug 'tpope/vim-rbenv', {'as': 'rbenv'}
Plug 'ngmy/vim-rubocop', {'as': 'rubocop'}
Plug 'vim-ruby/vim-ruby', {'as': 'ruby'}
Plug 'ecomba/vim-ruby-refactoring', {'as': 'ruby-refactoring'}
Plug 'nelstrom/vim-textobj-rubyblock', {'as': 'rubyblock'}
Plug 'Keithbsmiley/rspec.vim', {'as': 'rspec'}

" TaskPaper
Plug 'davidoc/taskpaper.vim', {'as': 'taskpaper'}


" Initialize plugin system
call plug#end()
