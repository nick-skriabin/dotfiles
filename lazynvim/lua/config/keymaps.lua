-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/lazyvim/lazyvim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- This file is automatically loaded by lazyvim.config.init
local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    if opts.remap and not vim.g.vscode then
      opts.remap = nil
    end
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

-- exit insert mode
map({ "i" }, "jk", "<ESC>", { noremap = true, silent = true, nowait = true })

-- Newlines
map({ "n" }, "<Enter>", "o<ESC>")
map({ "n" }, "<S-Enter>", "O<ESC>")

-- Save buffer
map({ "n" }, "<leader>bw", ":w<cr>", { noremap = true, silent = true, nowait = true, desc = "Save Buffer" })
map({ "n" }, "<leader>ba", ":w<cr>", { noremap = true, silent = true, nowait = true, desc = "Save All Buffers)" })

-- Flutter keys
map({ "n" }, "<leader>df", ":Telescope flutter commands<cr>", { noremap = true, desc = "Open Flutter Command Pallet" })

-- Harpoon
map({ "n" }, "<leader>h", "", { desc = "Harpoon" })
map(
  { "n" },
  "<leader>ha",
  ":lua require('harpoon.mark').add_file()<cr>",
  { silent = true, noremap = true, desc = "Add file" }
)
map(
  { "n" },
  "<leader>hd",
  ":lua require('harpoon.mark').remove_file()<cr>",
  { silent = true, noremap = true, desc = "Remove file" }
)
map(
  { "n" },
  "<leader>ho",
  ":lua require('harpoon.ui').toggle_quick_menu()<cr>",
  { silent = true, noremap = true, desc = "Toggle menu" }
)
map(
  { "n" },
  "<leader>hh",
  ":lua require('harpoon.ui').nav_next()<cr>",
  { silent = true, noremap = true, desc = "Next File" }
)
map(
  { "n" },
  "<leader>h1",
  ":lua require('harpoon.ui').nav_file(1)<cr>",
  { silent = true, noremap = true, desc = "Jump to file 1" }
)
map(
  { "n" },
  "<leader>h2",
  ":lua require('harpoon.ui').nav_file(2)<cr>",
  { silent = true, noremap = true, desc = "Jump to file 2" }
)
map(
  { "n" },
  "<leader>h3",
  ":lua require('harpoon.ui').nav_file(3)<cr>",
  { silent = true, noremap = true, desc = "Jump to file 3" }
)

map({ "n" }, "<C-h>", '<cmd>lua require("tmux").move_left()<cr>', { silent = true })
map({ "n" }, "<C-j>", '<cmd>lua require("tmux").move_bottom()<cr>', { silent = true })
map({ "n" }, "<C-k>", '<cmd>lua require("tmux").move_top()<cr>', { silent = true })
map({ "n" }, "<C-l>", '<cmd>lua require("tmux").move_right()<cr>', { silent = true })

map({ "n" }, "<C-Left>", '<cmd>lua require("tmux").resize_left()<cr>', { silent = true })
map({ "n" }, "<C-Down>", '<cmd>lua require("tmux").resize_bottom()<cr>', { silent = true })
map({ "n" }, "<C-Up>", '<cmd>lua require("tmux").resize_top()<cr>', { silent = true })
map({ "n" }, "<C-Right>", '<cmd>lua require("tmux").resize_right()<cr>', { silent = true })
