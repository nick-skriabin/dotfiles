return {
    {
        "echasnovski/mini.pairs",
        event = "InsertEnter",
        enabled = false,
        opts = {},
    },
    {
        "echasnovski/mini.ai",
        event = "VeryLazy",
        opts = function()
            local ai = require("mini.ai")
            return {
                n_lines = 500,
                custom_textobjects = {
                    o = ai.gen_spec.treesitter({
                        a = { "@block.outer", "@conditional.outer", "@loop.outer" },
                        i = { "@block.inner", "@conditional.inner", "@loop.inner" },
                    }, {}),
                    f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
                    c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
                    t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },
                },
            }
        end,
    },
    {
        "echasnovski/mini.files",
        dependencies = {
            "echasnovski/mini.animate",
        },
        keys = {
            {
                "-",
                ":lua MiniFiles.open(vim.api.nvim_buf_get_name(0), true)<cr>",
                desc = "Open mini.files (Directory of Current File)",
            },
            {
                "_",
                ":lua MiniFiles.open(vim.uv.cwd(), true)<cr>",
                desc = "Open mini.files (cwd)",
            },
        },
        opts = {
            mappings = {
                close = "q",
                go_in = "<cr>",
                go_in_plus = "L",
                go_out = "-",
                go_out_plus = "H",
                mark_goto = "'",
                mark_set = "m",
                reset = "<BS>",
                reveal_cwd = "@",
                show_help = "g?",
                synchronize = "=",
                trim_left = "<",
                trim_right = ">",
            },
        },
    },
    {
        "echasnovski/mini.animate",
        event = "VeryLazy",
        config = function()
            require("mini.animate").setup({
                cursor = { enable = false },
                scroll = { enable = false },
            })
        end,
    },
}
