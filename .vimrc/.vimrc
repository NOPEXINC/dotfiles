"------------------------------------------------------------
" My .vimrc File
" Maintained by: Zachariah Ngonyani
" zech@watabelabs.com
" @zechtz
" http://watabelabs.com
"------------------------------------------------------------
let mapleader = ","
let maplocalleader = ","

"allow for project specific vimrc 
set exrc  

execute pathogen#infect()

"set monaco as the font
set guifont=FiraSans\ 14
set runtimepath^=~/.vim/bundle/node

"set rust auto format
let g:rustfmt_autosave = 1

" automatically save the edited but not saved file
" when switching buffers 
set autowriteall  

syntax on

set number
"show current linenumber in the gutter
set relativenumber 

set numberwidth=5
set incsearch
set ignorecase
set ttyfast

"Makes scrolling faster
set lazyredraw 

" Make Vim more useful
set nocompatible
" Use the OS clipboard by default (on versions compiled with `+clipboard`)
set clipboard=unnamed
" Enhance command-line completion
set wildmenu
" Don’t add empty newlines at the end of files
"set binary
"set noeol
" Centralize backups, swapfiles and undo history
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
  set undodir=~/.vim/undo
endif

" Don’t create backups when editing files in certain directories
set backupskip=/tmp/*,/private/tmp/*

" Highlight current line
set cursorline

" Automatic commands
if has("autocmd")
  " Enable file type detection
  filetype on
  " Treat .json files as .js
  autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CUSTOM AUTOCMDS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup vimrcEx
  " Clear all autocmds in the group
  autocmd!
  autocmd FileType text setlocal textwidth=78
  " Jump to last cursor position unless it's invalid or in an event handler
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  "for ruby, autoindent with two spaces, always expand tabs
  autocmd FileType ruby,haml,eruby,yaml,html,javascript,sass,cucumber set ai sw=2 sts=2 et
  autocmd FileType python set sw=4 sts=4 et

  autocmd! BufRead,BufNewFile *.sass setfiletype sass 

  autocmd BufRead *.mkd  set ai formatoptions=tcroqn2 comments=n:&gt;
  autocmd BufRead *.markdown  set ai formatoptions=tcroqn2 comments=n:&gt;

  " Indent p tags
  " autocmd FileType html,eruby if g:html_indent_tags !~ '\\|p\>' | let g:html_indent_tags .= '\|p\|li\|dt\|dd' | endif

  " Don't syntax highlight markdown because it's often wrong
  autocmd! FileType mkd setlocal syn=off

  " Leave the return key alone when in command line windows, since it's used
  " to run commands there.
  autocmd! CmdwinEnter * :unmap <cr>
  autocmd! CmdwinLeave * :call MapCR()

  " *.md is markdown
  autocmd! BufNewFile,BufRead *.md setlocal ft=

  " indent slim two spaces, not four
  autocmd! FileType *.slim set sw=2 sts=2 et
augroup END

" Treat .md files as Markdown
autocmd BufNewFile,BufRead *.md setlocal filetype=markdown

"If no file is specified, just open nerdtree
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

"Just press , + s to open nerdtree
nmap <Leader>s :NERDTreeToggle<CR>
nmap <Leader>gv :Gvdiff<CR>

"Just press , + ggd to disable gitgutter and gge to enable
nmap <Leader>gd :GitGutterDisable<CR>
nmap <Leader>ge :GitGutterEnable<CR>
nmap <Leader>r <C-r>

"Just press , + l to open nerdtree
nmap <Leader>l :GitGutterLineHighlightsToggle<CR>
let g:gitgutter_max_signs = 2048

"Just press ,w to undo the last word in insert mode
"Undo last character
imap <Leader>h <C-h>
"Undo last word
imap <Leader>w <C-w>
"Undo last line
imap <Leader>u <C-u> 
"Undo everything untill last undo
imap <Leader>ou <C-o>u 

" Navigation through splits and resize the current split
nmap <Leader>hh <C-w>h
nmap <Leader>ll <C-w>l
nmap <Leader>jj <C-w>j
nmap <Leader>kk <C-w>k

filetype plugin indent on
"set tabstop=2
set ts=2 sts=2 noet
set shiftwidth=2
set expandtab
set autoindent
set showmatch
set hlsearch
set smartindent

" The ' key just takes back to the mark's line, the `(backtick)
" key takes you the exact position of the mark and i rarely
" use the '(signle quote) so i remaped the backtick(`) to the 
" signle quote key
nnoremap ' `
nnoremap ` '

"Highlight current line
set cursorline
set cmdheight=2

"turn on spell checking
" setlocal spell spelllang=en_us

syntax enable
set t_Co=256
set term=screen-256color
set background=dark  
"colorscheme atom-dark-256 
colorscheme atom-dark-256 
let g:onedark_termcolors=256

set foldmethod=syntax
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=1

" Set no max file limit
let g:ctrlp_max_files = 0
" Search from current directory instead of project root
let g:ctrlp_working_path_mode = 0

"Just ,p instead of ctrl + p
nmap <Leader>p <C-p> 
"Move back to normal mode from insert mode by typing ,]
imap <Leader>[ <C-[> 

" Ignore these directories
set wildignore+=*/.sass-cache/**
set wildignore+=*/vendor/**

" Indents html on save and takes you to the top of the page
" autocmd BufRead,BufWritePre *.html normal gg=G
"-----------------------------------------------------------------"
" map ctrl + c keys to autocomplete using emmet
"-----------------------------------------------------------------"
imap <Leader>c <c-y>,
vmap <Leader>w <c-y>,

"-----------------------------------------------------------------"
"Insert a hash rocket with <c-l>
"-----------------------------------------------------------------"
imap <c-l> <space>=><space>

"-----------------------------------------------------------------"
"Saves time; maps the spacebar to colon
"-----------------------------------------------------------------"
nmap <space> :
nmap <Leader>tb <Esc>:Tabularize<space>/ 
vmap <Leader>tb <Esc>:Tabularize<space>/ 
"-----------------------------------------------------------------"
"Fuzzy search files with ctrl.p plugin
"-----------------------------------------------------------------"
set runtimepath^=~/.vim/bundle/ctrlp.vim
" check it here https://github.com/kien/ctrlp.vim
"-----------------------------------------------------------------"
"Never have to lift your fingers just to escape insert mode ':'"
"-----------------------------------------------------------------"
imap jk <Esc>
imap jj <Esc>
imap kk <Esc>

set autoindent
set smartindent

"-----------------------------------------------------------------"
" Word wrapping that doesn't do a word in half
"-----------------------------------------------------------------"
set wrap
set linebreak 
set nolist

let g:gitgutter_highlight_lines = 1

"-----------------------------------------------------------------"
" Allow copying and pasting from clipboard make sure vim comes bundled
" with xterm_clipboard vim --version should show +xterm_clipboard run sudo apt-get install vim-nox
"-----------------------------------------------------------------"
set clipboard=unnamedplus

"-----------------------------------------------------------------"
" sometimes you open a readonly file in vim but you forget to run vim with sudo 
" after making changes to it, thus you wont be able to save the file this is a trick to save it 
"-----------------------------------------------------------------"
cmap w!! w !sudo tee % >/dev/null 

"-----------------------------------------------------------------"
" Alphabetically sort CSS properties in file with :SortCSS
"-----------------------------------------------------------------"
:command! SortCSS :g#\({\n\)\@<=#.,/}/sort

"-----------------------------------------------------------------"
" show matching brackets
"-----------------------------------------------------------------"
set showmatch 
"-----------------------------------------------------------------"
" print empty <a> tag
"-----------------------------------------------------------------"
map! ;h <a href=""></a><ESC>5hi
"-----------------------------------------------------------------"
" Set a different background color on gutter
"-----------------------------------------------------------------"
highlight clear SignColumn 
highlight GitGutterAdd ctermfg=green
highlight GitGutterChange ctermfg=yellow
highlight GitGutterDelete ctermfg=red
highlight GitGutterChangeDelete ctermfg=yellow
"-----------------------------------------------------------------"

"-----------------------------------------------------------------"
" MULTI PURSOPSE TAB KEY
" Indent if we are at the begining of a line, else, do completion
"-----------------------------------------------------------------"
function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  else
    return "\<Tab>"
  endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
"inoremap <s-tab> <c-n>

"-----------------------------------------------------------------"
" Rename current file
"-----------------------------------------------------------------"
function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'))
  if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
    redraw!
  endif
endfunction
map <Leader>rn  :call RenameFile()<cr>

function! GetCWD()
  return expand(":pwd")
endfunction

function! IsHelp()
  return &buftype=='help'?' (help) ':''
endfunction

function! GetName()
  return expand("%:t")==''?'<none>':expand("%:t")
endfunction

set statusline=%1*[%{GetName()}]\ 
set statusline+=%<pwd:%{getcwd()}\ 
set statusline+=%2*%{&modified?'\[+]':''}%*
set statusline+=%{IsHelp()}
set statusline+=%{&readonly?'\ (ro)\ ':''}
set statusline+=[
set statusline+=%{strlen(&fenc)?&fenc:'none'}\|
set statusline+=%{&ff}\|
set statusline+=%{strlen(&ft)?&ft:'<none>'}
set statusline+=]\ 
set statusline+=%=
set statusline+=c%c
set statusline+=,l%l
set statusline+=/%L\

"-----------------------------------------------------------------"
" Make a directory if it doesn't exist
"-----------------------------------------------------------------"
function! s:MkNonExDir(file, buf)
  if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
    let dir=fnamemodify(a:file, ':h')
    if !isdirectory(dir)
      call mkdir(dir, 'p')
    endif
  endif
endfunction
augroup BWCCreateDir
  autocmd!
  autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END

let g:airline_powerline_fonts = 1
let g:airline_theme='onedark'

"make sure the airline status shows even on single files
set laststatus=2

"-----------------------------------------------------------------"
" Use v or # to get a variable interpolation (inside of a string)}
" ysiw# Wrap the token under the cursor in #{} in Ruby
" v...s# Wrap the selection in #{}
"-----------------------------------------------------------------"
let g:surround_113 = "#{\r}" 
let g:surround_35 = "#{\r}" 

"-----------------------------------------------------------------"
" Select text in an ERb file with visual mode and then press s- or s=
"-----------------------------------------------------------------"
" Or yss- to do entire line.
let g:surround_45 = "<% \r %>" 
let g:surround_61 = "<%= \r %>" 

"-----------------------------------------------------------------"
" RubyAndRails Turn on folding in ruby files
"-----------------------------------------------------------------"
let g:ruby_fold = 1 
" Highlight ruby operators
let ruby_operators = 1 
" Turn off rails bits of statusbar
let g:rails_statusline=0 

"-----------------------------------------------------------------"
" Make ctrl + p load 100% times faster, just tell it to ignore git files
"-----------------------------------------------------------------"
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

"-----------------------------------------------------------------"
"Exchange settings
"-----------------------------------------------------------------"
nmap cx <Plug>(Exchange)
vmap cx <Plug>(Exchange)
xmap X <Plug>(Exchange)
nmap cxc <Plug>(ExchangeClear)
vmap cxc <Plug>(ExchangeClear)
nmap cxx <Plug>(ExchangeLine)
vmap cxx <Plug>(ExchangeLine)

"-----------------------------------------------------------------"
" Resize the current split to at least (90,25) but no more than (140,60)
" or 2/3 of the available space otherwise.
"-----------------------------------------------------------------"
function! Splitresize()
    let hmax = max([winwidth(0), float2nr(&columns*0.66), 90])
    let vmax = max([winheight(0), float2nr(&lines*0.66), 25])
    exe "vertical resize" . (min([hmax, 140]))
    exe "resize" . (min([vmax, 60]))
endfunction

"-----------------------------------------------------------------"
" vim-go settings & key bindings
"-----------------------------------------------------------------"
let g:go_disable_autoinstall = 0
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators= 1
let g:go_highlight_build_constraints= 1

au FileType go nmap <Leader>v <Plug>(go-def-vertical)
au FileType go nmap <Leader>in <Plug>(go-info)
au FileType go nmap <Leader>ii <Plug>(go-implements)
au FileType go nmap <leader>r  <Plug>(go-run)
au FileType go nmap <leader>b  <Plug>(go-build)
au FileType go nmap <leader>g  <Plug>(go-gbbuild)
au FileType go nmap <leader>t  <Plug>(go-test-compile)
au FileType go nmap <leader>c  <Plug>(go-coverage)
au FileType go nmap <Leader>d <Plug>(go-doc)
au FileType go nmap <Leader>f :GoImports<CR>

" Disable folding
let g:vim_markdown_folding_disabled = 1

"set rtp+=~/.fzf
"https://github.com/mathiasbynens/dotfiles
"
" execute a command and show it's output in a split window
command! -nargs=* -complete=shellcmd Rsplit execute "new | r! <args>"

" execute a command and show it's output in a new tab
" command! -nargs=* -complete=shellcmd Rtab execute "tabnew | r! <args>"


let g:rspec_command = 'call Send_to_Tmux("rspec {spec}\n")'

" vim-rspec mappings
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>x :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

"typescript 
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow

set textwidth=120       

" break lines when line length increases python files 
au FileType py set autoindent
au FileType py set smartindent
" au FileType py set textwidth=79 " PEP-8 Friendly

" No ARROW KEYS COME ON
map <Left>  :echo "no!"<cr>
map <Right> :echo "no!"<cr>
map <Up>    :echo "no!"<cr>
map <Down>  :echo "no!"<cr>

" Ctags Mappings
nmap <Leader>f :tag<space>

" set comments to be in italics
set t_ZH=[3m
set t_ZR=[23m
highlight Comment cterm=italic 
