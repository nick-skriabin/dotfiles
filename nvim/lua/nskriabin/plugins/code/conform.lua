return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>bf",
      function()
        require("conform").format({
          async = true,
          lsp_fallback = true,
          timeout_ms = 500,
        })
      end,
      mode = { "n", "v" },
      desc = "Format current buffer",
    },
  },
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        javascript = { "eslint" },
        typescript = { "prettier", "eslint" },
        javascriptreact = { "eslint" },
        typescriptreact = { "eslint" },
        css = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        svelte = { "prettier", "eslint" },
        markdown = { "prettier" },
        graphql = { "prettier" },
        lua = { "stylua" },
        python = { "isort", "black" },
      },
      format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      },
    })
  end,
}
