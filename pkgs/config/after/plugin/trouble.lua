local trouble = require("trouble").setup({
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

-- vim-unimpaired -style navigation
local opts = { skip_groups = true, jump = true }

vim.keymap.set("n", "[t", function()
    trouble.previous(opts)
end, { desc = "Go to previous file in Trouble" })

vim.keymap.set("n", "]t", function()
    trouble.next(opts)
end, { desc = "Go to previous file in Trouble" })

vim.keymap.set("n", "[T", function()
    trouble.first(opts)
end, { desc = "Go to first file in Trouble" })

vim.keymap.set("n", "]T", function()
    trouble.last(opts)
end, { desc = "Go to last file in Trouble" })
