return {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = true,
    keys = {
        { "-", ":lua require('oil').open()<cr>", desc = "Open parent dir", silent = true },
    },
    config = function()
        local oil = require("oil")

        local opts = {
            skip_confirm_for_simple_edits = true,
            win_options = {
                signcolumn = "yes:2",
            },
            view_options = {
                is_always_hidden = function(name)
                    return name == ".."
                end,
                -- is_hidden_file = function(name, bufnr)
                --     if name:sub(1, #".") == "." then
                --         return true
                --     end
                --     local current_dir = oil.get_current_dir()
                --     local file_path = vim.fn.resolve(current_dir .. name)
                --     local is_ignored = vim.fn.system({ "git", "check-ignore", file_path }) ~= ""
                --     return is_ignored
                -- end,
            },
            keymaps = {
                ["g?"] = "actions.show_help",
                ["<CR>"] = "actions.select",
                ["<C-v>"] = "actions.select_vsplit",
                ["<C-h>"] = "actions.select_split",
                ["<C-t>"] = "actions.select_tab",
                ["<C-p>"] = "actions.preview",
                ["<C-c>"] = "actions.close",
                ["<C-l>"] = "actions.refresh",
                ["-"] = "actions.parent",
                ["_"] = "actions.open_cwd",
                ["`"] = "actions.cd",
                ["~"] = "actions.tcd",
                ["gs"] = "actions.change_sort",
                ["gx"] = "actions.open_external",
                ["g."] = "actions.toggle_hidden",
                ["gt"] = "actions.toggle_trash",
            },
        }

        oil.setup(opts)
    end,
}
