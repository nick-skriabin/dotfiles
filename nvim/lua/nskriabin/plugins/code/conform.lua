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
        local root_file = require("conform.util").root_file
        local from_node_modules = require("conform.util").from_node_modules
        local root_files = {
            prettier = {
                ".prettierrc",
                ".prettierrc.json",
                ".prettierrc.yml",
                ".prettierrc.yaml",
                ".prettierrc.js",
                ".prettierrc.mjs",
                ".prettier.config.js",
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
                "biome.jsonc",
            },
            stylua = {
                "stylua.toml",
            },
            isort = {
                "pyproject.toml",
                "setup.cfg",
                "tox.ini",
            },
            stylelint = {
                ".stylelintrc.json",
            },
            black = {
                "pyproject.toml",
            },
        }

        local js_formatters = {
            "biome_fmt",
        }

        conform.setup({
            formatters = {
                prettier = {
                    require_cwd = true,
                    cwd = root_file(root_files.prettier),
                },
                biome_fmt = {
                    meta = {
                        url = "https://github.com/biomejs/biome",
                        description = "A toolchain for web projects, aimed to provide functionalities to maintain them.",
                    },
                    command = from_node_modules("biome"),
                    stdin = true,
                    args = { "check", "--apply", "--stdin-file-path", "$FILENAME" },
                    cwd = root_file({
                        "biome.json",
                        "biome.jsonc",
                    }),
                },
            },
            formatters_by_ft = {
                gleam = { "gleam" },
                javascript = js_formatters,
                typescript = js_formatters,
                javascriptreact = js_formatters,
                typescriptreact = js_formatters,
                css = { "stylelint" },
                scss = { "stylelint" },
                html = { "biome" },
                json = { "biome" },
                markdown = { "biome" },
                jsonc = { "biome" },
                yaml = { "prettier" },
                svelte = { "prettier", "biome" },
                lua = { "stylua" },
                python = { "blue", "ruff_fix" },
                go = { "gofmt", "goimports" },
                nix = { "nixfmt" },
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
                -- FormatDisable! will single disable formatting just for this buffer
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

        vim.api.nvim_create_user_command("SpellFix", function(opts)
            local start_pos = vim.fn.getpos("'<")
            local end_pos = vim.fn.getpos("'>")
            local range = {
                ["start"] = { start_pos[2], start_pos[3] },
                ["end"] = { end_pos[2], end_pos[3] },
            }

            require("conform").format({
                async = true,
                lsp_fallback = true,
                timeout_ms = 500,
                formatters = { "codespell" },
                range = range,
            })
        end, {
            desc = "Fix spelling",
            range = true,
        })
    end,
}
