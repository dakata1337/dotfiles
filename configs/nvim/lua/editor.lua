vim.loader.enable() -- enable module caching

vim.g.mapleader = " "
vim.g.mallocalleader = " "
vim.g.have_nerd_font = true

vim.o.expandtab = true
vim.o.smartindent = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4

vim.wo.number = true
vim.wo.relativenumber = true
vim.o.showmode = false

vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = "yes"
vim.o.updatetime = 250
vim.o.timeoutlen = 300

vim.o.splitright = true
vim.o.splitbelow = true

vim.o.inccommand = "split" -- live substitution preview
vim.o.confirm = true

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

-- Disable arrow keys
for _, mode in pairs({ "n", "i", "v", "x" }) do
	for _, key in pairs({ "<Up>", "<Down>", "<Left>", "<Right>" }) do
		vim.keymap.set(mode, key, "<nop>")
	end
end

-- Paste/Yank from clipboard
vim.keymap.set({ "n", "v" }, "<leader>p", [["+p]], { desc = "Paste from system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>P", [["+P]], { desc = "Paste (above) from system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>Y", [["+Y]], { desc = "Yank to system clipboard" })
