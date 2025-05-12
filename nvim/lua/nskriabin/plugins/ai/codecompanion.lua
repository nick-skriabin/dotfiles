return {
    "olimorris/codecompanion.nvim",
    keys = {
        { "<leader>cc", ":CodeCompanionActions<cr>" },
        {
            "<leader>cC",
            function()
                require("codecompanion").prompt("context")
            end,
        },
        { "<leader>cl", ":CodeCompanion<cr>" },
        { "<leader>ct", ":CodeCompanionChat<cr>" },
        { "ct", ":'<,'>CodeCompanion<cr>", mode = "v" },
    },
    config = function()
        require("codecompanion").setup({
            strategies = {
                -- Configure the chat interaction strategy to use Anthropic AI
                chat = {
                    adapter = "anthropic",
                },
                -- Configure the inline code assistance strategy to use Anthropic AI
                inline = {
                    adapter = "anthropic",
                },
                -- Configure the command execution strategy to use Anthropic AI
                cmd = {
                    adapter = "anthropic",
                },
            },
            prompt_library = {
                ["context"] = {
                    strategy = "chat",
                    description = "Chat with context files",
                    opts = {
                        -- ...
                    },
                    prompts = {
                        {
                            role = "user",
                            opts = {
                                contains_code = true,
                            },
                            content = function(context)
                                local ctx = require("contextfiles.extensions.codecompanion")

                                local ctx_opts = {
                                    -- ...
                                }
                                local format_opts = {
                                    -- ...
                                }

                                return ctx.get(context.filename, ctx_opts, format_opts)
                            end,
                        },
                    },
                },
            },
        })
    end,
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        "banjo/contextfiles.nvim",
    },
}
