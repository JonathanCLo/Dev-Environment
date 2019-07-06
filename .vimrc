""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   
"   Filename:       .vimrc
"   Description:    VIM Configuration
"   Author:         Jonathan Lo
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   
"   Table of Contents:
"
"       ->  General
"       ->  UI
"       ->  Colors and fonts
"       ->  Files and backups
"       ->  Text, tab, indentations
"       ->  Visual Mode
"       ->  Hotkeys
"       ->  Status Line
"       ->  Helper Funcs
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
"   =>  General
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"   Sets how many lines of history
set history=500

"   Enable filetype plugins
filetype plugin on
filetype indent on

"   enable VIM Enhanced
set nocompatible

"   auto read file if updated
set autoread

"   set map leader for custom hotkeys
let mapleader=";"
let g:mapleader=";"

"   fast saving
nmap <leader>w :w!<cr>

" sudo saves
command W w !sudo tee % > /dev/null

"   enable mouse control
set mouse=a

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
"   =>  UI
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"   set the colorscheme
colorscheme slate

"   enable wild menu
set wildmenu

"   custom wild menu tab completion
set wildmode=list:longest,full

"   ignore these files with auto completing
set wildignore=*.o,*~,*.pyc

"   enable ruler
set ruler

"   enable current line highlighting
set cursorline

"   set the command bar height
set cmdheight=2

"   hide buffer when abandoned
set hid

"   enable line numbers
set number

"   alter the color of the line nr from default
highlight LineNr ctermfg=grey


"   add a column to represent page width
set colorcolumn=80

"   enable syntax highlighting
syntax enable

"   return backspace to normal operation
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

"   searching tuning.
set ignorecase
set smartcase
set hlsearch
set incsearch

"   dont redraw while executing macros
set lazyredraw

"   for regular expressions
set magic

"   show matching brackets [ sadsad  ]
set showmatch
set mat=1

"   disable sounds
set noerrorbells
set novisualbell
set t_vb=
set tm=500

"   add one extra margin on the left
set foldcolumn=1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
"   => Files and backups 
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"   disable all auto swap files, backups.
set nobackup
set nowb
set noswapfile

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
"   => Text, tabs, and indentations 
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"   enable nice tabs
set expandtab
set smarttab

"   4 space tabs
set shiftwidth=4
set tabstop=4

"   force line breaks
set lbr
set tw=500

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
"   =>  Visual Mode 
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"   helpful quick searching on selection
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>/<C-R>=@<CR><CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
"   =>  Hotkeys 
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
"   =>  Status Line 
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"   always show status line
set laststatus=2

"   format status line
set statusline=\ %{HasPaste()}%f%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
"   =>  Helper Funcs 
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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

