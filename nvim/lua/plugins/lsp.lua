local lsp_server_hashmap = {
    ["rust"]     = "rust_analyzer",
    ["ts"]       = "tsserver",
    ["python"]   = "pyright",
    ["lua"]      = "lua_ls",
    ["c"]        = "clangd",
    ["go"]       = "gopls",
}
local servers = {
    servers = {
        -- Overrides the default server
        ["rust"] = {
            config = function(default_on_attach)
                local rt = require("rust-tools")
                rt.setup({
                    server = {
                        on_attach = default_on_attach
                    }
                })
                rt.inlay_hints.enable()
            end
        },
    }
}

local function default_on_attach (_, bufnr)
    local bufopts = function(desc)
        return { noremap = true, silent = true, buffer = bufnr, desc = desc }
    end
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts("Goto Declaration [LSP]"))
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts("Goto Definition [LSP]"))
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts("Goto References [LSP]"))
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts("Goto Implementation [LSP]"))
    vim.keymap.set('n', 'gtD', vim.lsp.buf.type_definition, bufopts("Goto Type Definition [LSP]"))

    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts("Show Hover Documentation [LSP]"))

    vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, bufopts("Code Action [LSP]"))
    vim.keymap.set('n', '<leader>lf', function()
        vim.lsp.buf.format({ async = true })
    end, bufopts("Format Buffer [LSP]"))
    vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, bufopts("Rename Symbol [LSP]"))
end
local default_flags = { debounce_text_changes = 150, }

local function get_lsp_servers()
    local ret = {}
    for _, package in pairs(lsp_server_hashmap) do
        table.insert(ret, package)
    end
    return ret
end


local function setup_cmp()
    -- stylua: ignore start
    local luasnip = require("luasnip")
    local cmp = require("cmp")
    local mappings = {
        ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    }
    -- stylua: ignore end

    cmp.setup({
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body)
            end,
        },
        mapping = cmp.mapping.preset.insert(mappings),
        sources = {
            { name = "nvim_lsp" },
            { name = "crates" },
            { name = "path",    max_item_count = 20 },
            { name = "luasnip" },
            { name = "buffer",  keyword_length = 5 },
            { name = "codeium" },
        }
    })
end

return {
    { "simrat39/rust-tools.nvim",          event = "VeryLazy" },

    { "williamboman/mason.nvim",           event = "VeryLazy",
      config = function()
          require("mason").setup()
      end
    },
    { "williamboman/mason-lspconfig.nvim", event = "VeryLazy",
      opts = {
          ensure_installed = get_lsp_servers(),
      },
    },
    { "neovim/nvim-lspconfig",             event = "VeryLazy",
      config = function()
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        local lspconfig = require("lspconfig")

        for name, server_name in pairs(lsp_server_hashmap) do
            if servers.servers[name] ~= nil then
                servers.servers[name].config(default_on_attach)
            else
                lspconfig[server_name].setup({
                    flags = default_flags,
                    on_attach = default_on_attach,
                    capabilities = capabilities,
                })
            end
        end
      end
    },
    { "hrsh7th/nvim-cmp",                  event = "VeryLazy",
       config = setup_cmp,
    },
    { "hrsh7th/cmp-path",                  event = "VeryLazy" },
    { "hrsh7th/cmp-nvim-lsp",              event = "VeryLazy" },
    { "saadparwaiz1/cmp_luasnip",          event = "VeryLazy" },
    { "L3MON4D3/LuaSnip",                  event = "VeryLazy",
      config = function()
          require("luasnip")
      end
    },
}
