" All system-wide defaults are set in $VIMRUNTIME/debian.vim and sourced by
" the call to :runtime you can find below.  If you wish to change any of those
" settings, you should do it in this file (/etc/vim/vimrc), since debian.vim
" will be overwritten everytime an upgrade of the vim packages is performed.
" It is recommended to make changes after sourcing debian.vim since it alters
" the value of the 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'peterhoeg/vim-qml'
Plugin 'vim-airline/vim-airline'
Plugin 'tranvansang/vim-close-pair'
Plugin 'unblevable/quick-scope'
Plugin 'matze/vim-move'
Plugin 'tpope/vim-fugitive'
Plugin 'rhysd/open-pdf.vim'
"commented out due to needing additional dependencies
"Plugin 'valloric/youcompleteme'
"Plugin 'francoiscabrol/ranger.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'pangloss/vim-javascript'
Plugin 'ap/vim-css-color'
Plugin 'kien/rainbow_parentheses.vim'
Plugin 'ervandew/supertab'
Plugin 'hail2u/vim-css3-syntax'
Plugin 'KabbAmine/vCoolor.vim'
Plugin 'will133/vim-dirdiff'
call vundle#end()
filetype plugin indent on
" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
if has("syntax")
	syntax on
endif

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
set background=dark
" set utf-8 as the default encoding
set encoding=utf-8
set fileencoding=utf-8

" Uncomment the following to have Vim jump to the last position when
" reopening a file
"if has("autocmd")
	"au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
"endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
"if has("autocmd")
	"filetype plugin indent on
"endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
"set showcmd		" Show (partial) command in status line.
"set showmatch		" Show matching brackets.
"set ignorecase		" Do case insensitive matching
"set smartcase		" Do smart case matching
"set incsearch		" Incremental search
"set autowrite		" Automatically save before commands like :next and :make
"set hidden		" Hide buffers when they are abandoned
"set mouse=a		" Enable mouse usage (all modes)

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
	source /etc/vim/vimrc.local
endif
set number
set relativenumber
set autoindent

" Use a line cursor within insert mode and a block cursor everywhere else.
"
" Reference chart of values:
"   Ps = 0  -> blinking block.
"   Ps = 1  -> blinking block (default).
"   Ps = 2  -> steady block.
"   Ps = 3  -> blinking underline.
"   Ps = 4  -> steady underline.
"   Ps = 5  -> blinking bar (xterm).
"   Ps = 6  -> steady bar (xterm).
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

"enables syntax highlighting for php
set iskeyword+=-
let php_htmlInStrings=1
let php_baselib=1
let php_sql_query=1
"set print settings
set printfont=Ariel:h12
set printheader=%<%f%h%m%
"format dpcument and print to pdf
map <F8> gggqG :Lp <CR>
map <F9> gggqG :Elp <CR>

map <F5> :Tw<CR>
map <F9> :Ti<CR>
"strip trailing spaces
map <F2> :%s/\s\+$//e<CR>
nnoremap <silent> <F4> :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>
"for trimming vim-move from plugins
"nnoremap <C-j> :m .+1<CR>==
"nnoremap <C-k> :m .-2<CR>==
"vnoremap <C-j> :m '>+1<CR>gv=gv
"vnoremap <C-k> :m '<-2<CR>gv=gv

"maps the esc key to the place were it was on the terminal
"where vim was originally developed
"shift tab still functions as tab in insert mode
set completeopt=menuone,longest
set wildcharm=<Tab>
cnoremap <S-Tab> <Tab>
nnoremap <Tab> <Esc>
vnoremap <Tab> <Esc>gV
onoremap <Tab> <Esc>
cnoremap <Tab> <C-C><Esc>
inoremap <expr> <Tab> pumvisible() ? "<C-E>" : "<Esc>`^"
inoremap <expr> <S-Tab> pumvisible() ? "<C-Y>" : "<C-P>"
set expandtab
set shiftwidth=4

nnoremap <Space> <Tab>
nnoremap <Backspace> <C-O>
"supertab config
let g:SuperTabMappingForward = '<c-j>'
let g:SuperTabMappingBackward = '<c-k>'
"map buffer navi to + -
nnoremap - :bp<CR>
nnoremap + :bn<CR>

"change to working directory
command! Cwd cd %:p:h
"functions to strip strings and numbers
function! s:chop(string, char)
    return substitute(a:string, a:char, '', '')
endfunction
function! s:chopnumbers(string)
    return substitute(a:string, '\d*', '', 'g')
endfunction
"windows management commands
function! s:winman(...)
	let i = 0
	for arg in a:000
		if arg =~ '[A-Za-z_|=]' && arg !~ '[^A-Za-z_|=]'
			let command = ":wincmd ".arg
			execute command
		elseif arg =~'[1-9>+<-]' && s:chopnumbers(arg) != ''
                        let command = ":".s:chop(arg, s:chopnumbers(arg))."wincmd ".s:chopnumbers(arg)
                        execute command
		endif
		let i = i + 1
	endfor
endfunction
"use space as the vertical split separating character
set fillchars+=vert:\ 

function! s:cuross()
	let command =":set cursorline!"
	execute command
	let command =":set cursorcolumn!"
	execute command
endfunction

command! -nargs=+ W call s:winman(<f-args>)
command! Tw :w !sudo tee %
command! Ti :w !sudo tee % && sudo make clean install
command! Php :!php -l %<CR>
command! Pastebin :!cat %|nc termbin.com 9999
"command! Tq :w !sudo tee %<CR>L<CR>:q
command! CC call s:cuross()
command! Elp :w|ha > %.ps | !ps2pdf %.ps && rm %.ps
command! -nargs=1 Lp let &printheader="%-%<args>"|ha > %.ps | !ps2pdf %.ps && rm %.ps
let g:move_key_modifier ='C'
"Set the appropiate colorspace for vim-airlines
set t_Co=256
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:pdf_convert_on_edit=1
"netrw config
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_winsize = 20
let ghregex='\(^\|\s\s\)\zs\.\S\+'
let g:netrw_list_hide=ghregex
let g:netrw_fastbrowse = 0
"color picker shortcuts
let g:vcoolor_disable_mappings = 1
let g:vcoolor_map = '<C-C>'
let g:vcool_ins_rgb_map = '<C-G>'
let g:vcool_ins_rgba_map = '<C-W>'
"au VimEnter * :Lex
au FileType netrw setl bufhidden=wipe
au BufReadPost *.lib set syntax=php
au BufReadPost *.php set ft=html|set syntax=php
"configuration for ranger and youcompleteme
"let g:ranger_replace_netrw = 1 " open ranger when vim open a directory
"let g:ycm_key_list_select_completion=['<C-J>','<Down>']
"let g:ycm_key_list_previous_completion=['<C-K>','<Up>']
