"
" -----------------------------------------------------------
" My .vimrc File
" Maintained by: Zachariah Ngonyani
" zech@watabelabs.com
" @zechtz
" http://watabelabs.com
"------------------------------------------------------------
"
let mapleader = ","
let maplocalleader = ","

execute pathogen#infect()

"set monaco as the font
set guifont=Monaco\ 12

syntax on

set number
set numberwidth=5
set incsearch
set ignorecase
set ttyfast
set lazyredraw "Makes scrolling faster

filetyp plugin indent on
set tabstop=2
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

syntax enable
set t_Co=256
set term=screen-256color
set background=dark
colorscheme solarized
"colorscheme monokai
"colorscheme gotham256

set foldmethod=syntax
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=1

" Set no max file limit
let g:ctrlp_max_files = 0
" Search from current directory instead of project root
let g:ctrlp_working_path_mode = 0

" Ignore these directories
set wildignore+=*/.sass-cache/**
set wildignore+=*/vendor/**

" Indents html on save and takes you to the top of the page
" autocmd BufRead,BufWritePre *.html normal gg=G

" map ctrl + c keys to autocomplete using emmet

imap <c-c> <c-y>,
vmap <c-w> <c-y>,

"Insert a hash rocket with <c-l>
imap <c-l> <space>=><space>

"Saves time; maps the spacebar to colon
nmap <space> :

"Fuzzy search files with ctrl.p plugin
set runtimepath^=~/.vim/bundle/ctrlp.vim
" check it here https://github.com/kien/ctrlp.vim

"Never have to lift your fingers just to escape insert mode ':'"
imap jk <Esc>

set autoindent
set smartindent

" Word wrapping that doesn't do a word in half
set wrap
set linebreak 
set nolist

let g:gitgutter_highlight_lines = 1

" Allow copying and pasting from clipboard
set clipboard=unnamedplus

" sometimes you open a readonly file in vim but you forget to run vim with sudo 
" after making changes to it, thus you wont be able to save the file this is a trick to save it 
cmap w!! w !sudo tee % >/dev/null 

" Alphabetically sort CSS properties in file with :SortCSS
:command! SortCSS :g#\({\n\)\@<=#.,/}/sort

set showmatch " show matching brackets

" print empty <a> tag
map! ;h <a href=""></a><ESC>5hi

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set a different background color on gutter
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
highlight clear SignColumn 
highlight GitGutterAdd ctermfg=green
highlight GitGutterChange ctermfg=yellow
highlight GitGutterDelete ctermfg=red
highlight GitGutterChangeDelete ctermfg=yellow

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MULTI PURSOPSE TAB KEY
" Indent if we are at the begining of a line, else, do completion
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  else
    return "\<Tab>"
  endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   RENAME CURRENT FILE
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'))
  if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
    redraw!
  endif
endfunction
map <c-r> :call RenameFile()<cr>


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

"Make directory if it doesn't exist yet
function s:MkNonExDir(file, buf)
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
let g:airline_theme="papercolor"
"let g:airline_theme="wombat"
"let g:airline_theme='kalisi'
"let g:airline_theme='laederon'

" Ruby
" Use v or # to get a variable interpolation (inside of a string)}
" ysiw# Wrap the token under the cursor in #{}
" v...s# Wrap the selection in #{}
let g:surround_113 = "#{\r}" " v
let g:surround_35 = "#{\r}" " #

" Select text in an ERb file with visual mode and then press s- or s=
" Or yss- to do entire line.
let g:surround_45 = "<% \r %>" " -
let g:surround_61 = "<%= \r %>" " =

" RubyAndRails:
let g:ruby_fold = 1 " Turn on folding in ruby files
let ruby_operators = 1 " Highlight ruby operators
let g:rails_statusline=0 " Turn off rails bits of statusbar
