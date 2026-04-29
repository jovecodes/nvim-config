vim.opt.clipboard = "unnamedplus"

vim.o.termguicolors = true
vim.o.cursorline = true

vim.o.number = true
vim.o.relativenumber = true
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

vim.g.mapleader      = " "
vim.g.maplocalleader = "\\"

vim.o.makeprg = "./build.jov.sh"
vim.keymap.set("n", "<leader>r", ":make<CR>",  { desc = "Run :make" })
vim.keymap.set("n", "<leader>n", ":cnext<CR>", { desc = "Next quickfix item" })

vim.keymap.set("n", "<leader>/", "<cmd>let @/=''<cr>", { silent = true })
vim.cmd("nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>")

vim.filetype.add({
  extension = {
    vs = "glsl",
    fs = "glsl",
    gs = "glsl",
  },
})

vim.api.nvim_create_user_command("ExtractCFunc", function()
    require("extract_c").extract()
end, {})

vim.pack.add({
    "https://github.com/stevearc/oil.nvim",
    "https://github.com/tpope/vim-fugitive",
    "https://github.com/tpope/vim-abolish",
    "https://github.com/junegunn/vim-easy-align",
    "https://github.com/ibhagwan/fzf-lua",
    "https://github.com/blazkowolf/gruber-darker.nvim",
    "https://github.com/numToStr/Comment.nvim",
    "https://github.com/beyondmarc/hlsl.vim",
    -- {
    --     'chomosuke/typst-preview.nvim',
    --     ft = 'typst',
    -- },
})

vim.cmd("packadd nvim.undotree")

require("oil").setup()
vim.keymap.set("n", "<leader>e", "<cmd>Oil<cr>", { desc = "View filesystem" })

require('fzf-lua').setup({
    previewers = {
        find = {
            rg_opts = [[--color=never --hidden --files -g "!.git" --no-binary]]
        }
    }
})

-- Keymaps for fzf-lua
vim.keymap.set("n", "<leader>af", "<cmd>FzfLua git_files<cr>", { desc = "Find files" })
vim.keymap.set("n", "<leader>f", "<cmd>FzfLua files<cr>", { desc = "Find files" })
vim.keymap.set("n", "<leader>g", "<cmd>FzfLua live_grep<cr>", { desc = "Grep string" })

require("Comment").setup({
    padding = true, -- Add a space b/w comment and the line
    sticky = true, -- Whether the cursor should stay at its position
    ignore = nil, -- Lines to be ignored while (un)comment
    toggler = { -- LHS of toggle mappings in NORMAL mode
        line = '<leader>cc', -- Line-comment toggle keymap
        block = '<leader>bc', -- Block-comment toggle keymap
    },
    opleader = { -- LHS of operator-pending mappings in NORMAL and VISUAL mode
        line = '<leader>c', -- Line-comment keymap
    },
    mappings = {
        basic = true, -- Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
    },
})

require("gruber-darker").setup({
    italic = {
      strings = false,
      comments = false,
    },
  }
)

vim.cmd("colorscheme gruber-darker")
-- vim.opt.autochdir = true
