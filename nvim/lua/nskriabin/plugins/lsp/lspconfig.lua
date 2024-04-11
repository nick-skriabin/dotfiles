local merge = require("nskriabin.core.util.merge")
local configs = require("nskriabin.config.server_configs")

local function get_config(name, capabilities, on_attach)
    local lsp = require("lspconfig")
    local server_config = {}
    local cfg = configs[name]

    if type(server_config) == "function" then
        server_config = server_config(lsp)
    elseif type(server_config) == "table" then
        server_config = server_config
    end

    local overriden_on_attach = function(client, bufnr)
        if server_config.on_attach then
            server_config.on_attach(client, bufnr)
        end
        on_attach(client, bufnr)
    end

    local config = merge({
        capabilities = capabilities,
        on_attach = overriden_on_attach,
    }, server_config)

    return config
end

return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        { "antosha417/nvim-lsp-file-operations", config = true },
        "williamboman/mason.nvim",
        "yioneko/nvim-vtsls",
        "SmiteshP/nvim-navic",
        "folke/neoconf.nvim",
        "hrsh7th/nvim-cmp",
    },
    config = function()
        local lspconfig = require("lspconfig")
        local navic = require("nvim-navic")
        local mason = require("mason-lspconfig")

        require("lspconfig.configs").vtsls = require("vtsls").lspconfig

        -- import cmp-nvim-lsp plugin
        local cmp_nvim_lsp = require("cmp_nvim_lsp")

        local map = vim.keymap -- for conciseness

        local opts = { noremap = true, silent = true }

        local navic_attach = function(client, bufnr)
            if client.server_capabilities.documentSymbolProvider then
                navic.attach(client, bufnr)
            end
        end

        local on_attach = function(client, bufnr)
            navic_attach(client, bufnr)

            opts.buffer = bufnr

            -- set keybinds
            opts.desc = "Show LSP references"
            map.set("n", "gr", "<cmd>Glance references<CR>", opts) -- show definition, references

            opts.desc = "Show LSP definitions"
            map.set("n", "gd", "<cmd>Glance definitions<CR>", opts) -- show lsp definitions

            opts.desc = "Show LSP implementations"
            map.set("n", "gi", "<cmd>Glance implementations<CR>", opts) -- show lsp implementations

            opts.desc = "Show LSP type definitions"
            map.set("n", "gt", "<cmd>Glance type_definitions<CR>", opts) -- show lsp type definitions

            opts.desc = "See available code actions"
            map.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

            opts.desc = "See available source actions"
            map.set("n", "<leader>cA", function()
                vim.lsp.buf.code_action({
                    context = {
                        only = { "source" },
                        diagnostics = {},
                    },
                })
            end, opts) -- see available code actions, in visual mode will apply to selection

            opts.desc = "Rename Symbol"
            map.set("n", "<leader>cr", vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename" }) -- smart rename

            opts.desc = "Show buffer diagnostics"
            map.set("n", "<leader>cd", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

            opts.desc = "Show line diagnostics"
            map.set("n", "gl", vim.diagnostic.open_float, opts) -- show diagnostics for line

            opts.desc = "Go to previous diagnostic"
            map.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

            opts.desc = "Go to next diagnostic"
            map.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

            opts.desc = "Show documentation for what is under cursor"
            map.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor
        end

        -- used to enable autocompletion (assign to every lsp server config)
        local capabilities = cmp_nvim_lsp.default_capabilities()

        capabilities.textDocument.foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true,
        }

        -- Change the Diagnostic symbols in the sign column (gutter)
        -- (not in youtube nvim video)
        local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }

        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
        end

        vim.tbl_deep_extend("keep", lspconfig, {
            cmd = { "gleam", "lsp" },
            filetypes = { "gleam" },
        })
        lspconfig.gleam.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            root_dir = lspconfig.util.root_pattern("gleam.toml"),
        })

        mason.setup_handlers({
            function(server)
                local config = get_config(server, capabilities, on_attach)
                lspconfig[server].setup(config)
            end,
        })
    end,
}
