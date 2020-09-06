" Keep this at the top since we need it before loading filetype plugins
set runtimepath^=$HOME/.vim/
set runtimepath+=~/.vim/after
set runtimepath+=/usr/share/vim/vimfiles/
let &packpath=&runtimepath

" Source most settings from vimrc
:if filereadable( $HOME . "/.vimrc" )
   source $HOME/.vimrc
:endif

" NEOVIM {
   " Navigate to and from the terminal buffers easier
   tnoremap <C-h> <C-\><C-n><C-w>h
   tnoremap <C-j> <C-\><C-n><C-w>j
   tnoremap <C-k> <C-\><C-n><C-w>k
   tnoremap <C-l> <C-\><C-n><C-w>l

   " Shortcut for scrolling in the terminal
   tnoremap <silent> <Esc><Esc> <C-\><C-n>:let b:termmode = 0<CR>

   function! MaybeStartTermMode()
      if b:termmode == 1
        startinsert
      endif
   endfunction

   function! TermNormalMappings()
      nnoremap <silent> <buffer> i :let b:termmode = 1<CR>i
      nnoremap <silent> <buffer> a :let b:termmode = 1<CR>a
   endfunction

   aug Term
      au!
      " Start neovim-terminal without number gutter and in INSERT mode
      au TermOpen * setlocal nonumber | startinsert
      " Automatically enter 'term-mode' if we previously left off from term-mode
      " The same applies for 'normal-mode'
      au TermOpen * call TermNormalMappings()
      " When switching buffer focus back to the terminal buffer, use the mode that
      " you left off from (either NORMAL mode or INSERT mode)
      au TermOpen * let b:termmode=1
      au BufEnter term://* call MaybeStartTermMode()
      " close terminal buffer without showing the exit status of the shell
      au TermClose * call feedkeys("\<cr>")
   aug END
" }

