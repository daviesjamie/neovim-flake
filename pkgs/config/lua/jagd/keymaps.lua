vim.g.mapleader = " "

-- Open netrw with <leader>pv (mnemonic: "project view")
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Move visual selection up/down with K/J
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Make jumping with ctrl D/U stay centred in screen
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Open folds when jumping between search results
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Paste over visual selection without losing register contents
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Copy to system clipboard
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Stop accidentally pressing Q
vim.keymap.set("n", "Q", "<nop>")

-- Re-select selction after indenting in visual mode
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", ">", "<gv")
