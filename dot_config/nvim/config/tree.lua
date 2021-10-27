require('nvim-tree').setup({
  update_focused_file = {
    enable = true,
  }
})

local map = vim.api.nvim_set_keymap

map('n', '<C-n>', ':NvimTreeToggle<CR>', {noremap = true})

