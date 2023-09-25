return {
  {
    "echasnovski/mini.comment",
    lazy = false,
    opts = function(_, opts)
      opts.mappings = {
        comment = "<leader>/",
        comment_line = "<leader>/",
      }
      return opts
    end,
  },
}
