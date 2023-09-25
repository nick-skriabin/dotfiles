return {
  {
    "nvim-telescope/telescope.nvim",
    opts = function(_, opts)
      local m = opts.defaults.mappings

      m.i["<C-j>"] = function(...)
        return require("telescope.actions").move_selection_next(...)
      end
      m.i["<C-k>"] = function(...)
        return require("telescope.actions").move_selection_previous(...)
      end

      opts.defaults.mappings = m
    end,
  },
}
