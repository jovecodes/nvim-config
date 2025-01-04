return {
	{
		'stevearc/oil.nvim',
		dependencies = { { "echasnovski/mini.icons", opts = {} } },
		config = function()
			require("oil").setup()
			vim.keymap.set("n", "<leader>v", "<cmd>Oil<cr>", { desc = "View filesystem" })
		end
	}
}
