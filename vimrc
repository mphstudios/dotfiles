"
" Vim settings
"

" Enable Vim features which are not Vi compatible.
" This must be set first because it changes the behavior of other options.
if &compatible
  set nocompatible
end

" Install plugins first as settings here may depend on plugins.
if filereadable($HOME . "/.vim/bundles.vim")
  source ~/.vim/bundles.vim
endif

" Loading key mappings
if filereadable($HOME . "/.vim/mappings.vim")
  source ~/.vim/mappings.vim
endif

syntax on                 "enable syntax processing
filetype indent plugin on "auto-detect filetypes

" % matches on if/else, html tags, et cetera
runtime! macros/matchit.vim


" ================= General Config ====================

set autochdir             "change working directory automatically
set autoread              "auto-reload files changed outside Vim
set autowrite             "automatically :write before running commands
set backspace=indent,eol,start "allow backspace in insert mode
set clipboard=unnamed     "clipboard support on macOS
" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set cmdheight=2           "increase command prompt height
set confirm               "prompt to save file when there are unsaved changes
set diffopt+=vertical     "always use vertical diffs
set encoding=utf-8
set foldenable            "enable code folding
set foldlevelstart=10     "start with most folds open by default
set foldmethod=indent     "fold based on indent level
set foldnestmax=10
set hid                   "hide buffers when when they are abandoned
set hidden                "allow switching edited buffers without saving
set history=1000
set laststatus=2          "show the statusline even with only one window open
set lazyredraw            "do not redraw while executing macros
set mat=7                 "blink duration in 1/10s when matching brackets
set modelines=0           "disable reading modelines for security
set mouse=a               "enable mouse
set nojoinspaces          "use one space, not two, after punctuation
set nostartofline         "keep the cursor on the same column when jumping lines
set timeoutlen=300        "timeout on key combinations in milliseconds
set title                 "automaticly set title for terminals
set ttyfast

set splitbelow splitright

set noerrorbells
set visualbell            "blink cursor on error instead of beeping

" Quickly time out on keycodes, but never time out on mappings
"set notimeout ttimeout ttimeoutlen=200

" TAB-completion
set wildmenu                        "show possible autocompletions in statusline
set wildmode=list:longest,list:full "complete only up to the point of ambiguity

" ignored files/directories for autocomplete (and CtrlP)
set wildignore+=*/tmp/*
set wildignore+=*.so
set wildignore+=*.zip
set wildignore+=*/node_modules/
set wildignore+=*/vendor/bundle/*

set colorcolumn=80
set cursorline            "highlight current line in the active window
set number                "show line numbers
set ruler                 "show current position
set scrolloff=5           "keep n lines of context around the cursor
set showcmd               "show incomplete commands in the statusline
set showmode              "show current mode in the statusline
set signcolumn=yes        "reserve column for signs
set textwidth=80

set list                  "display end-of-line and white space characters
set listchars=extends:→   "show right arrow when a line continues rightwards
set listchars+=precedes:← "show left arrow when a line continues leftwards
set listchars+=nbsp:.,tab:»·,trail:·


" ================= Search Settings ===================

set hlsearch              "highlight search results
set ignorecase smartcase  "ignore case when the search pattern is all lowercase
set incsearch             "search as characters are entered
set showmatch             "show matching brackets and parenthesis
set tags=tags;~/          "look for files in the current directory first


" ============ Backup/Swap/Undo files =================
" Directories ending with // will have file names built from the complete
" path to the file with all path separators substituted with the percent sign
" to ensure that all file names are unique in the preserve directory.
set backup
set backupdir=$HOME/.vim/backup//,/var/tmp//,/tmp//
set backupskip=/tmp/*,/private/tmp/*
set directory=$HOME/.vim/temp//,/var/tmp//,/tmp//
set writebackup

" Keep undo history across sessions by storing in file.
if has('persistent_undo')
  silent !mkdir $HOME/.vim/undo > /dev/null 2>&1
  set undodir=$HOME/.vim/undo//
  set undofile
  set undolevels=1000
  set undoreload=1000
endif

" Disable writing backup, swap, undo files
"set nobackup nowritebackup noswapfile noundofile


" ================= Indentation =======================
filetype indent on "load filetype-specific indent files

set autoindent
set copyindent      "copy the previous indentation on autoindent
set expandtab       "use spaces instead of tabs
set shiftround      "use multiples of shiftwidth when indenting with '<' and '>'
set shiftwidth=2    "number of spaces to use for autoindenting
set smartindent
set smarttab        "insert tabs according to shiftwidth not tabstop
set softtabstop=2   "number of spaces per <TAB> *when editing*
set tabstop=2       "number of spaces per <TAB>


" ================= Line-wrap =========================

set breakindent
set breakindentopt=sbr
set linebreak         "wrap lines at convenient points
set showbreak=↪\      "unicode curly array with a <backslash><space>
set sidescroll=1      "minimal number of columns to scroll horizontally
set sidescrolloff=10  "keep n columns of context afte the cursor
set wrap              "wrap lines


" ================= Spell-Check =======================
" Set spellfile to a location that is guaranteed to exist.
" Note the file name must end in `.{encoding}.add`
" where {encoding} is the character encoding of the file.
set spellfile=$HOME/.vim/spell.en.utf-8.add
set spelllang=en

" autocomplete with dictionary  when spell check is on
set complete+=kspell


" ================= GUI Configuration =================

if has('gui_running')
    set backupcopy=yes "prevent Finder file labels from disappearing when saving
    set guifont=OfficeCodeProD-Light:h16
    set macligatures
    set guioptions-=T  "hide toolbar
    set transparency=10
    colorscheme dracula
else
    " Issue https://github.com/francoiscabrol/ranger.vim/issues/32
    let g:ranger_replace_netrw=1 " open ranger when opening a directory
endif


" ================ Vim file explorer ==================

let g:netrw_altv=1                  "right split
let g:netrw_banner=0                "remove file explorer banner
let g:netrw_list_hide=&wildignore   "inherit from wildignore setting
let g:netrw_liststyle=3             "tree style listing
let g:netrw_sizestyle="H"           "human-readable (i.e. 5K, 4M, 3G) 1024 base
let g:netrw_winsize=30              "width of explorer window as a percent

" 0: re-using the same window  (default)
" 1: horizontally splitting the window first
" 2: vertically splitting the window first
" 3: open file in new tab
" 4: open previous window
let g:netrw_browse_split=0


" ================= Autorun Commands ==================

autocmd BufWritePre * :%s/\s\+$//e  "remove white-space on save
autocmd FocusLost * silent! wa      "auto-save file
autocmd VimResized * wincmd =       "auto-resize splits when resizing window

