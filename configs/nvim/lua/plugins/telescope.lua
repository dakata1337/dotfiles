return {
	install = function(gh)
		local telescope_plugins = {
			gh("nvim-lua/plenary.nvim"),
			gh("nvim-telescope/telescope.nvim"),
			gh("nvim-telescope/telescope-ui-select.nvim"),
		}
		if vim.fn.executable("make") == 1 then
			table.insert(telescope_plugins, gh("nvim-telescope/telescope-fzf-native.nvim"))
		end
		vim.pack.add(telescope_plugins)
	end,

	setup = function()
		require("telescope").setup({
			extensions = {
				["ui-select"] = { require("telescope.themes").get_dropdown() },
			},
		})

		-- Enable Telescope extensions if they are installed
		pcall(require("telescope").load_extension, "fzf")
		pcall(require("telescope").load_extension, "ui-select")
		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[S]earch [F]iles" })
		vim.keymap.set("n", "<leader>fw", builtin.live_grep, { desc = "[S]earch by [G]rep" })
		vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })
	end,
}
