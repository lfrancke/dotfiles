let mapleader=","

set background=light
set history=1000

" Abandoned buffers are hidden and not unloaded
set hidden

" Start with all folds open
set foldlevelstart=99

" Shows partial commands in the status line while they are being entered
set showcmd

" Enable filetype detection and the filetype and indent plugins
filetype on
filetype plugin on
filetype indent on

" Reload file when changed outside of Vim and there are no changes in Vim yet
set autoread

" How many lines are kept in view when scrolling
set scrolloff=7

"Always show current position
set ruler

" This is actually the default backspace behavior which allows. See :help
" 'backspace'
set backspace=indent,eol,start

" Use true color support
set termguicolors
colorscheme nord

" Allow all kinds of actions with the mouse (move cursor etc.)
set mouse=a

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

" I believe this might be redundant but doesnt seem to hurt either
set encoding=utf8

"""" REVIEWED SETTINGS UP UNTIL HERE, NOT BELOW

" Sets colors to something that looks good on a dark background
"set background=dark
"set t_Co=16
"set gfn=Consolas:h14

syntax enable "Enable syntax highlighting

set nobackup
set noswapfile

" Persistent undo
set undodir=~/.config/nvim/undodir
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

" vim-asciidoctor
let g:asciidoctor_folding = 1


" nvim-cmp
set completeopt=menu,menuone,noselect

lua <<EOF
  -- Setup nvim-cmp.
  local has_words_before = function()
    local cursor = vim.api.nvim_win_get_cursor(0)
    return (vim.api.nvim_buf_get_lines(0, cursor[1] - 1, cursor[1], true)[1] or ''):sub(cursor[2], cursor[2]):match('%s') 
  end 
  local cmp = require('cmp')
  local luasnip = require('luasnip')

  cmp.setup({
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    mapping = {
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, { "i", "s" }),

       ["<S-Tab>"] = cmp.mapping(function(fallback)
         if cmp.visible() then
           cmp.select_prev_item()
         elseif luasnip.jumpable(-1) then
           luasnip.jump(-1)
         else
           fallback()
         end
      end, { "i", "s" }),
    },
    sources = {
      { name = 'nvim_lsp' },
      { name = 'buffer' },
      { name = 'path' },
      { name = 'cmdline' },
      { name = 'luasnip' },
    }
  })

  -- Use cmdline & path source for ':'.
  cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' }
    }
  })

  -- Setup lspconfig.
  require('lspconfig').rust_analyzer.setup {
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  }
EOF

