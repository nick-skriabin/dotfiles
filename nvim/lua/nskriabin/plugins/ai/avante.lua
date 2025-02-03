-- Avante is an AI chant inside neovim. It can provide code suggestions and generate new files.
-- https://github.com/yetone/avante.nvim

return {
    "yetone/avante.nvim",
    event = { "BufReadPre" },
    keys = {
        { "<leader>aa", "<cmd>AvanteChat<CR>", desc = "Avante Chat", silent = true },
    },
    build = ":AvanteBuild", -- This is optional, recommended tho. Also note that this will block the startup for a bit since we are compiling bindings in Rust.
    dependencies = {
        "stevearc/dressing.nvim",
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        "echasnovski/mini.icons",
        "HakonHarnes/img-clip.nvim",
        {
            -- Make sure to setup it properly if you have lazy=true
            "MeanderingProgrammer/render-markdown.nvim",
            opts = {
                file_types = { "markdown", "Avante" },
            },
            ft = { "markdown", "Avante" },
        },
    },
    opts = {
        -- recommended settings
        provider = "claude",
        embed_image_as_base64 = false,
        prompt_for_file_name = false,
        drag_and_drop = {
            insert_mode = true,
        },
    },
}
