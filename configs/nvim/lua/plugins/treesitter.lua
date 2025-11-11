return {
    "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    config = function()
        require("nvim-treesitter.configs").setup {
            ensure_installed = { "c", "rust", "lua" },
            auto_install = true,
            highlight = {
                enable = true
            }
        }
    end
}
