local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Only show cursor line in current split
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

-- Show trailing whitespace (but not on current line or in insert mode)
local extra_whitespace_group = augroup("extra_whitespace", { clear = true })
vim.api.nvim_set_hl(0, "ExtraWhitespace", { bg = "red" })
autocmd("InsertEnter", {
    group = extra_whitespace_group,
    pattern = "*",
    command = "match ExtraWhitespace /\\s\\+\\%#\\@<!$/",
})
autocmd("InsertLeave", {
    group = extra_whitespace_group,
    pattern = "*",
    command = "match ExtraWhitespace /\\s\\+$/",
})
