return require('packer').startup(function(use)

  -- Packer can manage itself
  use('wbthomason/packer.nvim')

  

  -- Common configuration stuff for the built-in LSP client
  use('neovim/nvim-lspconfig')

  use {
    'simrat39/rust-tools.nvim',
    config = function()
      require('rust-tools').setup({})
    end
  }
    

  -- Completion framework
  use('hrsh7th/nvim-cmp')
  
  -- Completion sources for nvim-cmp
  use('hrsh7th/cmp-nvim-lsp')
  use('hrsh7th/cmp-path')
  use('hrsh7th/cmp-buffer')
  use('hrsh7th/cmp-cmdline')
  use('saadparwaiz1/cmp_luasnip')

  -- Fuzzy finder
  use('nvim-lua/plenary.nvim')
  use('nvim-telescope/telescope.nvim')
  
  -- Color scheme
  use('shaunsingh/nord.nvim')
  
  -- Keyboard navigation
  use('ggandor/lightspeed.nvim')
  
  use('L3MON4D3/LuaSnip')
  
  -- File tree plugin and icons for file types
  use {
  'kyazdani42/nvim-tree.lua',
  requires = {
    'kyazdani42/nvim-web-devicons', -- optional, for file icons
  },
}
  
  -- Java LSP bindings
  -- TODO: Plug 'mfussenegger/nvim-jdtls'
  
  -- Plugin to show all open buffers
  use {
    'akinsho/bufferline.nvim',
    branch = "main",
    requires = 'kyazdani42/nvim-web-devicons'
  }

  -- Requires neovim 0.6
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
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
  }
  
  -- Statusline
  use('famiu/feline.nvim')

  -- Git "annotations" (has integration with feline)
  -- Disabled because I received an error with 0.6 nightly
  --[[
  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
    config = function()
      require('gitsigns').setup()
end
  } --]]

  -- Indentation guidelines
  use {
    'lukas-reineke/indent-blankline.nvim',
    --    config = function()
     -- require('indent_blankline').setup({
      --  show_current_context = true
--      })
 --   end
  }

  use {
    'VonHeikemen/searchbox.nvim',
    requires = {
      { 'MunifTanjim/nui.nvim' }
    }
  }

end)

