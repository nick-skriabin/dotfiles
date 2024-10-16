local Util = require("nskriabin.core.util")
local path_display = { "truncate" }

local lsp_symbols = {
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
}

return {
    "nvim-telescope/telescope.nvim",
    event = { "LspAttach" },
    cmd = { "Telescope" },
    dependencies = {
        {
            "natecraddock/telescope-zf-native.nvim",
            lazy = true,
            config = function()
                require("telescope").load_extension("zf-native")
            end,
        },
        -- { "ThePrimeagen/git-worktree.nvim", lazy = true },
    },
    version = false, -- telescope did only one release, so use HEAD for now
    keys = {
        -- { "<leader>,", Util.telescope("buffers", { path_display = path_display }), desc = "Switch Buffer" },
        { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
        { "<leader><space>", Util.telescope("files", { path_display = path_display }), desc = "Find Files (root dir)" },
        { "<leader>df", ":Telescope flutter commands<cr>", noremap = true, desc = "Open Flutter Command Pallet" },

        -- find
        { "<leader>ff", Util.telescope("files", { cwd = false, path_display = path_display }), desc = "Find Files (cwd)" },

        -- git
        { "<leader>gc", ":Telescope git_commits<CR>", desc = "commits" },
        { "<leader>gs", ":Telescope git_status<CR>", desc = "status" },
        {
            "<leader>gw",
            function()
                require("telescope").extensions.git_worktree.git_worktrees()
            end,
            desc = "Git Worktrees",
        },
        {
            "<leader>gW",
            function()
                require("telescope").extensions.git_worktree.create_git_worktree()
            end,
            desc = "Create Git Worktree",
        },

        -- search
        { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Marks" },
        { "<leader>sg", Util.telescope("live_grep"), desc = "Grep (root dir)" },
        { "<leader>sG", Util.telescope("live_grep", { cwd = false }), desc = "Grep (cwd)" },
        { "<leader>sw", Util.telescope("grep_string", { word_match = "-w" }), desc = "Word (root dir)" },
        { "<leader>sW", Util.telescope("grep_string", { cwd = false, word_match = "-w" }), desc = "Word (cwd)" },
        { "<leader>sw", Util.telescope("grep_string"), mode = "v", desc = "Selection (root dir)" },
        { "<leader>sW", Util.telescope("grep_string", { cwd = false }), mode = "v", desc = "Selection (cwd)" },
        { "<leader>ss", Util.telescope("lsp_document_symbols", { symbols = lsp_symbols }), desc = "Goto Symbol" },
        { "<leader>sS", Util.telescope("lsp_dynamic_workspace_symbols", { symbols = lsp_symbols }), desc = "Goto Symbol (Workspace)" },
    },
    config = function(_, opts)
        local actions = require("telescope.actions")
        opts.defaults.mappings.n["<C-c>"] = actions.close
        require("telescope").setup(opts)
        require("telescope").load_extension("git_worktree")
        require("telescope").load_extension("dap")
    end,
    opts = function()
        return {
            defaults = {
                layout_strategy = "vertical",
                sorting_strategy = "ascending",
                layout_config = {
                    vertical = { width = 0.5, height = 0.6, prompt_position = "top" },
                },
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
                    n = {
                        ["<C-c>"] = { "<esc>", type = "command" },
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
            pickers = {
                buffers = { previewer = false },
                git_files = { previewer = false },
                find_files = { previewer = false },
            },
        }
    end,
}
