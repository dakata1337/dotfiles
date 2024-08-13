local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Get all plugin
local wd = vim.fn.stdpath("config")
local cwDir = wd .. "/lua/plugins"
local cwdContent = vim.split(vim.fn.glob(cwDir .. "/*"), '\n', {trimempty=true})

local lazy = require("lazy")

-- Load all plugins
local plugins = {}
for _, cwdItem in pairs(cwdContent) do
	table.insert(plugins, dofile(cwdItem))
end

lazy.setup(plugins)
