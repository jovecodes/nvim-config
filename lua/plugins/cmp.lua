return {
    {
        'saghen/blink.cmp',
        version = '*',
        opts = {
            keymap = {
                -- Disable the default preset
                preset = 'none',

                -- Navigate items manually
                ['<C-k>'] = { 'select_prev', 'fallback' },
                ['<C-j>'] = { 'select_next', 'fallback' },
                ['<C-f>'] = { 'accept', 'fallback' },
            },

            appearance = {
                use_nvim_cmp_as_default = true,
                nerd_font_variant = 'mono',
            },

            completion = {
                accept = { auto_brackets = { enabled = false }, },
                list = { selection = 'auto_insert' },
                -- or set per mode
                list = { selection = function(ctx) return ctx.mode == 'cmdline' and 'auto_insert' or 'preselect' end },

                menu = {
                    -- Don't automatically show the completion menu
                    auto_show = false,

                    -- nvim-cmp style menu
                    draw = {
                        columns = {
                            { "label", "label_description", gap = 1 },
                            { "kind_icon", "kind" }
                        },
                    }
                },

                -- Show documentation when selecting a completion item
                documentation = { auto_show = true, auto_show_delay_ms = 500 },

                -- Display a preview of the selected item on the current line
                ghost_text = { enabled = true },
            },

            -- Sources for completion
            sources = {
                default = { 'lsp', 'path', 'buffer' },
            },
        },
    },
}

