local auto = require("nskriabin.auto.utils")

local M = {}

M.tailwindcss = {}

M.svelte = {}

M.vtsls = {
    settings = {
        includeCompletionsForModuleExports = true,
        includePackageJsonAutoImports = true,
        typescript = {
            tsserver = {
                maxTsServerMemory = "auto",
            },
            format = {
                enable = false,
            },
            inlayHints = {
                parameterNames = true,
            },
            updateImportsOnFileMove = "always",
        },

        javascript = {
            format = {
                enable = false,
            },
            inlayHints = {
                parameterNames = true,
            },
            updateImportsOnFileMove = "always",
        },
        plugins = { "typescript-plugin-css-modules" },
    },
}

M.emmet_language_server = {}

M.codespell = {
    enabled = false,
    filetypes = { "*" },
}

M.cssls = {
    init_options = {
        provideFormatter = false,
    },
}

M.lua_ls = {
    settings = {
        diagnostics = {
            globals = {
                "vim",
                "hs",
                "Snacks",
            },
        },
    },
}

M.bashls = {}

M.tailwindcss = {
    settings = {
        tailwindCSS = {
            classAttributes = {
                "class",
                "className",
                "rawClassName",
            },
            experimental = {
                classRegex = {
                    { "clsx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
                    { "cn\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
                    { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
                    ":\\s*?[\"'`]([^\"'`]*).*?,",
                    { "classnames:\\s*{([\\s\\s]*?)}", "\\s?[\\w].*:\\s*?[\"'`]([^\"'`]*).*?,?\\s?" },
                },
            },
        },

        ["tailwindCSS.classAttributes"] = {
            "class",
            "className",
            "rawClassName",
        },
    },
}

M.prismals = {}

return M
