local merge = require("nskriabin.core.util.merge")
local configs = require("nskriabin.config.server_configs")

local function get_config(name, capabilities, on_attach)
    local lsp = require("lspconfig")
    local server_config = configs[name]
    local final_config = {}

    if type(server_config) == "function" then
        final_config = server_config(lsp)
    elseif type(server_config) == "table" then
        final_config = server_config
    end

    local overwritten_on_attach = function(client, bufnr)
        if final_config.on_attach then
            final_config.on_attach(client, bufnr)
        end
        on_attach(client, bufnr)
    end

    local config = merge({
        capabilities = capabilities,
        on_attach = overwritten_on_attach,
    }, final_config)

    return config
end

-- uses native lsp to display source actions
local function get_source_actions(client)
    vim.lsp.buf.code_action(nil, {
        mode = "source",
    })
end

-- uses native lsp to display code actions
local function get_code_actions(client)
    vim.lsp.buf.code_action(nil, client.offset_encoding)
end

local function snack(name)
    return function()
        Snacks.picker(name)
    end
end

return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        { "antosha417/nvim-lsp-file-operations", config = true },
        "williamboman/mason.nvim",
        "SmiteshP/nvim-navic",
        "folke/neoconf.nvim",
        "saghen/blink.cmp",
    },
    config = function()
        local lspconfig = require("lspconfig")
        local mason = require("mason-lspconfig")

        local map = vim.keymap -- for conciseness

        local opts = { noremap = true, silent = true }

        local on_attach = function(client, bufnr)
            opts.buffer = bufnr

            -- set keybinds
            opts.desc = "Show LSP references"
            map.set("n", "<leader>lr", snack("lsp_references"), opts) -- show definition, references

            opts.desc = "Show LSP definitions"
            map.set("n", "<leader>ld", snack("lsp_definitions"), opts) -- show lsp definitions

            opts.desc = "Show LSP declarations"
            map.set("n", "<leader>lc", snack("lsp_declarations"), opts) -- show lsp definitions

            opts.desc = "Show document symbols"
            map.set("n", "<leader>ls", snack("lsp_symbols"), opts) -- show lsp definitions

            opts.desc = "Show document symbols"
            map.set("n", "<leader>lS", snack("lsp_workspace_symbols"), opts) -- show lsp definitions

            opts.desc = "Show LSP implementations"
            map.set("n", "<leader>li", snack("lsp_implementations"), opts) -- show lsp implementations

            opts.desc = "Show LSP type definitions"
            map.set("n", "<leader>lD", snack("lsp_type_definitions"), opts) -- show lsp type definitions

            opts.desc = "See available code actions"
            map.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions

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
        local capabilities = require("blink.cmp").get_lsp_capabilities()
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
                if server == "emmet_language_server" then
                    return
                end
                lspconfig[server].setup(get_config(server, capabilities, on_attach))
            end,
        })
    end,
}
