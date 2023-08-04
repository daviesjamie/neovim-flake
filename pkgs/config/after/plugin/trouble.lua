require("trouble").setup({
    icons = false,
    fold_open = "▼",
    fold_closed = "▶",
    use_diagnostic_signs = true,
    signs = {
        other = "◦",
    },
})

vim.keymap.set("n", "<leader>tt", "<cmd>TroubleToggle<cr>", {
    silent = true,
    noremap = true,
    desc = "Toggle the last Trouble.nvim list",
})

vim.keymap.set("n", "<leader>tq", "<cmd>TroubleToggle quickfix<cr>", {
    silent = true,
    noremap = true,
    desc = "Toggle the trouble.nvim Quickfix list",
})
