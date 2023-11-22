return {
  "pmizio/typescript-tools.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  enabled = false,
  opts = {
    settings = {
      tsserver_max_memory = 4096,
      expose_as_code_action = "all",
    },
  },
}
