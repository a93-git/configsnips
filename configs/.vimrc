set nocompatible              " be iMproved, required
filetype off                  " required

" Syntax highlighting
if has("syntax")
  syntax on
endif

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
" set background=dark
" Uncomment the following to have Vim jump to the last position when
" reopening a file
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
filetype plugin indent on

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set incsearch		" Incremental search
set autowrite		" Automatically save before commands like :next and :make
set hidden		" Hide buffers when they are abandoned
"set mouse=a		" Enable mouse usage (all modes)

" My own vimscript below this line
" Set colorscheme
colorscheme ron
" Highlight the line where the cursor is
set cursorline

set scrolloff=5 " Set scrolloff to 5 lines
" Show status bar
set laststatus=2
" Show line number, relative, set numberwidth to 2
set number relativenumber numberwidth=2
" Textwidth to auto insert newline after and set autowrap to true
set textwidth=100
set wrap
" Column 80 and 100 are highlighted
set colorcolumn=80,100
" Number of columns
set columns=120
" code folding with space bar
nnoremap mf zfa}
" Select till the end of line without the new line char
nnoremap ,v ^v$h
" Use F2 to execute ruby file
autocmd FileType c noremap <F2> :!clear && make -C ~/albali/ -f ~/albali/Makefile<CR>
autocmd FileType c noremap <F5> :!clear && ./bin/albali<CR> 
autocmd FileType c noremap ,r zfa}
autocmd FileType c set tabstop=2
autocmd FileType ruby noremap <F2> :!clear && ruby %  
autocmd FileType ruby noremap <F5> :!clear && ruby %<CR> 
" Use space bar to select the current word
nmap <space> viw

" Toggle the word case 
nnoremap mt viw~ea
" Toggle the selection case 
vnoremap mt ~

" Use Up and Down arrow keys to move the line up or down
nnoremap <Down> :m+<CR>
nnoremap <Up> :m-2<CR>
" Duplicate the current line
nnoremap <C-Down> yyP
nnoremap <C-Up> yyp
autocmd FileType html setlocal shiftwidth=2 tabstop=2

" Close the current buffer
nnoremap ,w :bd<CR>
" List all the buffers
nnoremap <C-l> :ls<CR>

" Cycle through buffers
" next
nnoremap <Tab> :bnext<CR>
" previous
nnoremap <S-Tab> :bprevious<CR>

" Search and replace the visual selection
vnoremap <C-h> y:%s/<C-r>"//gc

" HTML closing tags auto append
function CompleteTag()
	if (&ft == "html" || &ft == "html.erb")
		let cursorpos = getcurpos()
		let line = line(".")
		let regval = getreg('"') 
		let var2 = join(["<", regval, ">"], "")
		let var3 = join(["</", regval, ">"], "")
		let var4 = join([var2, var3], "\n\n")
		execute "normal a" . var4 . "\<Esc>"
		call cursor(line + 1 , 1)
	endif
endfunction

inoremap <C-h> <Esc>viwx:call CompleteTag()<CR>

function IndentFile()
	let line = line(".")
	let cursorpos = getcurpos()
	execute "normal ggV\<S-g>="
	" call cursor(line, 1)
	call setpos(".", cursorpos)
endfunction

nnoremap ,f :call IndentFile()<CR>

" Vertical resize window
nnoremap ,- :resize -5
nnoremap ,+ :resize +5

let g:netrw_liststyle=3
let g:netrw_winsize=15

nnoremap ,e :Explore<CR>
inoremap ,s <Esc>:w<CR>
nnoremap ,s :w<CR>
" Move the char at cursor using arrow right
nnoremap <Right> vxp

" Insert 50 new lines at the bottom of the page
inoremap ,a <Esc><S-g>A<C-m><Esc>50.50ki

" Open .vimrc for editing
nmap ,ve :edit ~/.vimrc<CR>

" Source vimrc
nnoremap ,vs :source ~/.vimrc<CR>
" Formatting options
set fo-=pj1nawqrct

