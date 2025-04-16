-- Avante is an AI chant inside neovim. It can
-- provide code suggestions and generate new files.
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
        {
            "HakonHarnes/img-clip.nvim",
            opts = {
                embed_image_as_base64 = false,
                prompt_for_file_name = false,
                drag_and_drop = {
                    insert_mode = true,
                },
            },
        },
        -- Make sure to setup it properly if you have lazy=true
        { "MeanderingProgrammer/render-markdown.nvim" },
    },
    opts = {
        -- recommended settings
        provider = "claude",
        -- Since auto-suggestions are a high-frequency operation and therefore expensive,
        -- it is recommended to specify an inexpensive provider or even a free provider: copilot

        auto_suggestions_provider = "claude-haiku",
        file_selector = {
            provider = "snacks",
        },
        claude = {
            model = "claude-3-7-sonnet-20250219",
            timeout = 30000, -- Timeout in milliseconds
            temperature = 0,
            max_tokens = 8000,
            disable_tools = true,
        },
        behaviour = {
            enable_cursor_planning_mode = true, -- enable cursor planning mode!
            enable_claude_text_editor_tool_mode = true,
        },
    },
}
