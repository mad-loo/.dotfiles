" Enable syntax highlighting properly
syntax enable
filetype plugin indent on

" Display settings
set number                 " Show line numbers
set cursorline             " Highlight current line
set scrolloff=5            " Keep 5 lines visible when scrolling
set ruler                  " Show cursor position
set showcmd                " Show partial commands

" Indentation settings
set expandtab              " Use spaces instead of tabs
set shiftwidth=2           " Set indent width to 2 spaces
set tabstop=2              " Set tab width to 2 spaces
set autoindent             " Copy indent from current line when starting a new line
set smartindent            " Smart auto-indenting

" Search settings
set incsearch              " Incremental search
set hlsearch               " Highlight search results
set ignorecase             " Case insensitive search
set smartcase              " Case sensitive if uppercase present

" File and encoding settings
set encoding=utf-8         " Set internal encoding
set fileencoding=utf-8     " Set file encoding
set hidden                 " Allow switching buffers without saving

" Avoid backup files
set nobackup               " No backup files
set nowritebackup          " No backup during editing
set noswapfile             " No swap files

" UI improvements
set wildmenu               " Command-line completion menu
set mouse=a                " Enable mouse support
set splitright             " New vertical splits to the right
set splitbelow             " New horizontal splits below

" Clipboard integration
set clipboard=unnamedplus  " Use system clipboard

" Leader key
let mapleader = " "        " Use space as leader key

" Key mappings
" Quick save and quit
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>

" Navigate between splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l