require("nskriabin.config.filetype")
local auto = require("nskriabin.auto.utils")
return {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    build = ":TSUpdate",
    version = false,
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
        "windwp/nvim-ts-autotag",
    },
    keys = {
        { "<c-space>", desc = "Increment selection" },
        { "<bs>", desc = "Decrement selection", mode = "x" },
    },
    config = function()
        local treesitter = require("nvim-treesitter.configs")
        local autotag = require("nvim-ts-autotag")

        auto.cmd({ "BufRead", "BufNewFile" }, {
            pattern = "*.keymap,*.dtsi",
            command = "set filetype=devicetree",
        })

        treesitter.setup({
            highlight = {
                enable = true,
            },
            indent = {
                enable = true,
            },
            context_commentstring = {
                enable = true,
                enable_autocmd = false,
            },
            auto_install = true,
            ensure_installed = {
                "jsdoc",
                "json",
                "jsonc",
                "javascript",
                "typescript",
                "css",
                "tsx",
                "python",
                "markdown",
                "markdown_inline",
                "rust",
                "lua",
                "vim",
                -- "svelte",
                "devicetree",
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<C-space>",
                    node_incremental = "<C-space>",
                    scope_incremental = false,
                    node_decremental = "<bs>",
                },
            },
            textobjects = {
                move = {
                    enable = true,
                    goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
                    goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer" },
                    goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
                    goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer" },
                },
            },
        })

        autotag.setup({
            opts = {
                enable = true,
                enable_rename = true,
                enable_close = true,
                enable_close_on_slash = true,
            },
        })
    end,
}
