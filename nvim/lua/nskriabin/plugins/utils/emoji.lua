return {
    "ziontee113/icon-picker.nvim",
    enabled = false,
    config = function()
        require("icon-picker").setup({ disable_legacy_commands = true })

        local opts = { noremap = true, silent = true }

        vim.keymap.set("i", "<C-i>", "<cmd>IconPickerInsert emoji<cr>", opts)
    end,
}
