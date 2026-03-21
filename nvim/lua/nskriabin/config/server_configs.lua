local auto = require("nskriabin.auto.utils")

local M = {}

M.tailwindcss = {}

M.svelte = {}

-- M.ts_ls = {}

local tsdk = vim.fn.getcwd() .. "/node_modules/typescript/lib"

M.vtsls = {
    settings = {
        typescript = {
            tsserver = {
                maxTsServerMemory = 4096, -- give it RAM; 2048 often too low in big monorepos
                useSeparateSyntaxServer = true, -- keeps quick info/snippets snappy
                separateSyntaxServer = true, -- alias tolerated by some clients
                experimental = {
                    -- Turn OFF project-wide intellisense to avoid full-graph crawls on file change
                    projectWideIntellisense = false,
                },
                watchOptions = {
                    watchFile = "useFsEventsOnParentDirectory",
                    watchDirectory = "useFsEvents",
                    fallbackPolling = "dynamicPriority",
                    synchronousWatchDirectory = false,
                },
            },
        },
        vtsls = {
            tsserver = {
                globalPlugins = {}, -- keep empty unless you truly need extras
            },
            -- Small but real wins:
            enableMoveToFileCodeAction = false,
            autoUseWorkspaceTsdk = true, -- ensure it picks your repo TS
        },
    },
}

M.emmet_language_server = {
    filetypes = {
        "css",
        "eruby",
        "html",
        "javascript",
        "javascriptreact",
        "less",
        "sass",
        "scss",
        "pug",
        "typescriptreact",
        "svelte",
    },
    init_options = {
        showAbbreviationSuggestions = false,
        showSuggestionsAsSnippets = false,
    },
}

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
M["mdx-analyzer"] = {}

return M
