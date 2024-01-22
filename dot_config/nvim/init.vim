lua require("plugins")

" Automatically compile the Packer suff on save
" vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
" ]])

"source ~/.config/nvim/options.vim
"source ~/.config/nvim/keys.vim

source ~/.config/nvim/config/lsp.lua
source ~/.config/nvim/config/tree.lua
"source ~/.config/nvim/config/bufferline.lua
"source ~/.config/nvim/config/feline.lua
