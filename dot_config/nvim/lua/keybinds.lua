-- set leader key to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "


-- mini files
vim.keymap.set('n', '-', function()
  MiniFiles.open(vim.api.nvim_buf_get_name(0))
end, { desc = 'Open explorer at current file' })

-- errors
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show full LSP diagnostic' })


