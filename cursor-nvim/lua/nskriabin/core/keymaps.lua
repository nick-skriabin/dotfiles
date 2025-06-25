local keys = require("nskriabin.core.util.keymap")

-- exit insert mode
keys.map({
    { "i", "ii", "<ESC>", nowait = true },
    { "n", "<esc>", "<cmd>nohl<cr>" },
    { "n", "<Enter>", "o<ESC>" },
    { "n", "<S-Enter>", "O<ESC>" },
})

-- editing
keys.map({
    { "i", "<M-BS>", "<C-w>", nowait = true, silent = true },
})

-- navigation
keys.map({
    { { "n", "x" }, "<C-u>", "<C-u>" },
    { { "n", "x" }, "<C-d>", "<C-d>" },
    { { "n", "x" }, "gg", "ggzz" },
    { { "n", "x" }, "G", "Gzz" },
    { { "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", expr = true, silent = true },
    { { "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", expr = true, silent = true },
    { { "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", expr = true, silent = true },
    { { "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", expr = true, silent = true },
})

-- quit
keys.map({
    { "n", "<leader>qq", ":qall!<cr>", nowait = true, desc = "Quit" },
})

-- Buffers
keys.map({
    { "n", "<leader>bl", ":edit<cr>", nowait = true, desc = "Reload Buffer" },
    { "n", "<C-q>", ":q<cr>", nowait = true, desc = "Close Buffer" },
    { "n", "<C-w>", ":w!<cr>", nowait = true, desc = "Save Buffer" },
    { "n", "<C-W>", ":wa!<cr>", nowait = true, desc = "Save All Buffers" },
})

-- packages
keys.map({
    { "n", "<leader>pl", ":Lazy<cr>", desc = "Lazy" },
    { "n", "<leader>pm", ":Mason<cr>", desc = "Mason" },
})

-- splits
keys.map({
    { "n", "<leader>wh", ":split<cr>", nowait = true, desc = "Split" },
    { "n", "<leader>wv", ":vsplit<cr>", nowait = true, desc = "VSplit" },
    { "n", "<leader>ww", "<C-w>w", nowait = true, desc = "Next Split" },
    { "n", "<leader>wq", "<C-w>q", nowait = true, desc = "Close Split" },
    { "n", "<leader>wc", "<C-w>c", nowait = true, desc = "Close Split" },
    { "n", "<leader>wr", "<C-w>r", nowait = true, desc = "Rotate Split" },
    { "n", "<leader>wH", "<C-w>H", nowait = true, desc = "Move split to Left" },
    { "n", "<leader>wJ", "<C-w>J", nowait = true, desc = "Move split to Down" },
    { "n", "<leader>wK", "<C-w>K", nowait = true, desc = "Move split to Up" },
    { "n", "<leader>wL", "<C-w>L", nowait = true, desc = "Move split to Right" },
    { "n", "<leader>w=", "<C-w>e", nowait = true, desc = "Equalize Splits" },
})

-- Function to jump to the previous buffer
function _G.jump_to_previous_buffer()
    vim.cmd("buffer #")
end

keys.map({
    -- Map the function to a key (for example, <leader>b)
    { "n", "<leader>bb", _G.jump_to_previous_buffer, desc = "Cycle to next buffer", silent = true },
})

keys.map({
    { "n", "yp", "<cmd>Cppath<cr>", silent = true },
})
