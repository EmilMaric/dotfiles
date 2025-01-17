" PLUGINS (provided by Vim-Plug) {
   call plug#begin( $HOME . '/.vim/plugged' )
   Plug 'easymotion/vim-easymotion' " easier way to use motions
   Plug 'itchyny/lightline.vim' " nicer status bar
   Plug 'mkalinski/vim-lightline_tagbar'  " add tagbar info to lightline statusbar
   Plug 'majutsushi/tagbar' " show file tags on the side
   Plug 'ap/vim-css-color' " colourize hex colors
   Plug 'google/vim-searchindex' " show number of matches in search
   Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
   Plug 'junegunn/fzf.vim' " Fuzzy finder for searching files
   Plug 'mhinz/vim-signify' " use the vim gutter to display which lines have changed
   Plug 'scrooloose/nerdcommenter' " powerful commenting plugin
   Plug 'joshdick/onedark.vim' " colorscheme mimicing the atom editor colorscheme
   call plug#end()
" }

" GENERAL {
   filetype plugin indent on " load filetype-specific plugins/indent settings
   set termguicolors " Use 24-bit colors in term buffers
   syntax on " enable syntax highlighting
" }

" EDITING {
   set expandtab " use spaces instead of tabs
   set incsearch " show matching searches as you type
   set hlsearch " highlight words matched in a search pattern
   set number " show line numbers
   set wildmenu " turn on command line completion wild style
   set wildmode=list:longest,list:full " The first tab completes as much as it can
                                       " and shows a list of options, second
                                       " tab starts autocompleting options
   set splitright " open new vertical splits to the right of the current one
   set splitbelow " open new splits below the current one
   let mapleader="\<Space>" " set mapleader to be a space
   " Disable automatic comment insertion on new lines
   au FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
   " When git buffers like gitcommit are closed, delete the buffer
   " This helps with neovim-remote, where the terminal is waiting for the buffer to
   " be deleted
   autocmd FileType gitcommit,gitrebase,gitconfig set bufhidden=delete
" }

" GENERAL MAPPINGS {
   " turn of search highlight
   nnoremap <leader><space> :nohlsearch<CR>

   " identify syntax highlighting group used at cursor
   map <Leader>s :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name")
               \ . '> trans<' . synIDattr(synID(line("."),col("."),0),"name")
               \ . "> lo<"
               \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name")
               \ . ">"<CR>
" }

" UI {
   set t_ut= " tell vim to extend the color scheme's background color across
             " the whole terminal screen

   " Add custom highlighting here since the colorscheme will override/clear it
   augroup custom-highlighting
      au!

      " show/highlight trailing spaces and tabs
      autocmd ColorScheme * call onedark#set_highlight(
         \ "RedundantSpaces", { "bg": { "cterm": "red", "gui": "red" }})
      autocmd ColorScheme * match RedundantSpaces /\s\+$/
   augroup END

   let g:onedark_terminal_italics=1 " italicize comments
   colorscheme onedark " colorscheme name

   set laststatus=2 " Always display the status line for every window
   set colorcolumn=80 " display a colored bar at column 80
" }

" NEOVIM {
   " Switch between splits using Ctrl + [hjkl]
   nnoremap <C-h> <C-\><C-n><C-w>h
   nnoremap <C-j> <C-\><C-n><C-w>j
   nnoremap <C-k> <C-\><C-n><C-w>k
   nnoremap <C-l> <C-\><C-n><C-w>l
   tnoremap <C-h> <C-\><C-n><C-w>h
   tnoremap <C-j> <C-\><C-n><C-w>j
   tnoremap <C-k> <C-\><C-n><C-w>k
   tnoremap <C-l> <C-\><C-n><C-w>l

   set noshowcmd " Don't display keystrokes in statusline
" }

" TAGBAR PLUGIN {
   " toggle tagbar
   nmap <Leader>t :TagbarToggle<CR>
" }

" LIGHTLINE PLUGIN {
   let g:lightline = {
      \ 'colorscheme': 'onedark',
      \ 'component_function': {
      \         'tagbar': 'lightline_tagbar#component',
      \ },
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename', 'tagbar', 'modified' ] ]
      \ },
      \ }
" }

" EASYMOTION PLUGIN {
   let g:EasyMotion_do_mapping = 0 "disable default easymotion mappings
   let g:EasyMotion_smartcase = 1 " turn on case insensitive feature
   let g:EasyMotion_do_shade = 1 " disable EasyMotion text shading
   let g:EasyMotion_use_upper = 1 " show target labels with uppercase letters
   let g:EasyMotion_keys = 'ASDGHKLQWERTYUIOPZXCVBNMFJ;' " labels to use for targets

   " highlighting target with 1 label
   hi EasyMotionTarget ctermbg=darkred ctermfg=white
   " highlighting target with 2 labels - 1st label
   hi EasyMotionTarget2First ctermbg=darkred ctermfg=white
   " highlighting target with 2 labels - 2nd label
   hi EasyMotionTarget2Second ctermbg=darkred ctermfg=white

   " mappings; jump to anywhere you want with `s{char}{label}`
   nmap s <Plug>(easymotion-f)
   nmap S <Plug>(easymotion-F)
   nmap t <Plug>(easymotion-fl)
   nmap T <Plug>(easymotion-Fl)

   " JK motions: line motions
   nmap <Leader>j <Plug>(easymotion-j)
   nmap <Leader>k <Plug>(easymotion-k)
" }

" VIM-SIGNIFY PLUGIN {
   let g:signify_vcs_list = [ 'git' ] " we use perforce as our VCS

   " update the signs more quickly
   set updatetime=100
" }

" NERDCOMMENTER PLUGIN {
   " Add spaces after comment delimiters by default
   let g:NERDSpaceDelims = 1
" }

" FZF PLUGIN {
   " Map CTRL + F to search for files
   nnoremap <C-F> :Files<CR>
" }
