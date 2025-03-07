return {
    {
        "numToStr/Comment.nvim",
        -- event = "VeryLazy",
        config = function() 
            local status_ok, comment = pcall(require, "Comment")
            if not status_ok then
                return
            end

            comment.setup({
                ---Add a space b/w comment and the line
                padding = true,
                ---Whether the cursor should stay at its position
                sticky = true,
                ---Lines to be ignored while (un)comment
                ignore = nil,
                ---LHS of toggle mappings in NORMAL mode
                toggler = {
                    ---Line-comment toggle keymap
                    line = '<leader>cc',
                    ---Block-comment toggle keymap
                    block = '<leader>bc',
                },
                ---LHS of operator-pending mappings in NORMAL and VISUAL mode
                opleader = {
                    ---Line-comment keymap
                    line = '<leader>c',
                    ---Block-comment keymap
                    -- block = '<leader>bc',
                },
                ---Enable keybindings
                ---NOTE: If given `false` then the plugin won't create any mappings
                mappings = {
                    ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
                    basic = true,
                },
                ---Function to call before (un)comment
                pre_hook = nil,
                ---Function to call after (un)comment
                post_hook = nil,
            })
        end
    },
}
