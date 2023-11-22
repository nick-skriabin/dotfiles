return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = {
      { "<leader>e", ":Neotree toggle<cr>", noremap = true, silent = true, desc = "Show File Tree" },
    },
    opts = function()
      return {
        window = {
          mappings = {
            ["h"] = "close_node",
            ["l"] = "open",
          },
        },
        open_files_do_not_replace_types = { "trouble", "dap" },
        source_selector = {
          winbar = false,
          sources = {
            { source = "filesystem" },
          },
        },
        filesystem = {
          use_libuv_file_watcher = true,
          follow_current_file = {
            enabled = true,
          },
          filtered_items = {
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
          },
        },
        event_handlers = {
          {
            event = "file_opened",
            handler = function()
              require("neo-tree.command").execute({ action = "close" })
            end,
          },
        },
      }
    end,
  },
}
