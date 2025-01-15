return {
	{
		"ibhagwan/fzf-lua",
		dependencies = { "echasnovski/mini.icons" },
		opts = {},
		config = function()
			-- Keymaps for fzf-lua
			vim.keymap.set("n", "<leader>f", "<cmd>FzfLua files<cr>", { desc = "Find files" })
			vim.keymap.set("n", "<leader>g", "<cmd>FzfLua live_grep<cr>", { desc = "Grep string" })

            vim.keymap.set('n', '<leader>ld', "<cmd>FzfLua lsp_definitions<cr>", {})
            vim.keymap.set('n', '<leader>li', "<cmd>FzfLua lsp_implementations<cr>", {})
            vim.keymap.set('n', '<leader>lr', "<cmd>FzfLua lsp_references<cr>", {})
            vim.keymap.set('n', '<leader>lf', "<cmd>FzfLua lsp_finder<cr>", {})
		end,
	},
}
