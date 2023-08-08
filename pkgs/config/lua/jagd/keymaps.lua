vim.g.mapleader = " "

vim.keymap.set(
    "n",
    "<leader>pv",
    vim.cmd.Ex,
    { desc = "Project View: Open Netrw" }
)

-- Make jumping with ctrl D/U stay centred in screen
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Open folds when jumping between search results
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Make yanking/pasting a bit easier
vim.keymap.set(
    { "n", "v" },
    "<leader>y",
    [["+y]],
    { desc = "Copy to system clipboard" }
)

vim.keymap.set(
    "n",
    "<leader>Y",
    [["+Y]],
    { desc = "Copy rest of line to system clipboard" }
)

vim.keymap.set(
    "x",
    "<leader>p",
    [["_dP]],
    { desc = "Paste over visual selection without losing register contents" }
)

-- Stop accidentally pressing Q
vim.keymap.set("n", "Q", "<nop>")

-- Move visual selection up/down with K/J
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Re-select selection after indenting in visual mode
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")

-- Stolen from vim-unimpaired
-- Navigate :args
vim.keymap.set(
    "n",
    "[a",
    ":previous<CR>",
    { desc = "Go to previous file in args list" }
)
vim.keymap.set(
    "n",
    "]a",
    ":next<CR>",
    { desc = "Go to next file in args list" }
)
vim.keymap.set(
    "n",
    "[A",
    ":first<CR>",
    { desc = "Go to first file in args list" }
)
vim.keymap.set(
    "n",
    "]A",
    ":last<CR>",
    { desc = "Go to last file in args list" }
)

-- Navigate :buffers
vim.keymap.set(
    "n",
    "[b",
    ":bprevious<CR>",
    { desc = "Go to previous file in buffer list" }
)
vim.keymap.set(
    "n",
    "]b",
    ":bnext<CR>",
    { desc = "Go to next file in buffer list" }
)
vim.keymap.set(
    "n",
    "[B",
    ":bfirst<CR>",
    { desc = "Go to first file in buffer list" }
)
vim.keymap.set(
    "n",
    "]B",
    ":blast<CR>",
    { desc = "Go to last file in buffer list" }
)

-- Navigate quickfix list
vim.keymap.set(
    "n",
    "[q",
    ":cprevious<CR>",
    { desc = "Go to previous file in quickfix list" }
)
vim.keymap.set(
    "n",
    "]q",
    ":cnext<CR>",
    { desc = "Go to next file in quickfix list" }
)
vim.keymap.set(
    "n",
    "[Q",
    ":cfirst<CR>",
    { desc = "Go to first file in quickfix list" }
)
vim.keymap.set(
    "n",
    "]Q",
    ":clast<CR>",
    { desc = "Go to last file in quickfix list" }
)
