" Include the system settings
:if filereadable( "/etc/vimrc" )
   source /etc/vimrc
:endif

" Put your own customizations below

" PLUGINS (provided by Vim-Plug) {
   call plug#begin()
   Plug 'henrik/vim-indexed-search' " show number of matches in search
   Plug 'easymotion/vim-easymotion' " easier way to use motions
   Plug 'itchyny/lightline.vim' " nicer status bar
   Plug 'sjl/badwolf' " badwolf colorscheme
   call plug#end()
" }

" GENERAL {
   filetype plugin indent on " load filetype-specific plugins/indent settings
   syntax enable " enable syntax highlighting
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
   let mapleader="\<Space>" " set mapleader to be a comma
   match WarningMsg '\s\+$' " show/highlight trailing spaces and tabs

   " Disable automatic comment insertion on new lines
   au FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" }

" MAPPINGS {
   " turn of search highlight
   nnoremap <leader><space> :nohlsearch<CR>

   " identify syntax highlighting group used at cursor
   map <Leader>s :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
               \ . synIDattr(synID(line("."),col("."),0),"name"). "> lo<"
               \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

   " easymotion mappings
   " jump to anywhere you want with `s{char}{label}`
   nmap s <Plug>(easymotion-f)
   nmap S <Plug>(easymotion-F)
   nmap t <Plug>(easymotion-fl)
   nmap T <Plug>(easymotion-Fl)
   " JK motions: line motions
   map <Leader>j <Plug>(easymotion-j)
   map <Leader>k <Plug>(easymotion-k)
" }

" UI {
   set t_ut= " tell vim to extend the color scheme's background color across
             " the whole terminal screen
   colorscheme badwolf " colorscheme name
   set laststatus=2 " Always display the status line for every window
   set colorcolumn=86 " display a colored bar at column 86
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
" }

