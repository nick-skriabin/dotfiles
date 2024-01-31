local au = require("nskriabin.auto.utils")

return {
    "mfussenegger/nvim-lint",
    event = {
        "BufReadPre",
        "BufNewFile",
    },
    keys = {
        {
            "<leader>bl",
            function()
                require("lint").try_lint()
            end,
            mode = "n",
            desc = "Lint buffer",
        },
    },
    config = function()
        local lint = require("lint")
        local js_lint = {
            "eslint",
            "biomejs",
        }

        lint.linters_by_ft = {
            javascript = js_lint,
            typescript = js_lint,
            javascriptreact = js_lint,
            typescriptreact = js_lint,
            css = { "stylelint" },
            stylus = { "stylelint" },
            sass = { "stylelint" },
            python = { "pylint" },
        }

        au.cmd({
            "BufEnter",
            "BufWritePost",
            "InsertLeave",
            "TextChanged",
        }, {
            group = au.group("lint"),
            callback = function()
                lint.try_lint(nil, {
                    ignore_errors = true,
                })
            end,
        })
    end,
}
