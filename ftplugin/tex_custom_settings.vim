set wrap linebreak
let &showbreak="\u21aa"
inoremap <buffer> <Leader>* *
inoremap <buffer> * \cdot
map <buffer> <Leader>tt <esc>Bi\texttt{<esc>Ea}<esc>
map <buffer> <Leader>bb <esc>Bi\textbf{<esc>Ea}<esc>
map <buffer> <Leader>ii <esc>Bi\textit{<esc>Ea}<esc>
