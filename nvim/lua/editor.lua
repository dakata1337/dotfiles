vim.g.mapleader = " "
vim.cmd("set termguicolors")
vim.cmd "set noshowmode"
vim.cmd "set laststatus=3"

-- Set tab to 4 spaces (like a normal person)
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.smarttab = true
vim.opt.expandtab = true

-- Line numbers
vim.wo.number = true
vim.wo.relativenumber = true

-- Presist undos when the editor closes
vim.opt.undofile = true

-- Disable arrow keys
for _, mode in pairs({ 'n', 'i', 'v', 'x' }) do
	for _, key in pairs({ '<Up>', '<Down>', '<Left>', '<Right>' }) do
	    vim.keymap.set(mode, key, '<nop>')
	end
end

-- Paste/Yank from clipboard
vim.keymap.set({ "n", "v" }, "<leader>p", [["+p]], { desc = "Paste from system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>P", [["+P]], { desc = "Paste (above) from system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>Y", [["+Y]], { desc = "Yank to system clipboard" }) 

-- Always focus new splits
vim.cmd "set splitbelow"
vim.cmd "set splitright" 
