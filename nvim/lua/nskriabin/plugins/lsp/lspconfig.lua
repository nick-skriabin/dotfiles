local merge = require("nskriabin.core.util.merge")
local configs = require("nskriabin.config.server_configs")
local if_nil = function(val, default)
    if val == nil then
        return default
    end
    return val
end
local function default_capabilities(override)
    override = override or {}

    return {
        textDocument = {
            completion = {
                dynamicRegistration = if_nil(override.dynamicRegistration, false),
                completionItem = {
                    snippetSupport = if_nil(override.snippetSupport, true),
                    commitCharactersSupport = if_nil(override.commitCharactersSupport, true),
                    deprecatedSupport = if_nil(override.deprecatedSupport, true),
                    preselectSupport = if_nil(override.preselectSupport, true),
                    tagSupport = if_nil(override.tagSupport, {
                        valueSet = {
                            1, -- Deprecated
                        },
                    }),
                    insertReplaceSupport = if_nil(override.insertReplaceSupport, true),
                    resolveSupport = if_nil(override.resolveSupport, {
                        properties = {
                            "documentation",
                            "detail",
                            "additionalTextEdits",
                            "sortText",
                            "filterText",
                            "insertText",
                            "textEdit",
                            "insertTextFormat",
                            "insertTextMode",
                        },
                    }),
                    insertTextModeSupport = if_nil(override.insertTextModeSupport, {
                        valueSet = {
                            1, -- asIs
                            2, -- adjustIndentation
                        },
                    }),
                    labelDetailsSupport = if_nil(override.labelDetailsSupport, true),
                },
                contextSupport = if_nil(override.snippetSupport, true),
                insertTextMode = if_nil(override.insertTextMode, 1),
                completionList = if_nil(override.completionList, {
                    itemDefaults = {
                        "commitCharacters",
                        "editRange",
                        "insertTextFormat",
                        "insertTextMode",
                        "data",
                    },
                }),
            },
        },
    }
end

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

return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        { "antosha417/nvim-lsp-file-operations", config = true },
        "williamboman/mason.nvim",
        "SmiteshP/nvim-navic",
        "folke/neoconf.nvim",
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
            map.set("n", "gr", "<cmd>FzfLua lsp_references<cr>", opts) -- show definition, references

            opts.desc = "Show LSP definitions"
            map.set("n", "gd", "<cmd>FzfLua lsp_definitions<cr>", opts) -- show lsp definitions

            opts.desc = "Show LSP implementations"
            map.set("n", "gi", "<cmd>FzfLua lsp_implementations<cr>", opts) -- show lsp implementations

            opts.desc = "Show LSP type definitions"
            map.set("n", "gt", "<cmd>FzfLua lsp_type_definitions<CR>", opts) -- show lsp type definitions

            opts.desc = "See available code actions"
            map.set({ "n", "v" }, "<leader>ca", "<cmd>FzfLua lsp_code_actions<cr>", opts) -- see available code actions, in visual mode will apply to selection

            opts.desc = "See available source actions"
            map.set("n", "<leader>cA", '<cmd>FzfLua lsp_code_actions only="source"<cr>', opts) -- see available code actions, in visual mode will apply to selection

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
        local capabilities = default_capabilities()
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
