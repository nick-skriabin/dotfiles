return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
  },
  opts = function(_, opts)
    local servers = opts.servers or {}

    servers["emmet_language_server"] = {
      filetypes = { "html", "xml", "javascript", "javascriptreact", "sass", "scss", "typescriptreact", "stylus" },
    }

    return opts
  end,
}
