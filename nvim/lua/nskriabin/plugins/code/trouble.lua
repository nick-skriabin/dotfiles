return {
    "folke/trouble.nvim",
    branch = "dev",
    lazy = true,
    cmd = { "TroubleToggle", "Trouble" },
    opts = { use_diagnostic_signs = true },
    keys = {
        -- V3 hotkeys
        { "<leader>xx", "<cmd>Trouble diagnostics toggle focus=true<cr>", desc = "Diagnostics (Trouble)" },
        {
            "<leader>xw",
            "<cmd>Trouble diagnostics toggle focus=true filter.buf=0<cr>",
            desc = "File Diagnostics (Trouble)",
        },
        { "<leader>xr", "<cmd>Trouble lsp_references focus=true<cr>", desc = "Location List (Trouble)" },
        { "<leader>xd", "<cmd>Trouble lsp_declaration focus=true<cr>", desc = "Location List (Trouble)" },
        { "<leader>xs", "<cmd>Trouble lsp_symbols toggle focus=true<cr>", desc = "Quickfix List (Trouble)" },
        -- V2 hotkeys
        -- { "<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics (Trouble)" },
        -- { "<leader>xX", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
        -- { "<leader>xL", "<cmd>TroubleToggle loclist<cr>", desc = "Location List (Trouble)" },
        -- { "<leader>xQ", "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix List (Trouble)" },
        {
            "[q",
            function()
                if require("trouble").is_open() then
                    require("trouble").previous({ skip_groups = true, jump = true })
                else
                    local ok, err = pcall(vim.cmd.cprev)
                    if not ok then
                        vim.notify(err, vim.log.levels.ERROR)
                    end
                end
            end,
            desc = "Previous trouble/quickfix item",
        },
        {
            "]q",
            function()
                if require("trouble").is_open() then
                    require("trouble").next({ skip_groups = true, jump = true })
                else
                    local ok, err = pcall(vim.cmd.cnext)
                    if not ok then
                        vim.notify(err, vim.log.levels.ERROR)
                    end
                end
            end,
            desc = "Next trouble/quickfix item",
        },
    },
}
