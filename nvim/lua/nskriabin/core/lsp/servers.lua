local M = {}

M.lsp = {
  --"tsserver",
  "vtsls",
  "html",
  "cssls",
  "luau_lsp",
  "emmet_language_server",
  "pyright",
  "svelte",
}

M.tools = {
  "prettier", -- prettier formatter
  "stylua", -- lua formatter
  "isort", -- python formatter
  "black", -- python formatter
  "pylint", -- python linter
  "eslint_d", -- js linter
}

return M
