
let mapleader=","

" Leader Mappings
map <Comma> <Leader>
map <Space> <Leader>
map <Leader>w :update<CR>
map <Leader>q :qall<CR>
map <Leader>gs :Gstatus<CR>

map <D-A-LEFT> <C-w>h
map <D-A-RIGHT> <C-w>l
map <D-A-DOWN> <C-w><C-w>
map <D-A-UP> <C-w>W

" Leader C is the prefix for code related mappîngs
noremap <silent> <Leader>cc :TComment<CR>

" Leader B for buffer related mappings
nnoremap <silent> <Leader>bb :CtrlPBuffer<CR>     "cycle through buffers
nnoremap <silent> <Leader>bn :bn<CR>              "(N)ew buffer
nnoremap <silent> <Leader>bd :bdelete<CR>         "(D)elete current buffer
nnoremap <silent> <Leader>bu :bunload<CR>         "(U)nload current buffer
nnoremap <silent> <Leader>bl :setnomodifiable<CR> "(L)ock current buffer

" Leader F is for file related mappîngs (open, browse...)
nnoremap <silent> <Leader>fb :CtrlP<CR>
nnoremap <silent> <Leader>fm :CtrlPMRU<CR>

" Reloads Vim configuration
map <silent> <Leader>ve :vsp $MYVIMRC<CR>
map <silent> <Leader>vr :source $MYVIMRC<CR>
                       \:PlugInstall<CR>
                       \:bdelete<CR>
                       \:exe ":echo '.vimrc reloaded'"<CR>

" Save (s)ession, reopen it with vim -S
nnoremap <Leader>s :mksession<CR>

nmap <silent> <Leader>ws :set nolist!<CR>

" move normally between wrapped lines
nmap j gj
nmap k gk

" move to beginning/end of line
nnoremap B ^
nnoremap E $

" highlight last inserted text
nnoremap gV `[v`]

" Auto-indent pasted text
nnoremap p p=`]<C-o>
nnoremap P P=`]<C-o>

" Cancel search using Escape
nnoremap <silent> <Leader><Leader> :nohlsearch<Bar>:echo<CR>

" netrw file explorer
nnoremap <Leader>x   :Lexplore<CR>
nnoremap <Leader>sx  :Sexplore<CR>

" Configure HighlightYank for Vim pre 8.0.1394
if !exists('##TextYankPost')
  map y <Plug>(highlightedyank)
endif

" sudo write file
cmap w!! %!sudo tee > /dev/null %
