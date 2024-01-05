local Util = require("nskriabin.core.util")

return {
  "nvim-telescope/telescope.nvim",
  event = { "VeryLazy", "LspAttach" },
  dependencies = {
    {
      "natecraddock/telescope-zf-native.nvim",
      config = function()
        require("telescope").load_extension("zf-native")
      end,
    },
    "jonarrien/telescope-cmdline.nvim",
  },
  version = false, -- telescope did only one release, so use HEAD for now
  keys = {
    { "<leader>,", "<cmd>Telescope buffers show_all_buffers=true<cr>", desc = "Switch Buffer" },
    { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
    { "<leader><space>", Util.telescope("files"), desc = "Find Files (root dir)" },
    { "<leader>df", ":Telescope flutter commands<cr>", noremap = true, desc = "Open Flutter Command Pallet" },

    -- find
    { "<leader>ff", Util.telescope("files"), desc = "Find Files (root dir)" },
    { "<leader>fF", Util.telescope("files", { cwd = false }), desc = "Find Files (cwd)" },
    { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
    { "<leader>fR", Util.telescope("oldfiles", { cwd = vim.loop.cwd() }), desc = "Recent (cwd)" },

    -- git
    { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "commits" },
    { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "status" },

    -- search
    { '<leader>s"', "<cmd>Telescope registers<cr>", desc = "Registers" },
    { "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
    { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
    { "<leader>sc", "<cmd>Telescope command_history<cr>", desc = "Command History" },
    { "<leader>sg", Util.telescope("live_grep"), desc = "Grep (root dir)" },
    { "<leader>sG", Util.telescope("live_grep", { cwd = false }), desc = "Grep (cwd)" },
    { "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
    { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
    { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
    { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
    { "<leader>sw", Util.telescope("grep_string", { word_match = "-w" }), desc = "Word (root dir)" },
    { "<leader>sW", Util.telescope("grep_string", { cwd = false, word_match = "-w" }), desc = "Word (cwd)" },
    { "<leader>sw", Util.telescope("grep_string"), mode = "v", desc = "Selection (root dir)" },
    { "<leader>sW", Util.telescope("grep_string", { cwd = false }), mode = "v", desc = "Selection (cwd)" },
    { "<leader>uC", Util.telescope("colorscheme", { enable_preview = true }), desc = "Colorscheme with preview" },
    {
      "<leader>ss",
      Util.telescope("lsp_document_symbols", {
        symbols = {
          "Class",
          "Function",
          "Method",
          "Constructor",
          "Interface",
          "Module",
          "Struct",
          "Trait",
          "Field",
          "Property",
          "Enum",
          "Constant",
        },
      }),
      desc = "Goto Symbol",
    },
    {
      "<leader>sS",
      Util.telescope("lsp_dynamic_workspace_symbols", {
        symbols = {
          "Class",
          "Function",
          "Method",
          "Constructor",
          "Interface",
          "Module",
          "Struct",
          "Trait",
          "Field",
          "Property",
          "Enum",
          "Constant",
        },
      }),
      desc = "Goto Symbol (Workspace)",
    },
  },
  config = function(_, opts)
    require("telescope").setup(opts)
    require("telescope").load_extension("cmdline")
  end,
  opts = function()
    return {
      defaults = {
        file_ignore_patterns = {
          ".git/",
          ".npm/",
          ".vscode/",
          ".local/",
          "node_modules/",
        },
        mappings = {
          i = {
            ["<C-j>"] = function(...)
              return require("telescope.actions").move_selection_next(...)
            end,
            ["<C-k>"] = function(...)
              return require("telescope.actions").move_selection_previous(...)
            end,
          },
        },
      },
      extensions = {
        ["zf-native"] = {
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
        },
      },
    }
  end,
}
