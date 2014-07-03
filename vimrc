let mapleader = ","
" Pathogen load
filetype off

call pathogen#infect()
call pathogen#helptags()

filetype plugin indent on
syntax on

" enable hiding of buffers
set hidden

" remove waiting time after leaving insert mode
set ttimeoutlen=50
" Showing line numbers and length
set number
set tw=79
set nolist
set fo-=t
set cul

" Disable backup and swap files
set nobackup
set nowritebackup
set noswapfile

" Useful settings
set history=700
set undolevels=700

" better searching
set incsearch
set ignorecase
set smartcase
set hlsearch
nmap <Leader>7 :nohlsearch<CR>

"mapping for inserting brackets and typing inside them
inoremap [[ []<esc>i
inoremap (( ()<esc>i
inoremap {{ {}<esc>i

"mapping for stepping visual lines
nnoremap j gj
nnoremap k gk
nnoremap 0 g0
nnoremap ß g$

nnoremap <CR><CR> i<CR><esc>

"remap end of line
map ß $

nnoremap <Leader>f za
"enter insert mode when pressing the space bar
nnoremap <space> i<space>

"insert empty line without going into insert mode
nmap <Leader>o o<esc>k
nmap <Leader>O O<esc>j

noremap <c-j> <c-w>j
noremap <c-k> <c-w>k
noremap <c-l> <c-w>l:vertical res 110<CR>:AirlineToggle<CR>:AirlineToggle<CR>
noremap <c-h> <c-w>h:vertical res 110<CR>:AirlineToggle<CR>:AirlineToggle<CR>

" Faster saving
map <Leader>w <esc>:w<CR>
map <Leader>ww <esc>:w<CR>:bd<CR>

" Easier movement on german keyboard and autocenter
noremap ü {
noremap ä }
"jump to matching brackets
noremap ö %zz
vnoremap ö %zz
nmap G Gzz
nmap n nzz
nmap m mzz

"format a paragraph with visual gqq
nnoremap <Leader>p {v}gq

"map ctrlp for buffers
nmap <Leader>b :CtrlPBuffer<CR>

" Faster closing of buffers
nnoremap <Leader>c <esc>:bn<CR>:bd#<CR>

" Automatic reloading of .vimrc
autocmd! bufwritepost * source ~/.vimrc

" Automatic removal of trailing whitespace in files
autocmd BufWritePre <buffer> :%s/\s\+$//e

" Mouse and backspace
set mouse=a
set bs=2

" airline fonts
let g:airline_powerline_fonts=1
let g:Powerline_symbols = 'fancy'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#virtualenv#enabled = 1


"set rtp+=~/vimide/powerline/powerline/bindings/vim
" easier moving between buffers 
nmap <Leader>n <esc>:bn<CR>
nmap <Leader>m <esc>:bp<CR>

:au WinEnter * :set winfixheight
:au WinEnter * :wincmd =

" easier moving of code blocks
" " Try to go into visual mode (v), thenselect several lines of code here and
" " then press ``>`` several times.
vnoremap < <gv
vnoremap > >gv

set t_Co=256
color wombat256mod
let g:airline_theme='dark'
" Real programmers don't use TABs but spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab
set nowrap
set autoindent
set copyindent

set laststatus=2

" Settings for ctrlp
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=*/coverage/*

let g:SuperTabDefaultCompletionType = "context"
"
" " Better navigating through omnicomplete option list
" " See
" http://stackoverflow.com/questions/2170023/how-to-map-keys-for-popup-menu-in-vim
set completeopt=longest,menuone
function! OmniPopup(action)
    if pumvisible()
        if a:action == 'j'
            return "\<C-N>"
        elseif a:action == 'k'
            return "\<C-P>"
        endif
    endif
    return a:action
endfunction
"
inoremap <silent><C-j> <C-R>=OmniPopup('j')<CR>
inoremap <silent><C-k> <C-R>=OmniPopup('k')<CR>
"
"
" " Python folding
" " mkdir -p ~/.vim/ftplugin
" " wget -O ~/.vim/ftplugin/python_editing.vim
" http://www.vim.org/scripts/download_script.php?src_id=5492
set nofoldenable

command! -complete=shellcmd -nargs=+ Shell call s:RunShellCommand(<q-args>)
function! s:RunShellCommand(cmdline)
    let isfirst = 1
    let words = []
    for word in split(a:cmdline)
        if isfirst
            let isfirst = 0  " don't change first word (shell command)
        else
            if word[0] =~ '\v[%#<]'
                let word = expand(word)
            endif
            let word = shellescape(word, 1)
        endif
        call add(words, word)
    endfor
    let expanded_cmdline = join(words)
    botright new
    setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
    call setline(1, 'You entered:  ' . a:cmdline)
    call setline(2, 'Expanded to:  ' . expanded_cmdline)
    call append(line('$'), substitute(getline(2), '.', '=', 'g'))
    silent execute '$read !'. expanded_cmdline
    1
endfunction

map <C-e> :NERDTreeToggle<CR>

set grepprg=grep\ -nH\ $*

let g:tex_flavor='latex'
let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_MultipleCompileFormats='pdf'
let g:tex_nine_config = {
        \'compiler': 'pdflatex',
        \'viewer': {'app':'evince', 'target':'pdf'},
    \}


set pastetoggle=<F2>

"Session management
"
fu! SaveSess()
    execute 'mksession! ' . getcwd() . '/.session.vim'
endfunction

fu! RestoreSess()
if filereadable(getcwd() . '/.session.vim')
    execute 'so ' . getcwd() . '/.session.vim'
    if bufexists(1)
        for l in range(1, bufnr('$'))
            if bufwinnr(l) == -1
                exec 'sbuffer ' . l
            endif
        endfor
    endif
endif
syntax on
endfunction

nnoremap <Leader>qs <esc>:NERDTreeClose<CR>:call SaveSess()<CR>:wqa<CR>
nnoremap <Leader>qq <esc>:wqa<CR>
nnoremap <Leader>ss <esc>:call RestoreSess()<CR>:NERDTree<CR>

" Template management
let g:templates_name_prefix = ".vim-template."

"UltraSnips configuration
let g:UltiSnipsExpandTrigger="<c-j>"

"only show linenumbers on current buffer
autocmd WinEnter * :setlocal number
autocmd WinLeave * :setlocal nonumber

iabbr pem cpaulik@gmail.com
iabbr wem christoph.paulik@geo.tuwien.ac.at

"Gvim font
if has('gui_running')
    set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 10
endif
