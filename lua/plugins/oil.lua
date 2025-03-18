return {
	{
		'stevearc/oil.nvim',
		config = function()
			require("oil").setup()
			vim.keymap.set("n", "<leader>e", "<cmd>Oil<cr>", { desc = "View filesystem" })
		end
	}
}
