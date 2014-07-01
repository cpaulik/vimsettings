set wrap linebreak
let &showbreak="\u21aa"
inoremap <buffer> <Leader>* *
inoremap <buffer> * \cdot
map <buffer> <Leader>tt <esc>Bi\texttt{<esc>Ea}<esc>
map <buffer> <Leader>bb <esc>Bi\textbf{<esc>Ea}<esc>
map <buffer> <Leader>ii <esc>Bi\textit{<esc>Ea}<esc>
" change to 2 for latex buffers
setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2
