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
            "to_constant_case",
            "to_camel_case",
            "to_pascal_case",
        },
        lazy = false,
    }
}
