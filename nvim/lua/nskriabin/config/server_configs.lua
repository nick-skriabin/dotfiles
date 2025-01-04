local auto = require("nskriabin.auto.utils")

local M = {}

M.tailwindcss = function(lsp)
    return {
        cwd = lsp.util.root_pattern("tailwind.config.js", "tailwind.config.cjs", "tailwind.config.ts"),
    }
end

M.svelte = {
    settings = {
        svelte = {
            ["enable-ts-plugin"] = true,
            plugin = {
                svelte = {
                    enable = true,
                    format = {
                        enable = true,
                    },
                },
                css = {
                    completions = {
                        emmet = false,
                    },
                },
                html = {
                    completions = {
                        emmet = false,
                    },
                    tagComplete = {
                        enable = false,
                    },
                },
            },
        },
    },
    on_attach = function(client)
        auto.cmd("BufWritePost", {
            pattern = { "*.js", "*.ts" },
            group = auto.group("svelte"),

            callback = function(ctx)
                -- Here use ctx.match instead of ctx.file
                client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
            end,
        })
    end,
}

M.ts_ls = {
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
    filetypes = { "*" },
}

M.cssls = {
    css = {
        format = {
            spaceAroundSelectorSeparator = true,
        },
    },
    scss = {
        format = {
            spaceAroundSelectorSeparator = false,
        },
    },
    less = {
        format = {
            spaceAroundSelectorSeparator = true,
        },
    },
}

M.luals = {
    settings = {
        diagnostics = {
            globals = {
                "vim",
                "hs",
            },
        },
    },
}

M.bashls = {}

M.harper_ls = {
    settings = {
        ["harper-ls"] = {
            linters = {
                spell_check = true,
                spelled_numbers = false,
                an_a = true,
                sentence_capitalization = false,
                unclosed_quotes = true,
                wrong_quotes = false,
                long_sentences = false,
                repeated_words = true,
                spaces = true,
                matcher = true,
                correct_number_suffix = true,
                number_suffix_capitalization = true,
                multiple_sequential_pronouns = true,
                linking_verbs = false,
                avoid_curses = true,
                terminating_conjunctions = true,
            },
        },
    },
}

return M
