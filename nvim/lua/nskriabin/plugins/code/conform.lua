return {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    cmd = { "ConformInfo" },
    keys = {
        {
            "<leader>bf",
            function()
                require("conform").format({
                    async = true,
                    lsp_fallback = true,
                    timeout_ms = 500,
                })
            end,
            mode = { "n", "v" },
            desc = "Format current buffer",
        },
    },
    config = function()
        vim.b.disable_autoformat = false
        vim.g.disable_autoformat = false

        local conform = require("conform")
        local util = require("conform.util")
        local root_files = {
            prettier = {
                ".prettierrc",
                ".prettierc.json",
                ".prettierc.yml",
                ".prettierc.yaml",
                ".prettierc.js",
                ".prettier.config.js",
                ".prettierc.mjs",
                ".prettier.config.mjs",
                ".prettierc.cjs",
                ".prettier.config.cjs",
            },
            eslint = {
                ".eslintrc.js",
                ".eslintrc.cjs",
                ".eslintrc.yaml",
                ".eslintrc.yml",
                ".eslintrc.json",
            },
            biome = {
                "biome.json",
            },
            stylua = {
                "stylua.toml",
            },
            isort = {
                "pyproject.toml",
                "setup.cfg",
                "tox.ini",
            },
            black = {
                "pyproject.toml",
            },
        }

        local js_formatters = {
            {
                "biome",
                "eslint_d",
                -- "eslint",
                "prettier",
            },
        }

        conform.setup({
            formatters = {
                prettier = {
                    require_cwd = true,
                    cwd = util.root_file(root_files.prettier),
                },
                eslint_d = {
                    -- require_cwd = true,
                    -- cwd = util.root_file(root_files.eslint),
                },
                eslint = {
                    command = util.from_node_modules("eslint"),
                    args = { "--fix-dry-run", "--stdin", "--stdin-filename", "$FILENAME" },
                    require_cwd = true,
                    cwd = util.root_file(root_files.eslint),
                },
                biome = {
                    require_cwd = true,
                    cwd = util.root_file(root_files.biome),
                },
            },
            formatters_by_ft = {
                javascript = js_formatters,
                typescript = js_formatters,
                javascriptreact = js_formatters,
                typescriptreact = js_formatters,
                css = { "prettier" },
                html = { "prettier" },
                json = { "prettier", "biome" },
                yaml = { "prettier" },
                svelte = { { "prettier", "eslint_d" } },
                markdown = { "prettier" },
                graphql = { "prettier" },
                lua = { "stylua" },
                -- python = { "isort", "black" },
            },
            format_on_save = function(bufnr)
                if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                    return
                end
                return {
                    lsp_fallback = true,
                    async = false,
                    timeout_ms = 1000,
                }
            end,
        })

        vim.api.nvim_create_user_command("FormatDisable", function(args)
            if args.bang then
                -- FormatDisable! will disable formatting just for this buffer
                vim.b.disable_autoformat = true
            else
                vim.g.disable_autoformat = true
            end
        end, {
            desc = "Disable autoformat-on-save",
            bang = true,
        })
        vim.api.nvim_create_user_command("FormatEnable", function()
            vim.b.disable_autoformat = false
            vim.g.disable_autoformat = false
        end, {
            desc = "Re-enable autoformat-on-save",
        })
    end,
}
