vim.opt.clipboard = "unnamedplus"

vim.api.nvim_set_keymap('n', "<leader>/",  "<CMD>let @/=''<CR>", { noremap = true, silent = true })

-- vim.o.termguicolors = true  -- enable rgb colors

vim.o.cursorline = true     -- enable cursor line

vim.o.number = true         -- enable line number
vim.o.relativenumber = true -- and relative line number

vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.spelllang = "en"
vim.o.spellsuggest = "best,8"

vim.o.history = 100
vim.o.undolevels = 1000
vim.o.undofile = true

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.scrolloff = 8

-- local timer = vim.uv.new_timer()
-- timer:start(0, 1000, vim.schedule_wrap(function()
--     local bufnr = vim.api.nvim_get_current_buf()
--     require("compile-mode")._parse_errors(bufnr)
-- end))
