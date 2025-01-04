return {
    {
        'eddyekofo94/gruvbox-flat.nvim',
        config = function()
            vim.cmd([[
            try
            colo gruvbox-flat
            catch
            colo slate
            endtry
            ]])
        end,
    },
}
