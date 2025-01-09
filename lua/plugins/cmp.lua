local complete = false

vim.keymap.set("i", "<C-f>", function()
    complete = not complete
    local cmp = require("blink.cmp")

    if complete then
        cmp.show()
    else
        cmp.select_and_accept()
        cmp.hide()
    end
end, { noremap = true, silent = true })

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
                -- ['<C-f>'] = { 'accept', 'fallback' },
            },

            completion = {
              menu = {
                auto_show = function(ctx)
                  return complete and ctx.mode ~= "cmdline" and not vim.tbl_contains({ '/', '?' }, vim.fn.getcmdtype())
                end,
              },
            },

            -- Sources for completion
            sources = {
                default = { 'lsp', 'path', 'buffer' },
            },
        },
    },
}
