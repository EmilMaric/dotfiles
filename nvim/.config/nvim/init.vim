" PLUGINS (provided by Vim-Plug) {
   call plug#begin()
   Plug 'easymotion/vim-easymotion' " easier way to use motions
   Plug 'itchyny/lightline.vim' " nicer status bar
   Plug 'mkalinski/vim-lightline_tagbar'  " add tagbar info to lightline statusbar
   Plug 'majutsushi/tagbar' " show file tags on the side
   Plug 'ap/vim-css-color' " colourize hex colors
   Plug 'google/vim-searchindex' " show number of matches in search
   Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
   Plug 'junegunn/fzf.vim'
   Plug 'mhinz/vim-signify' " use the git gutter to display which lines have changed
   Plug 'octol/vim-cpp-enhanced-highlight' " adds function/class highlighting for C++
   Plug 'scrooloose/nerdcommenter' " powerful commenting plugin
   Plug 'joshdick/onedark.vim' " colorscheme mimicing the atom editor colorscheme
   Plug 'sheerun/vim-polyglot' " a collection of language packs for Vim
   "Plug 'dhruvasagar/vim-zoom'
   call plug#end()
" }

" GENERAL {
   filetype plugin indent on " load filetype-specific plugins/indent settings
   syntax on " enable syntax highlighting
" }

" EDITING {
   set expandtab " use spaces instead of tabs
   set incsearch " show matching searches as you type
   set hlsearch " highlight words matched in a search pattern
   set number " show line numbers
   set wildmode=longest:full,full " The first tab completes as much as it can
                                  " second tab displays a list of options,
                                  " and the third tab will present a list that
                                  " allows you to scroll through and select
                                  " filenames beginning with that prefix
   set wildmenu " turn on command line completion wild style
   set splitright " open new splits to the right of the current one
   set splitbelow " open new splits below the current one
   set expandtab " use spaces instead of tabs
   set tabstop=4 " number of spaces that a <Tab> in a file counts for
   set shiftwidth=4 " number of spaces to use when indenting with '>' key
   let mapleader="\<Space>" " set mapleader to be a spacebar
   match Error '\s\+$' " show/highlight trailing spaces and tabs

   " Disable automatic comment insertion on new lines
   au FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
" }

" GENERAL MAPPINGS {
   " turn of search highlight
   nnoremap <leader><space> :nohlsearch<CR>

   " identify syntax highlighting group used at cursor
   map <Leader>s :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") .
                           \ '> trans<' .
                           \ synIDattr(synID(line("."),col("."),0),"name") .
                           \ "> lo<" .
                           \ synIDattr(synIDtrans(synID(line("."),col("."),1)),
                           \           "name") . ">"<CR>
" }

" UI {
   set t_ut= " tell vim to extend the color scheme's background color across
             " the whole terminal screen

   set termguicolors " Use 24-bit (true-color) mode
   let g:onedark_terminal_italics=1 " italicize comments
   colorscheme onedark " colorscheme name

   set laststatus=2 " Always display the status line for every window
   set colorcolumn=86 " display a colored bar at column 86
   set cursorline
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

   " Use <ESC> in a terminal buffer to enter 'normal-mode'
   au TermOpen * let b:termmode = 1
   tnoremap <Esc> <C-\><C-n>:let b:termmode = 0<CR>

   " Automatically enter 'term-mode' if we previously left off from term-mode
   " The same applies for 'normal-mode'
   function! MaybeStartTermMode()
      if b:termmode == 1
        startinsert
      endif
   endfunction
   function! TermNormalMappings()
      nnoremap <buffer> i :let b:termmode = 1<CR>i
      nnoremap <buffer> a :let b:termmode = 1<CR>a
   endfunction
   au TermOpen * setlocal nonumber | startinsert | call TermNormalMappings()
   au BufEnter term://* call MaybeStartTermMode()

   " close terminal buffer without showing the exit status of the shell
   au TermClose * call feedkeys("\<cr>")
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
   let g:EasyMotion_do_shade = 0 " disable EasyMotion text shading
   let g:EasyMotion_use_upper = 1 " show target labels with uppercase letters
   let g:EasyMotion_keys = 'ASDGHKLQWERTYUIOPZXCVBNMFJ;' " labels to use for targets

   " highlighting target with 1 label
   hi EasyMotionTarget ctermbg=darkred ctermfg=white
   "hi EasyMotionTarget ctermbg=darkred ctermfg=white 
   " highlighting target with 2 labels - 1st label
   hi EasyMotionTarget2First ctermbg=darkred ctermfg=white
   " highlighting target with 2 labels - 2nd label
   hi EasyMotionTarget2Second ctermbg=darkred ctermfg=white

   " mappings; jump to anywhere you want with `s{char}{label}`
   " nnoremap s <Plug>(easymotion-f)
   nmap s <Plug>(easymotion-f)
   nmap S <Plug>(easymotion-F)
   nmap t <Plug>(easymotion-fl)
   nmap T <Plug>(easymotion-Fl)
   " JK motions: line motions
   nmap <Leader>j <Plug>(easymotion-j)
   nmap <Leader>k <Plug>(easymotion-k)
" }

" VIM-SIGNIFY PLUGIN {
   let g:signify_vcs_list = [ 'perforce' ] " we use perforce as our VCS
   " use the following command to generate the diff
   let g:signify_vcs_cmds = {
       \ 'perforce': 'a4 diff -du 0 %f'
       \ }

   " by default the colors for the symbols in the git gutter are messed up,
   " change them up manually
   highlight DiffAdd           cterm=bold ctermbg=none ctermfg=119
   highlight DiffDelete        cterm=bold ctermbg=none ctermfg=167
   highlight DiffChange        cterm=bold ctermbg=none ctermfg=227
" }

" NERDCOMMENTER PLUGIN {
   " Add spaces after comment delimiters by default
   let g:NERDSpaceDelims = 1

   " Add your own custom formats or override the defaults
   let g:NERDCustomDelimiters = { 'tin': { 'left': '//' } }
" }

" FZF PLUGIN {
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number ' .
                        \ '--no-heading --fixed-strings --ignore-case --hidden ' .
                        \ '--follow --color "always" ' .
                        \ shellescape(<q-args>), 1, <bang>0)
" }
