" set a colored bar at line 80
set colorcolumn=80

" Use the below highlight group when displaying bad whitespace is desired.
highlight BadWhitespace ctermbg=red guibg=red

" Set encoding to UTF8
set encoding=utf-8

" NERDTree -----------------------------
" auto open or close NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
autocmd vimenter * NERDTree
autocmd VimEnter * wincmd p
" toggle nerdtree display
noremap <C-n> :NERDTreeToggle<CR>
" don;t show these file types
let NERDTreeIgnore = ['\.pyc$', '\.pyo$']
