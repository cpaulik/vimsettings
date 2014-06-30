" map F5 and F6 to python run in vim buffer
map <buffer> <F5> <esc>:wa<CR>:Shell python %<CR>
map <buffer> <F6> <esc>:wa<CR>:silent !tmux break-pane -t right -d<CR>:silent !tmux split-window -h -t right -l 80<CR>:silent !tmux send-keys -t right "source setup_env" C-m<CR>:silent !tmux send-keys -t right "python %" C-m<CR>

" map button to open an ipython console for trying things out
map <buffer> <F4> <esc>:wa<CR>:silent !tmux split-window -v -t bottom -l 20<CR>:silent !tmux send-keys -t bottom "source setup_env" C-m<CR>:silent !tmux send-keys -t bottom "ipython" C-m<CR>

" Settings for jedi-vim and supertab
let g:jedi#goto_definitions_command='gd' 
let g:jedi#documentation_command='<Leader>d'
let g:jedi#usages_command='<Leader>u'
let g:jedi#popup_on_dot = 0
let g:jedi#popup_select_first = 0
let g:jedi#completions_command = ''
let g:jedi#use_tabs_not_buffers = 0
let g:jedi#use_splits_not_buffers = 'right'
let g:jedi#completions_enabled = 0

"set shortcut for enable/disable showing of call signature
"default is on
let g:jedi#show_call_signatures = '1'
imap <buffer> <Leader>ss <esc>:let g:jedi#show_call_signatures = '1'<CR>a
imap <buffer> <Leader>s <esc>:let g:jedi#show_call_signatures = '0'<CR>a

map <buffer> <Leader>b Oimport ipdb; ipdb.set_trace() # BREAKPOINT<C-c>

"autocomment a line and go to next line
nmap <buffer> <Leader># I# <esc>j
"comment a paragraph
nmap <buffer> <F7> üj^h<c-v>äkA# <esc>
"uncomment a paragraph
nmap <buffer> <F8> üj^<c-v>äkf#ld

"add a import
map <buffer> <Leader>ai <esc>?import<CR>oimport 

" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
finish
endif
let b:did_ftplugin = 1
set nowrap
"set colorcolumn=80
highlight ColorColumn ctermbg=233
call matchadd('ColorColumn', '\%80v', 100)

map <buffer> <S-e> :w<CR>:!/usr/bin/env python % <CR>
map <buffer> cf ?def <CR>

set foldmethod=expr
set foldexpr=PythonFoldExpr(v:lnum)
set foldtext=PythonFoldText()

map <buffer> <Leader>f za
map <buffer> <Leader>F :call ToggleFold()<CR>
let b:folded = 1

function! ToggleFold()
    if( b:folded == 0 )
        exec "normal! zM"
        let b:folded = 1
    else
        exec "normal! zR"
        let b:folded = 0
    endif
endfunction

function! PythonFoldText()

    let size = 1 + v:foldend - v:foldstart
    if size < 10
        let size = " " . size
    endif
    if size < 100
        let size = " " . size
    endif
    if size < 1000
        let size = " " . size
    endif
    
    if match(getline(v:foldstart), '"""') >= 0
        let text = substitute(getline(v:foldstart), '"""', '', 'g' ) . ' '
    elseif match(getline(v:foldstart), "'''") >= 0
        let text = substitute(getline(v:foldstart), "'''", '', 'g' ) . ' '
    else
        let text = getline(v:foldstart)
    endif
    
    return size . ' lines:'. text . ' '

endfunction

function! PythonFoldExpr(lnum)

    if indent( nextnonblank(a:lnum) ) == 0
        return 0
    endif
    
    if getline(a:lnum-1) =~ '^\(class\|def\)\s'
        return 1
    endif
        
    if getline(a:lnum) =~ '^\s*$'
        return "="
    endif
    
    if indent(a:lnum) == 0
        return 0
    endif

    return '='

endfunction

" In case folding breaks down
function! ReFold()
    set foldmethod=expr
    set foldexpr=0
    set foldnestmax=1
    set foldmethod=expr
    set foldexpr=PythonFoldExpr(v:lnum)
    set foldtext=PythonFoldText()
    echo 
endfunction

