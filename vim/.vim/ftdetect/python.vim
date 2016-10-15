augroup PythonGroup
	autocmd!
	au BufNewFile,BufRead *.py set filetype=python | match BadWhitespace /\s\+$/
augroup END
