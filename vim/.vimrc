" Include the system settings
 if filereadable( "/etc/vimrc" )
    source /etc/vimrc
 endif

" Vundle settings
set nocompatible		" use VIM improved enhancements for vim
filetype off			" required for Vundle

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/syntastic'
" Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}

" All of your Plugins must be added before the following line
call vundle#end()  


filetype plugin indent on	" load filetype-specific indent files
"syntax on			        " enable syntax processing
syntax enable
set number			        " show line numbers
" set showcmd			        " show command in bottom bar

" shows row and column number at bottom right
set ruler

" Add custom font
set guifont=Menlo\ Regular:h12

" Shows matching searches as you type
set incsearch

" Auto indentation using the definitions in vim73/
set autoindent
set shiftwidth=4
set expandtab
set smarttab

" The first tab completes as much as it can, second tab displays a list of
" options, and the third tab will present a list that allows you to scroll 
" through and select filenames beginning with that prefix.
set wildmode=longest:full,full
set wildmenu

set showmatch			    " highlight matching parantehsis/brackets/braces
set hlsearch			    " highlight words matched in a search pattern
set splitright                      " open new vertical splits to the right of the current one
let mapleader=","		    " set mapleader to be a comma
set laststatus=2                    " show the status bar for every window
set backspace=indent,eol,start
set shiftround			" use a multiple of shiftwidth when indenting with '<' and '>'

"  Monokai settings
colorscheme monokai
"colorscheme molokai

" Settings to turn on solarized colorscheme
" set background=dark
" colorscheme solarized

" Identify syntax highlighting group used at cursor
map <Leader>s :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
         \ . synIDattr(synID(line("."),col("."),0),"name"). "> lo<"
         \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" Change the colors of the suggestion menu for YouCompleteMe
highlight Pmenu cterm=bold ctermfg=0 ctermbg=7 guifg=#ffffff guibg=#0000ff

" Point YCM to correct python interpreter
let g:ycm_path_to_python_interpreter = '/usr/local/bin/python'
" Set default .ycm_extra_conf.py for C/C++/ObjC checking
let g:ycm_global_ycm_extra_conf = '~/.vim/ycm.py'
let g:ycm_extra_conf_vim_data = ['&filetype']

" Enable true-colors for Neovim
"let $NVIM_TUI_ENABLE_TRUE_COLOR=1 " True gui colors in terminal

" Syntastic plugin settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_enable_signs = 1
let g:syntastic_check_on_wq = 0

" Set syntastic python check to use flake8
let g:syntastic_python_checkers = ['flake8']

" Add a coloured line to the right, to avoid going too far to the right
set colorcolumn=80

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MAPPINGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>

" easier split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" quick-capitalization
inoremap <leader>u <esc>viwU<esc>viw<esc>
nnoremap <leader>u viwU<esc>viw<esc>

" splits current window and opens up .vimrc in new window 
nnoremap <leader>ev :vsplit $MYVIMRC<cr>

" shortcut to source .vimrc
nnoremap <leader>sv :source $MYVIMRC<cr>

" surround current word with single/double quotes
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>el
nnoremap <leader>' viw<esc>a'<esc>bi'<esc>el

" add new line without going into insert mode
nnoremap <leader>o o<esc><up>
nnoremap <leader>O O<esc><down>
