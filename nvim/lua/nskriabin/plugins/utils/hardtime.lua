return {
  "m4xshen/hardtime.nvim",
  event = "BufEnter",
  dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
  opts = {
    disabled_filetypes = { "qf", "netrw", "NvimTree", "lazy", "mason", "oil", "neotree" },
  },
}
