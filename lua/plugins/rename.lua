return {
    {
        "johmsalas/text-case.nvim",
        config = function()
            require("textcase").setup({})
        end,
        keys = {
            "ga", -- Default invocation prefix
        },
        cmd = {
            "Subs",
        },
        enabled_methods = {
            "to_snake_case",
            "to_dash_case",
            "to_constant_case",
            "to_camel_case",
            "to_pascal_case",
            "to_title_case",
            "to_path_case",
        },
        lazy = false,
    }
    
    -- {
    --     "tpope/vim-abolish",
    --     cmd = { "Subvert", "S", "Abolish" }, -- Load when these commands are used
    --     lazy = false,
    -- },
}
