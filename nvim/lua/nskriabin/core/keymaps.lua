local map = vim.keymap.set
local keys = require("nskriabin.core.util.keymap")

-- cmdline
keys.map({
    { "n", "<leader>;", "<cmd>Telescope cmdline<cr>" },
})

-- exit insert mode
keys.map({
    { "i", "jj", "<ESC>", nowait = true },
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
    { { "n", "x" }, "<C-u>", "<C-u>zz" },
    { { "n", "x" }, "<C-d>", "<C-d>zz" },
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
    { "n", "<C-w>", ":w<cr>", nowait = true, desc = "Save Buffer" },
    { "n", "<C-W>", ":wa<cr>", nowait = true, desc = "Save All Buffers" },
})

-- packages
keys.map({
    { "n", "<leader>ll", ":Lazy<cr>", desc = "Lazy" },
    { "n", "<leader>lm", ":Mason<cr>", desc = "Mason" },
})

-- splits
keys.map({
    { "n", "<leader>wh", ":split<cr>", nowait = true, desc = "Split" },
    { "n", "<leader>wv", ":vsplit<cr>", nowait = true, desc = "VSplit" },
    { "n", "<leader>ww", "<C-w>w", nowait = true, desc = "Next Split" },
    { "n", "<leader>wq", "<C-w>q", nowait = true, desc = "Close Split" },
    { "n", "<leader>wc", "<C-w>c", nowait = true, desc = "Close Split" },
    { "n", "<leader>wr", "<C-w>r", nowait = true, desc = "Rotate Split" },
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
