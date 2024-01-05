return {
  "f-person/git-blame.nvim",
  event = "BufReadPre",
  opts = {
    delay = 1000,
    ignored_filetypes = {
      "oil",
    },
  },
  keys = {
    { "<leader>gb", ":GitBlameToggle<cr>", silent = true, desc = "Toggle Git Blame" },
    { "<leader>gs", ":GitBlameCopySHA<cr>", silent = true, desc = "Copy commit SHA" },
    { "<leader>gu", ":GitBlameOpenCommitURL<cr>", silent = true, desc = "Copy commit URL" },
  },
}
