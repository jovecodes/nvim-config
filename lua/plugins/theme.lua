return {
    {
        'eddyekofo94/gruvbox-flat.nvim',
        -- config = function()
        --     vim.cmd([[
        --     try
        --     colo gruvbox-flat
        --     catch
        --     colo slate
        --     endtry
        --     ]])
        -- end,
    },
    {
        'alljokecake/naysayer-theme.nvim',
        config = function()
            require('naysayer').setup({
                variant = 'main',
                dark_variant = 'main',
                bold_vert_split = false,
                dim_nc_background = true,
                disable_background = true,
                disable_float_background = true,
                disable_italics = true,
            })
        end
    },
}
