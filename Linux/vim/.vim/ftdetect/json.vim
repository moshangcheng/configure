autocmd BufNewFile,BufRead *.json set filetype=json
autocmd BufNewFile,BufRead *.jsonp set filetype=json
autocmd BufNewFile,BufRead *.gyp set filetype=json


" format JSON
set autoread
nmap <C-S-F> : !underscore print -i % -o %<CR><CR>
