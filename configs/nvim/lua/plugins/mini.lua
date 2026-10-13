return {
	install = function(gh)
		vim.pack.add({ gh("nvim-mini/mini.nvim") })
	end,

	setup = function()
		if vim.g.have_nerd_font then
			require("mini.icons").setup()
			MiniIcons.mock_nvim_web_devicons()
		end

		local statusline = require("mini.statusline")
		statusline.setup({ use_icons = vim.g.have_nerd_font })
		statusline.section_location = function()
			return "%2l:%-2v"
		end
	end,
}
