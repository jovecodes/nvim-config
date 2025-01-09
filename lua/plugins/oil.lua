return {
	{
		'stevearc/oil.nvim',
		dependencies = { { "echasnovski/mini.icons", opts = {} } },
		config = function()
			require("oil").setup()
			vim.keymap.set("n", "<leader>e", "<cmd>Oil<cr>", { desc = "View filesystem" })
		end
	}
}
