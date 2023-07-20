local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local cursorline_group = augroup("cursorline", { clear = true })
autocmd("WinLeave", {
    group = cursorline_group,
    pattern = "*",
    command = "set nocursorline",
})
autocmd("WinEnter", {
    group = cursorline_group,
    pattern = "*",
    command = "set cursorline",
})
