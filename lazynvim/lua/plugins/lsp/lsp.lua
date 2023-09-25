return {
  {
    "neovim/nvim-lspconfig",
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()

      keys[#keys + 1] = {
        "gl",
        ":lua vim.diagnostic.open_float()<cr>",
        noremap = true,
        silent = true,
        desc = "Hover diagnostic",
      }

      vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        update_in_insert = true,
      })
    end,
  },
}
