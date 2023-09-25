return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = function(_, opts)
      local open_files_do_not_replace_types = opts.open_files_do_not_replace_types
      open_files_do_not_replace_types[#open_files_do_not_replace_types + 1] = "dap"

      opts.open_files_do_not_replace_types = open_files_do_not_replace_types
      opts.source_selector = opts.source_selector or {}
      opts.source_selector.winbar = false
      opts.source_selector.sources = {
        { source = "filesystem" },
      }

      opts.window = opts.window or {}
      opts.window.mappings = opts.window.mappings or {}
      opts.window.mappings["l"] = "open"
      opts.window.mappings["h"] = "close_node"

      opts.filesystem.follow_current_file = {
        enabled = true,
      }
      opts.filesystem.use_libuv_file_watcher = true
      opts.filesystem.filtered_items = {
        visible = true,
        hide_dotfiles = false,
        hide_gitignored = true,
        never_show = {
          ".git",
          ".vscode",
          ".idea",
          ".devcontainer",
          ".DS_Store",
        },
      }

      return opts
    end,
  },
}
