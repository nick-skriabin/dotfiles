local auto = require("nskriabin.auto.utils")

local M = {}

M.biome = function(lsp)
    return {
        cmd = { "biome", "lsp-proxy" },
        filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
        cwd = lsp.util.root_pattern("biome.json", "biome.jsonc"),
        single_file_support = false,
    }
end

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

M.vtsls = {
    settings = {
        typescript = {
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
    },
}

-- M.vtsls = {
--     settings = {
--         typescript = {
--             format = {
--                 enable = false,
--             },
--             tsserver = {
--                 maxTsServerMemory = "auto",
--             },
--             updateImportsOnFileMove = "always",
--             inlayHints = {
--                 parameterNames = { enabled = true },
--                 parameterTypes = { enabled = false },
--                 variableTypes = { enabled = false },
--                 propertyDeclarationTypes = { enabled = false },
--                 functionLikeReturnTypes = { enabled = false },
--                 enumMemberValues = { enabled = true },
--             },
--         },
--         javascript = {
--             format = {
--                 enable = false,
--             },
--             updateImportsOnFileMove = "always",
--             inlayHints = {
--                 parameterNames = { enabled = true },
--                 parameterTypes = { enabled = false },
--                 variableTypes = { enabled = false },
--                 propertyDeclarationTypes = { enabled = false },
--                 functionLikeReturnTypes = { enabled = false },
--                 enumMemberValues = { enabled = true },
--             },
--         },
--     },
-- }
M.lua_ls = {
    settings = { -- custom settings for lua
        Lua = {
            -- make the language server recognize "vim" global
            diagnostics = {
                globals = { "vim", "hs", "spoon" },
            },
            workspace = {
                -- make language server aware of runtime files
                library = {
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
                    [vim.fn.stdpath("config") .. "/lua"] = true,
                    ["/Applications/Hammerspoon.app/Contents/Resources/extensions/hs/"] = true,
                },
            },
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

M.cspell = {
    filetypes = { "*" },
}

M.cssls = {
    settings = {
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
    },
}

return M
