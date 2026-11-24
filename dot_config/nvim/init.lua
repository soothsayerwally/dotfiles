-- imports
require("keybinds")
require("options")


-- vim pack
vim.pack.add({
  'https://github.com/nvim-mini/mini.nvim',
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/nvim-treesitter/nvim-treesitter',
  'https://github.com/nmac427/guess-indent.nvim',
  'https://github.com/rebelot/kanagawa.nvim',
})

-- lsp shenanigans
vim.lsp.enable({ 
  'lua_ls',
  'clangd',
  'rust_analyzer',
  'pyright',
})

-- colorscheme
vim.cmd("colorscheme kanagawa-dragon")
        
-- plugin config
require('mini.basics').setup()
require('mini.surround').setup()
require('mini.statusline').setup()
require('mini.files').setup()
require('mini.pairs').setup()
require('mini.pick').setup()
require('mini.move').setup()
require('mini.completion').setup()
require('mini.icons').setup()
require('mini.snippets').setup()
require('guess-indent').setup()



