-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Plugin specifications
return require('lazy').setup({
  -- Common configuration stuff for the built-in LSP client
  'neovim/nvim-lspconfig',

  -- Rust support (modern replacement for rust-tools.nvim)
  {
    'mrcjkb/rustaceanvim',
    version = '^6',
    lazy = false,
  },

  -- Completion framework
  'hrsh7th/nvim-cmp',

  -- Completion sources for nvim-cmp
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-cmdline',
  'saadparwaiz1/cmp_luasnip',

  -- Fuzzy finder
  'nvim-lua/plenary.nvim',
  'nvim-telescope/telescope.nvim',

  -- Color scheme
  'shaunsingh/nord.nvim',

  -- Keyboard navigation
  'ggandor/lightspeed.nvim',

  'L3MON4D3/LuaSnip',

  -- File tree plugin and icons for file types
  {
    'kyazdani42/nvim-tree.lua',
    dependencies = {
      'kyazdani42/nvim-web-devicons',
    },
  },

  -- Java LSP bindings
  -- TODO: 'mfussenegger/nvim-jdtls'

  -- Plugin to show all open buffers
  {
    'akinsho/bufferline.nvim',
    dependencies = 'kyazdani42/nvim-web-devicons'
  },

  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = { "rust" },
        highlight = {
          enable = true
        },
        incremental_selection = {
          enable = true
        },
        indent = {
          enable = true
        }
      })
    end
  },

  -- Statusline
  'famiu/feline.nvim',

  -- Git "annotations" (has integration with feline)
  -- Disabled because I received an error with 0.6 nightly
  --[[
  {
    'lewis6991/gitsigns.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim'
    },
    config = function()
      require('gitsigns').setup()
    end
  },
  --]]

  -- Indentation guidelines
  {
    'lukas-reineke/indent-blankline.nvim',
    --    config = function()
     -- require('indent_blankline').setup({
      --  show_current_context = true
--      })
 --   end
  },

  {
    'VonHeikemen/searchbox.nvim',
    dependencies = {
      'MunifTanjim/nui.nvim'
    }
  },
})
