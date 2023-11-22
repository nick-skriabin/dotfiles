local map = vim.keymap.set

-- cmdline
map({ "n" }, "<leader>;", "<cmd>Telescope cmdline<cr>", { noremap = true, silent = true })

-- exit insert mode
map({ "i" }, "jj", "<ESC>", { noremap = true, silent = true, nowait = true })
map({ "n" }, "<leader>qq", ":qa!<cr>", { noremap = true, silent = true, nowait = true, desc = "Quit" })
map({ "n" }, "<leader>qb", ":bd!<cr>", { noremap = true, silent = true, nowait = true, desc = "Quit" })

-- Newlines
map({ "n" }, "<Enter>", "o<ESC>")
map({ "n" }, "<S-Enter>", "O<ESC>")

-- Buffers
map({ "n" }, "<leader>bd", ":Bdelete<cr>", { noremap = true, silent = true, nowait = true, desc = "Delete Buffer" })
map(
  { "n" },
  "<leader>bD",
  ":bufdo Bdelete<cr>",
  { noremap = true, silent = true, nowait = true, desc = "Delete all Buffers" }
)
map({ "n" }, "<leader>bw", ":w<cr>", { noremap = true, silent = true, nowait = true, desc = "Save Buffer" })
map({ "n" }, "<leader>ba", ":wa<cr>", { noremap = true, silent = true, nowait = true, desc = "Save All Buffers" })

-- Pasting
map("n", "<C-p>", '<C-r>"', { noremap = true, silent = true, nowait = true })
