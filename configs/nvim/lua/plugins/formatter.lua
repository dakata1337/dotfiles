return {
	install = function(gh)
		vim.pack.add({ gh("stevearc/conform.nvim") })
	end,

	setup = function()
		require("conform").setup({
			notify_on_error = false,
			default_format_opts = {
				lsp_format = "fallback",
			},
		})
		vim.keymap.set({ "n", "v" }, "<leader>lf", function()
			require("conform").format({ async = true })
		end, { desc = "[F]ormat buffer" })
	end,
}
