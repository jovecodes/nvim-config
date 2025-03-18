vim.opt.clipboard = "unnamedplus"

vim.api.nvim_set_keymap('n', "<leader>/",  "<CMD>let @/=''<CR>", { noremap = true, silent = true })

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

vim.o.history = 100
vim.o.undolevels = 1000
vim.o.undofile = true

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.scrolloff = 8

local theme = {}

theme.set_highlights = function(colors)
  vim.api.nvim_set_hl(0, "Type", { fg="NvimLightYellow" })
  vim.api.nvim_set_hl(0, "StatusLine", { fg="NvimLightGrey3", bg="NvimDarkGrey3" })
  vim.api.nvim_set_hl(0, "BlinkCmpMenuSelection", { bg="NvimDarkGrey3", bold=true })

  vim.api.nvim_set_hl(0, "Macro", { bold=true })
  vim.api.nvim_set_hl(0, "Include", { link="Macro" })

  vim.api.nvim_set_hl(0, "Constant", { fg="#99e6d5" })
  vim.api.nvim_set_hl(0, "Number", { link="Constant" })

  vim.api.nvim_set_hl(0, "String", { fg="#90a959" })

  vim.api.nvim_set_hl(0, "Identifier", { fg="NvimLightGrey2" })
  vim.api.nvim_set_hl(0, "BlinkCmpKind", { link="Identifier" })

  vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg="#90a959" })

  local blue = "#8ec0ef"
  vim.api.nvim_set_hl(0, "Function", { fg=blue })
  vim.api.nvim_set_hl(0, "Special", { link="Function" })
end

theme.set_highlights(theme.colors)

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        -- import your plugins
        { import = "plugins" },
    },
    -- Configure any other settings here. See the documentation for more details.
    -- colorscheme that will be used when installing plugins.
    -- install = { colorscheme = { "gruvbox-flat" } },
    -- automatically check for plugin updates
    checker = {
        -- automatically check for plugin updates
        enabled = false,
        concurrency = nil, ---@type number? set to 1 to check for updates very slowly
        notify = true, -- get a notification when new updates are found
        frequency = 3600, -- check for updates every hour
        check_pinned = false, -- check for pinned packages that can't be updated
    },

    performance = {
        cache = {
            enabled = true,
        },
        reset_packpath = true, -- reset the package path to improve startup time
        rtp = {
            reset = true, -- reset the runtime path to $VIMRUNTIME and your config directory
            ---@type string[]
            paths = {}, -- add any custom paths here that you want to includes in the rtp
            ---@type string[] list any plugins you want to disable here
            disabled_plugins = {
                "gzip",
                "matchit",
                "matchparen",
                "netrwPlugin",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
})

require("compile_mode")
