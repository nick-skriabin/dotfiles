return {
    "jackMort/ChatGPT.nvim",
    dependencies = {
        "MunifTanjim/nui.nvim",
        "nvim-lua/plenary.nvim",
        "folke/trouble.nvim",
        "nvim-telescope/telescope.nvim",
    },
    config = function()
        local home = vim.fn.expand("$HOME")
        require("chatgpt").setup({
            -- api_key_cmd = "echo $OPENAI_API_KEY",
        })
    end,
}
