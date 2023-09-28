return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      {
        "natecraddock/telescope-zf-native.nvim",
        config = function()
          require("telescope").load_extension("zf-native")
        end,
      },
    },
    keys = {
      { "<leader>/", false },
    },
    opts = function(_, opts)
      local m = opts.defaults.mappings
      local extensions = opts.extensions or {}

      extensions["zf-native"] = {
        -- options for sorting file-like items
        file = {
          -- override default telescope file sorter
          enable = true,

          -- highlight matching text in results
          highlight_results = true,

          -- enable zf filename match priority
          match_filename = true,
        },

        -- options for sorting all other items
        generic = {
          -- override default telescope generic item sorter
          enable = true,

          -- highlight matching text in results
          highlight_results = true,

          -- disable zf filename match priority
          match_filename = false,
        },
      }

      m.i["<C-j>"] = function(...)
        return require("telescope.actions").move_selection_next(...)
      end
      m.i["<C-k>"] = function(...)
        return require("telescope.actions").move_selection_previous(...)
      end

      opts.defaults.mappings = m
      opts.extensions = extensions
    end,
  },
}
