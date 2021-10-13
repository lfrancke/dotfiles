" Allows to be incompatible to vi
set nocompatible

" Vim Plug installation
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins
call plug#begin('~/.vim/plugged')
Plug '/usr/local/opt/fzf'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'ekalinin/Dockerfile.vim'
Plug 'francoiscabrol/ranger.vim'
Plug 'habamax/vim-asciidoctor'
Plug 'junegunn/fzf.vim'
Plug 'justinmk/vim-sneak'
Plug 'kristijanhusak/orgmode.nvim'
Plug 'liuchengxu/vim-which-key'
Plug 'metakirby5/codi.vim'
Plug 'morhetz/gruvbox'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'




" Collection of common configurations for the Nvim LSP client
Plug 'neovim/nvim-lspconfig'

" Completion framework
Plug 'hrsh7th/nvim-cmp'

" LSP completion source for nvim-cmp
Plug 'hrsh7th/cmp-nvim-lsp'

" Snippet completion source for nvim-cmp
Plug 'hrsh7th/cmp-vsnip'

" Other usefull completion sources
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-buffer'

" See hrsh7th's other plugins for more completion sources!

" To enable more of the features of rust-analyzer, such as inlay hints and more!
Plug 'simrat39/rust-tools.nvim'

" Snippet engine
Plug 'hrsh7th/vim-vsnip'

" Fuzzy finder
" Optional
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Color scheme used in the GIFs!
" Plug 'arcticicestudio/nord-vim'


call plug#end()


let mapleader=","

set history=1000
set hidden

" Start with all folds open
set foldlevelstart=99

" Shows partial commands in the status line while they are being entered
set showcmd

" Enable filetype plugin
filetype plugin on
filetype indent on

" Reload file when changed outside of Vim and there are no changes in Vim yet
set autoread

" How many lines are kept in view when scrolling
set scrolloff=7

set ruler "Always show current position

set backspace=indent,eol,start

" Ignore case when searching except when search string contains a upper case character
set ignorecase
set smartcase

" Highlight search results. Turn off with :nohlsearch
set hlsearch

" Incremental search <Enter> still needs to be pressed
set incsearch

" Remove annoying things
set noerrorbells
set novisualbell

set encoding=utf8

" Sets colors to something that looks good on a dark background
set background=dark
set t_Co=16
colorscheme gruvbox
set gfn=Consolas:h14

syntax enable "Enable syntax highlighting

set nobackup
set noswapfile

" Persistent undo
set undodir=~/.vim/undodir
set undofile

" Expands tab to spaces
set expandtab
set shiftwidth=2
set tabstop=2
set smarttab

" Indentation continued
set autoindent

" Automatic indentations for common programming language stuff (i.e. "{", "}")
set smartindent

" Break lines only at special characters and not mid-word
set linebreak

" Mark whitespace characters
set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.

set pastetoggle=<F2>

noremap h k
noremap k l
noremap l h

" No toolbar for GUI
set guioptions-=T

" To clear search results
nnoremap <leader><space> :nohlsearch<cr>

" To move between matching brackets just press Tab
nnoremap <tab> %
vnoremap <tab> %

" vim-easymotion
let g:EasyMotion_keys='uiaeosnrtdy'

" vim-asciidoctor
let g:asciidoctor_folding = 1

" coc.nvim
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Different colors for diffs
highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffDelete cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffChange cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffText   cterm=bold ctermfg=10 ctermbg=88 gui=none guifg=bg guibg=Red


