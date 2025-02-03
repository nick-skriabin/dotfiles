return {
    {
        "stevearc/oil.nvim",
        -- Optional dependencies
        dependencies = { { "echasnovski/mini.icons", version = false } },
        keys = {
            { "-", ":lua require('oil').open()<cr>", desc = "Open parent dir", silent = true },
        },
        opts = {
            skip_confirm_for_simple_edits = false,
            constrain_cursor = "name",
            keymaps = {
                ["g?"] = { "actions.show_help", mode = "n" },
                ["<CR>"] = "actions.select",
                ["<localleader>v"] = { "actions.select", opts = { vertical = true } },
                ["<localleader>h"] = { "actions.select", opts = { horizontal = true } },
                ["<C-t>"] = { "actions.select", opts = { tab = true } },
                ["<C-p>"] = "actions.preview",
                ["<C-c>"] = { "actions.close", mode = "n" },
                ["<C-r>"] = "actions.refresh",
                ["-"] = { "actions.parent", mode = "n" },
                ["_"] = { "actions.open_cwd", mode = "n" },
                ["`"] = { "actions.cd", mode = "n" },
                ["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
                ["gs"] = { "actions.change_sort", mode = "n" },
                ["gx"] = "actions.open_external",
                ["g."] = { "actions.toggle_hidden", mode = "n" },
                ["g\\"] = { "actions.toggle_trash", mode = "n" },
            },
        },
        config = function(_, opts)
            require("oil").setup(opts)
        end,
    },
}
