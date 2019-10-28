"|""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"|
"|  Filename:       .vimrc
"|  Description:    VIM Configuration
"|  Author:         Jonathan Lo
"|  Date Created:   
"|  Date Modified:  2019-10-27
"|
"|""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"|
"|  Table of Contents:
"|
"|      ->  General
"|      ->  UI
"|      ->  Colors and fonts
"|      ->  Files and backups
"|      ->  Text, tab, indentations
"|      ->  Visual Mode
"|      ->  Hotkeys
"|      ->  Status Line
"|      ->  Helper Funcs
"|
"|""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"|""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"|
"|  =>  General
"|
"|""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set hidden                                      " Sets how many lines of history
set nomodeline                                  " disable file-specific settings
set modelines=0                 " double assurance of disabling
set secure                                      " disable unsafe commands for vimrc
set ignorecase smartcase hlsearch incsearch     " better search
set wildmenu                                    " enable wild menu
set wildmode=list:longest,full                  " custom wild menu tab completion
set wildignore=*.o,*~,*.pyc                     " ignore these files with auto completing
set backspace=indent,eol,start                  " sane backspace
set whichwrap+=<,>,h,l
set clipboard+=unnamed,unnamedplus              " combined usage of system clipboard
set mouse=a                                     " enabled mouse
set ttymouse=xterm2                             " enabled mouse for cygwin
set nomousehide                                 " disable mouse hiding during typing
set mousemodel=popup                            " enable context menu, for gvim
set history=500                                 " command history
set shell=bash
set nocompatible                                " enable VIM Enhanced
set lazyredraw                                  " dont redraw for macros
set magic                                       " regular expressions, are magical
set showmatch mat=1                             " show matching backets
set noerrorbells novisualbell                   " quiet vim
set t_vb=
set tm=500
set foldcolumn=1                                " add one extra margin on the left


"   Enable filetype plugins
filetype plugin on
filetype indent on

"   set map leader for custom hotkeys
let mapleader=";"
let g:mapleader=";"

"   fast saving
nmap <leader>w :w!<cr>

" sudo saves
command W w !sudo tee % > /dev/null


"|""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"|
"|  =>  UI
"|
"|""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" colorscheme slate                              " set the colorscheme
" set ruler                                       " enable ruler in status menu
set number                                      " enable line numbers
highlight LineNr ctermfg=DaryGray               " reset line number colour to dark gray.
set scrolloff=999                               " ensure cursor is centered in window
set cursorline                                  " enable current line indicator
set textwidth=80                                " sane page width
set colorcolumn=81                              " end column indicator
let &colorcolumn=join(range(81,999),",")        " highlight everything past column 80
highlight ColorColumn ctermbg=LightGray
set printoptions=paper:letter                   " printer settings

set cmdheight=1                                 " set the command bar height
syntax enable                                   " syntax enabled

"|""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"|
"|  => Files and backups 
"|
"|""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nobackup nowritebackup noswapfile autoread  " disable all auto swap files, backups enabled autoreading

"|""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"|
"|  => Text, tabs, and indentations 
"|
"|""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set shiftwidth=4 tabstop=4 softtabstop=4 expandtab smarttab
                                                " correct tabs
set lbr tw=500                                  " enable line breaks

"|""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"|
"|  =>  Visual Mode 
"|
"|""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"   helpful quick searching on selection
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>/<C-R>=@<CR><CR>

"|""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"|
"|  =>  Hotkeys 
"|
"|""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"   quick map for searchings
map <space> /
map <c-space> ?

"   move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

"   close buffers
map <leader>bd :Bclose<cr>:tabclose<cr>gT
map <leader>ba :bufdo bd<cr>

"   move between buffers
map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>

"   tab manipulations hotkeys
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <leader>t<leader> :tabnext
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

"   alter the key for first non-blank character
map 0 ^

"   move line using ALT+[j][k]
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
nmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
nmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

"|""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"|
"|  =>  Status Line 
"|
"|""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set laststatus=2                                " always show status line
set statusline=                                 " clear statusline

set statusline+=%0*\ %{GetMode()}\              " display vim mode\
highlight User0 ctermfg=White ctermbg=DarkGray  " white fg and darkgray bg

set statusline+=%1*\ %<%F\                      " path + name
highlight User1 ctermfg=White ctermbg=Black     " white fg and black bg

set statusline+=%2*\ [%n]\                      " buffer size
highlight User2 ctermfg=Black ctermbg=LightGray " white fg and lightgray bg

set statusline+=%3*\ %m%r%y%h%w[%{&ff}][%{&spelllang}]\ 
                                                " file information
highlight User3 ctermfg=Black ctermbg=LightGray " black fg and lightgray bg

set statusline+=%4*\ [%{HighlightSearch()}]\    " highlight search indicator
highlight User4 ctermfg=Black ctermbg=LightGray " black fg and black bg

set statusline+=%5*\ \                          " 
highlight User5 ctermfg=White ctermbg=Black     " white fg and black bg

set statusline+=%6*\ \                          "
highlight User6 ctermfg=White ctermbg=Black     " white fg and black bg

set statusline+=%7*\ \                          "
highlight User7 ctermfg=White ctermbg=Black     " white fg and black bg

set statusline+=%8*\ \                          "
highlight User8 ctermfg=White ctermbg=Black     " white fg and black bg

set statusline+=%9*\ %=\ LN\ %l/%L,\ COL\ %03c\ " position
highlight User9 ctermfg=White ctermbg=Black     " white fg and black bg

function! HighlightSearch()
    if &hls
        return 'H'
    else
        return ''
    endif
endfunction

function! GetMode()
    if (mode() =~# '\v(v|V|<C-V>)')
        return 'VISUAL'
    elseif (mode() =~# '\v(i)')
        return 'INSERT'
    elseif (mode() =~# '\v(R)')
        return 'REPLACE'
    elseif (mode() =~# '\v(s|S)')
        return 'SELECT'
    else
        return 'COMMAND'
    endif
endfunction
"|""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"|
"|  =>  Helper Funcs 
"|
"|""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg("/", old_query)
endfun

if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee,*.c,*.cpp,*.s :call CleanExtraSpaces()
endif

map <leader>ss :setlocal spell!<cr>

function! HasPaste()
    if &paste
        return 'PASTE MODE '
    endif
    return ''
endfunction

command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")

    if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif

    if buflisted(l:currentBufNum)
        execute("bdelete! ".l:currentBufNum)
    endif
endfunction

function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg =@"
    execute "normal! vgvy"
    
    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")
    
    if a:direction == 'gv'
        call CmdLine ("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine ("%s". '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction
