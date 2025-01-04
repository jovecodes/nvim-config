vim.opt.clipboard = "unnamedplus"

-- vim.api.nvim_set_keymap('n', '<leader>r', ':botright split | terminal ./build.sh<CR>', { noremap = true, silent = true })

vim.o.termguicolors = true  -- enable rgb colors

vim.o.cursorline = true     -- enable cursor line

vim.o.number = true         -- enable line number
vim.o.relativenumber = true -- and relative line number

vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.spelllang = "en"
vim.o.spellsuggest = "best,8"
