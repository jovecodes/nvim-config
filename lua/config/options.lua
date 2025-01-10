vim.opt.clipboard = "unnamedplus"

vim.api.nvim_set_keymap('n', "<leader>/",  "<CMD>let @/=''<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>r', '<CMD>botright split | terminal ./build.jov.sh<CR>', { noremap = true, silent = true })
vim.api.nvim_create_autocmd("TermOpen", {
    group = vim.api.nvim_create_augroup("AutoEnterTerminal", { clear = true }),
    callback = function()
        vim.cmd("startinsert") -- Automatically enter insert mode
    end,
})

vim.api.nvim_set_keymap('n', '<leader>d', '<CMD>Recompile<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>tp', '<CMD>NextError<CR>', { noremap = true, silent = true })
vim.api.nvim_create_user_command('C', 'Compile <args>', {
  nargs = '*',
  complete = 'file',  -- Enable file path autocompletion
})
vim.api.nvim_create_user_command('R', 'Recompile', {})


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
