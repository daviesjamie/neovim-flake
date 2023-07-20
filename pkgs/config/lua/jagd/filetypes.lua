local filetype_detect = vim.api.nvim_create_augroup("filetype_detect", {})
vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
    group = filetype_detect,
    pattern = "*.journal",
    command = "setf ledger",
})
