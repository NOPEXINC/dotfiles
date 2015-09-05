" My .vimrc File
" Maintained by: Zachariah Ngonyani
" zech@watabelabs.com
" @zechtz
" http://watabelabs.com
"
let mapleader = ","
let maplocalleader = ","

execute pathogen#infect()

syntax on

set number
set numberwidth=5
set incsearch
set ignorecase

filetyp plugin indent on
set tabstop=2
set shiftwidth=2
set expandtab
set autoindent
set showmatch
set hlsearch
set smartindent

"Highlight current line
set cursorline
set cmdheight=2

syntax enable
:set t_Co=256
set background=dark
colorscheme solarized
"colorscheme monokai
"colorscheme gotham256

set foldmethod=syntax
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=1

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
set wrap linebreak nolist

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
