return {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = "FzfLua",
    keys = {
        { "<leader><space>", ":FzfLua files cwd='./'<cr>", silent = true, desc = "Open Git files picker" },
        {
            "<leader>,",
            ":FzfLua buffers previewer=false winopts.height=0.5 winopts.width=0.4<cr>",
            silent = true,
            desc = "Open Git files picker",
        },
    },
    config = function()
        -- calling `setup` is optional for customization
        require("fzf-lua").setup({
            profile = "fzf-native",
            defaults = {
                formatter = "path.filename_first", -- places file name first
            },
            hls = {
                normal = "TelescopeNormal",
                border = "TelescopeBorder",
                preview_normal = "TelescopeNormal",
                preview_border = "TelescopeBorder",
            },
            git = {
                cmd = "git ls-files -dcmo --deduplicate --exclude-standard",
            },
            lsp = {
                jump_to_single_result = true,
            },
            winopts = {
                border = "none",
                preview = {
                    border = "none",
                    winopts = {
                        number = false, -- this removes line number from the preview
                    },
                },
            },
        })
    end,
}