return {
  "f-person/git-blame.nvim",
  opts = {
    delay = 1000,
  },
  keys = {
    { "<leader>gb", ":GitBlameToggle<cr>", silent = true, desc = "Toggle Git Blame" },
    { "<leader>gs", ":GitBlameCopySHA<cr>", silent = true, desc = "Copy commit SHA" },
    { "<leader>gu", ":GitBlameOpenCommitURL<cr>", silent = true, desc = "Copy commit URL" },
  },
}
