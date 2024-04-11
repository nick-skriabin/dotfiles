return {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    opts = function()
        local C = {
            current_line_blame = true,
            preview_config = {
                border = "none",
            },
            on_attach = function(buffer)
                local gs = package.loaded.gitsigns
                local function map(mode, l, r, desc)
                    vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
                end

                map("n", "<leader>Hn", gs.next_hunk, "Next Hunk")
                map("n", "<leader>Hp", gs.prev_hunk, "Prev Hunk")
                map("n", "<leader>Hs", gs.stage_hunk, "Stage Hunk")
                map("n", "<leader>Hu", gs.undo_stage_hunk, "Unstage Hunk")
                map("n", "<leader>Hr", gs.reset_hunk, "Reset Hunk")
                map("n", "<leader>Hp", gs.preview_hunk, "Preview Hunk")
                map("n", "<leader>Hb", gs.toggle_current_line_blame, "Preview Hunk")
            end,
        }
        return C
    end,
}
