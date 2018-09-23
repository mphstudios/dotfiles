"
" NERDTree Settings
"
let NERDTreeAutoDeleteBuffer=1  "automatically delete buffer for deleted file
let NERDTreeDirArrows=1
let NERDTreeHijackNetrw=1       "use the split explorer model like netrw
let NERDTreeMinimalUI=1         "hide message “Press ? for help”
let NERDTreeShowHidden=1        "show hidden files by default
let NERDTreeQuitOnOpen=1        "automatically close nerdtree on file open

let NERDTreeIgnore=['\.DS_Store', '\.swp', '\~$']

nnoremap <Leader>t :NERDTreeToggle<Enter>
nnoremap <silent> <Leader><Leader> :NERDTreeFind<CR>

" local map <Space> to expand/colapse hierarchy || open file
" local map h collapse
" local map l expand
" local map <D-A-LEFT> collapse
" local map <D-A-RIGHT> expand

" autocmd FileType nerdtree nmap <buffer> <left> u

" Open a NERDTree automatically when vim starts
"autocmd vimenter * NERDTree
