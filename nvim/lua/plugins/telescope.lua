return { 
	"nvim-telescope/telescope.nvim", 
	opts = {},
    config = function()
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Opens fuzzy file search" })
        vim.keymap.set('n', '<leader>fw', builtin.live_grep, { desc = "Opens fuzzy word search (inside files)" })
        vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Opens fuzzy buffer search" })
        vim.keymap.set('n', '<leader>h', builtin.help_tags, { desc = "Opens fuzzy help search" })
    end
}
