return {
    "folke/which-key.nvim",
    priority = 1000,
    config = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 1500
        require("which-key").setup()
    end
}
