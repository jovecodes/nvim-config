return {
	{
		'neovim/nvim-lspconfig',
		dependencies = { 'saghen/blink.cmp' },

		-- example using `opts` for defining servers
		opts = { },
		-- example calling setup directly for each LSP
		config = function()
			local capabilities = require('blink.cmp').get_lsp_capabilities()
			local lspconfig = require('lspconfig')

			lspconfig['clangd'].setup({
				capabilities = capabilities,
                enabled = false,
			})

			vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
				vim.lsp.diagnostic.on_publish_diagnostics, {
					virtual_text = false
				}
			)

			vim.api.nvim_create_autocmd("LspAttach", {
			    group = vim.api.nvim_create_augroup("UserLspKeymaps", { clear = true }),
                callback = function(ev)
                    local opts = { buffer = ev.buf, noremap = true, silent = true }

                    vim.keymap.set('n', "<leader>cd", function() vim.lsp.buf.hover() end, opts)
                    vim.keymap.set('n', "<leader>R", function() vim.lsp.buf.rename() end, opts)
                    vim.keymap.set('n', "<leader>ce", function()
                        vim.diagnostic.open_float({ header = "Buffer Diagnostics", scope = "buffer" })
                    end, opts)
                    vim.keymap.set('n', "<leader>cp", function() vim.diagnostic.goto_prev() end, opts)
                    vim.keymap.set('n', "<leader>cn", function() vim.diagnostic.goto_next() end, opts)
                end,
			})
		end
	},
}
