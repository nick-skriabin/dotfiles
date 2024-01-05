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

    lint.linters_by_ft = {
      javascript = { "eslint" },
      typescript = { "eslint" },
      javascriptreact = { "eslint" },
      typescriptreact = { "eslint" },
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
        lint.try_lint()
      end,
    })
  end,
}
