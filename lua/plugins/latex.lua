return {
    {
        "lervag/vimtex", --> LaTeX integration
        config = function() 
            vim.g.tex_flavor = "latex" 
            vim.g.vimtex_view_method = "zathura"
        end,
        ft = { "plaintex", "tex" },
    },
}
