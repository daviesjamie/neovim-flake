local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local cursorline_group = augroup("cursorline", { clear = true })
vim.api.nvim_create_autocmd("WinLeave", {
    group = cursorline_group,
    pattern = "*",
    command = "set nocursorline",
})
vim.api.nvim_create_autocmd("WinEnter", {
    group = cursorline_group,
    pattern = "*",
    command = "set cursorline",
})
