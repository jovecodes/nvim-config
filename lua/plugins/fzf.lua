return {
	{
		"ibhagwan/fzf-lua",
		dependencies = { "echasnovski/mini.icons" },
		opts = {},
		config = function()
			-- Keymaps for fzf-lua
			vim.keymap.set("n", "<leader>f", "<cmd>FzfLua files<cr>", { desc = "Find files" })
			vim.keymap.set("n", "<leader>g", "<cmd>FzfLua live_grep<cr>", { desc = "Grep string" })
		end,
	},
}
