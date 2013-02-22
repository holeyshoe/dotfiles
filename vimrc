" ==== General Settings ====
call pathogen#infect()
set nocompatible
" syntax enable
set nowrap
set number
set showcmd
set showmode
set colorcolumn=80
set encoding=utf-8
set autoread
set laststatus=2
set backup
set backupdir=$HOME/.vim/backup

" ==== Turn Off Swap files ====

set noswapfile
set nobackup
set nowb

" ==== Indentation ====

set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=5
" set expandtab

" ==== Common Sense Stuff ====
filetype on
filetype plugin on
filetype plugin indent on
syntax on

" === Latex ===
set grepprg=grep\ -nH\ $*
let g:tex_flavor='latex'
let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_ViewRule_pdf='mupdf'
" set list listchars=tab:\·\ ,trail:·

" === SpellChecker ===
let dialect='UK'

colorscheme tir_black 
" set background=dark
let g:indent_guides_auto_colors = 0
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size  = 1
hi IndentGuidesEven ctermbg=234
hi IndentGuidesOdd	ctermbg=235
autocmd BufEnter * IndentGuidesEnable
" ==== Keymaps ====

map <F2> :NERDTreeToggle<Enter>
