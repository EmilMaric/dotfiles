" Vundle settings
" Use VIM improved enhancements for vim
set nocompatible 
filetype off

" Set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" Let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'Raimondi/delimitMate'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdtree'
Plugin 'majutsushi/tagbar'

" All of your Plugins must be added before the following line
call vundle#end()  
" Enable syntax highlighting
syntax on
" Load filetype-specific indent files
filetype plugin indent on

" Show line numbers
set number

" Always display the status line for every window
set laststatus=2

" Shows matching searches as you type
set incsearch

" The first tab completes as much as it can, second tab displays a list of
" options, and the third tab will present a list that allows you to scroll 
" through and select filenames beginning with that prefix.
set wildmode=longest:full,full
set wildmenu

" Highlight words matched in a search pattern set hlsearch
set hlsearch

" Open new vertical splits to the right and below of the current one
set splitright
set splitbelow 

" Set mapleader to be a comma
let mapleader=","

" Set backspace
set backspace=indent,eol,start

"  Monokai settings
colorscheme monokai

" Identify syntax highlighting group used at cursor
map <Leader>s :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
            \ . synIDattr(synID(line("."),col("."),0),"name"). "> lo<"
            \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" highlight cursor line and column
set cursorline

" Disable automatic comment insertion on newlines
" http://superuser.com/questions/271023/vim-can-i-disable-continuation-of-comments-to-the-next-line
" http://stackoverflow.com/questions/6076592/vim-set-formatoptions-being-lost
" autocmd BufNewFile,BufRead *.java setlocal formatoptions-=cro
au FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Set default indentation
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent

" Syntastic Setup
set statusline=%f\ %h%w%m%r\ 
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
set statusline+=%=%(%l,%c%V\ %=\ %P%)
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_python_python_exec = "/usr/local/bin/python3"
let g:syntastic_python_flake8_exec = 'python3'
let g:syntastic_python_flake8_args = ['-m', 'flake8']
let g:syntastic_python_checkers = ['flake8']

let g:NERDTreeStatusline = " "


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

" open/close folds with <Space>
nnoremap <space> za

" Open Tagbar
nnoremap <F8> :TagbarToggle<CR>
