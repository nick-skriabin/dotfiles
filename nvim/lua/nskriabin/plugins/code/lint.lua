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
            "biomejs",
            "eslint",
        }

        lint.linters_by_ft = {
            ["*"] = { "cspell" },
            javascript = js_lint,
            typescript = js_lint,
            javascriptreact = js_lint,
            typescriptreact = js_lint,
            css = { "stylelint" },
            sass = { "stylelint" },
            scss = { "stylelint" },
            python = { "pylint" },
            lua = { "luacheck" },
        }

        for ft, _ in pairs(lint.linters_by_ft) do
            table.insert(lint.linters_by_ft[ft], "cspell")
        end

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
