return {
  "chentoast/marks.nvim",
  opts = {
    default_mappings = false,
    mappings = {
      toggle = "<leader>mm",
      next = "<leader>mn",
      prev = "<leader>mp",
      delete_buf = "<leader>md",
      preview = "<leader>ml",
    },
  },
  keys = {
    { "<leader>mm", "<Plug>(Marks-toggle)<cr>", desc = "Toggle mark" },
    { "<leader>mn", "<Plug>(Marks-next)<cr>", desc = "Next mark" },
    { "<leader>mp", "<Plug>(Marks-prev)<cr>", desc = "Prev mark" },
    { "<leader>md", "<Plug>(Marks-deletebuf)<cr>", desc = "Delete marks in buffer" },
    { "<leader>ml", "<Plug>(Marks-preview)<cr>", desc = "Preview" },
  },
}