" Goto end of current line
noremap L <Esc>$
" Goto start of current line
noremap H <Esc>^

" Scroll up 
" map ;e <C-b>
" map ;d <C-d>
" Scroll down
" map ;b <C-b>
" map ;y <C-y>

set tabstop=8
set softtabstop=2
set shiftwidth=2
set expandtab
" Highlight the current line in gray
hi CursorLine term=reverse cterm=reverse ctermbg=None guibg=Black

" Scroll window to place current line at the top of the screen
map <C-k> zt
" Scroll window to place current line at the bottom of the screen
map <C-j> zb
" Scroll window to place current line at the bottom of the screen
map <C-,> zz

" Markdown file specific keybindings
" h1, h2, h3, h4 -> set the line to corresponding header
autocmd FileType markdown nnoremap <buffer> h1 <Esc>^i# <Esc> 
autocmd FileType markdown nnoremap <buffer> h2 <Esc>^i## <Esc> 
autocmd FileType markdown nnoremap <buffer> h3 <Esc>^i### <Esc> 
autocmd FileType markdown nnoremap <buffer> h4 <Esc>^i#### <Esc> 
" ,l -> make the current line a list item (prepend current line with a -)
autocmd FileType markdown nnoremap <buffer> ,l <Esc>^i- <Esc>
" ,c -> change the visual selection to a code block
autocmd FileType markdown vnoremap <buffer> ,c c```<CR>```<Esc>P
" ,b -> bold the current selection (on the same line) 
autocmd FileType markdown vnoremap <buffer> ,b c**<Esc>pa**<Esc> 
" ,i -> italicize the current selection (on the same line)
autocmd FileType markdown vnoremap <buffer> ,i c*<Esc>pa*<Esc> 

" set spellcheck to British English
" setlocal spell spelllang=en_gb
" setlocal hi SpellBad term=reverse cterm=reverse ctermbg=None guisp=None 

" Comment shortcut based on filetypes
autocmd FileType ruby nnoremap <buffer> <C-_> ^i# <Esc>
autocmd FileType ruby inoremap <buffer> <C-_> <Esc>^i# <Esc>

function VisualComment()
    execute "normal \<Esc>^i# \<Esc>"
endfunction
autocmd FileType ruby vnoremap <buffer> <C-_> :call VisualComment()<CR>

function VisualUnComment()       
  execute "normal \<Esc>^xx\<Esc>"
endfunction
autocmd FileType ruby vnoremap <buffer> <C-S-_> :call VisualUnComment()<CR> 

autocmd FileType ruby nnoremap <buffer> ,t ^xx

" Add macros for Ruby to create if block, else block, unless block
"autocmd FileType ruby inoremap ifblock<space> if ()<CR>elsif ()<CR>else<CR><Esc>3k$i
autocmd FileType ruby iabbrev ifblock if ()<CR>elsif ()<CR>else<CR><Esc>3k$i
" Add abbrs to create rescue block
autocmd FileType ruby iabbrev rsc1 begin <CR>rescue <CR>ensure<CR>end<Esc>3k$a
autocmd FileType ruby iabbrev rsc2 rescue <CR>ensure<CR>end<Esc>2k$a
autocmd FileType ruby iabbrev rsc3 rescue <CR>end<Esc>k$a
" Add abbrs to create class and modules
autocmd FileType ruby iabbrev cls class <CR>end<Esc>k$a
autocmd FileType ruby iabbrev mdl module <CR>end<Esc>k$a 

" Add macro to create while, until, loop, beginwhile, beginuntil, for block

" Tab through the tabs
nnoremap ,<Tab> :tabnext
nnoremap ,<S-Tab> :tabprev

" Create new tab
nnoremap ,t :tabnew

" Save all and exit
nnoremap ,q :wqa<CR>

" Enter adds a new line
nmap <CR> A<CR><Esc>

" Seach the file for the word under cursor
nnoremap f *
































