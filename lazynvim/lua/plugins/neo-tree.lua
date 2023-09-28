return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = function(_, opts)
      local open_files_do_not_replace_types = opts.open_files_do_not_replace_types
      local source_selector = opts.source_selector or {}
      local window = opts.window or {}
      local filesystem = opts.filesystem or {}
      local event_handlers = opts.event_handlers or {}

      open_files_do_not_replace_types[#open_files_do_not_replace_types + 1] = "dap"

      source_selector.winbar = false
      source_selector.sources = {
        { source = "filesystem" },
      }

      window.mappings = opts.window.mappings or {}
      window.mappings["l"] = "open"
      window.mappings["h"] = "close_node"

      filesystem.follow_current_file = {
        enabled = true,
      }
      filesystem.use_libuv_file_watcher = true
      filesystem.filtered_items = {
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

      event_handlers[#event_handlers + 1] = {
        event = "file_opened",
        handler = function()
          require("neo-tree.command").execute({ action = "close" })
        end,
      }

      opts.window = window
      opts.filesystem = filesystem
      opts.source_selector = source_selector
      opts.event_handlers = event_handlers
      opts.open_files_do_not_replace_types = open_files_do_not_replace_types

      return opts
    end,
  },
}
