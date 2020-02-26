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
Plugin 'rhysd/open-pdf.vim'
"commented out due to needing additional dependencies
Plugin 'valloric/youcompleteme'
Plugin 'francoiscabrol/ranger.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'pangloss/vim-javascript'
Plugin 'ap/vim-css-color'
Plugin 'kien/rainbow_parentheses.vim'
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
"set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
"if has("autocmd")
"  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
"endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
"if has("autocmd")
"  filetype plugin indent on
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
"enables syntax highlighting for php
set iskeyword+=-
set printfont=Ariel:h12
set printheader=%<%f%h%m%
"checks for php syntax errors
map <F2> :%s/\s\+$//e<CR>
map <F5> :!php -l %<CR>
map <F8> gggqG :Lp <CR>
map <F9> gggqG :Elp <CR>
nnoremap <silent> <F4> :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>

"maps the esc key to the place were it was on the terminal where vim was
"originally developed
"shift tab still functions as tab
inoremap <Tab> <Esc>
"change to working directory
command! Cwd cd %:p:h
"windows switching commands
function! s:winswitch(...)
	let i = 0
	for arg in a:000
		let command = ":wincmd ".arg
		execute command
		let i = i + 1
	endfor
endfunction

function! s:cuross()
	let command =":set cursorline!"
	execute command
	let command =":set cursorcolumn!"
	execute command
endfunction

command! -nargs=+ W call s:winswitch(<f-args>)
command! Tw :w !sudo tee %
command! CC call s:cuross()
command! Elp :w|ha > %.ps | !ps2pdf %.ps && rm %.ps
command! -nargs=1 Lp let &printheader="%-%<args>"|ha > %.ps | !ps2pdf %.ps && rm %.ps
"Set the appropiate colorspace for vim-airlines
let g:move_key_modifier ='C'
set t_Co=256
set <M-a>=^[a
let g:pdf_convert_on_edit=1
"configuration for ranger and youcompleteme
let g:ranger_replace_netrw = 1 " open ranger when vim open a directory
let g:ycm_key_list_select_completion=['<C-J>','<Down>']
let g:ycm_key_list_previous_completion=['<C-K>','<Up>']
