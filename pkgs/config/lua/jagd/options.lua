-- Show relative line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Use 4-space tabs
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Automatically indent new lines
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.smarttab = true

-- Don't wrap lines
vim.opt.wrap = false

-- Save undo history to a file, but don't save swap or backups
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- Don't highlight search matches, but do show matches whilst typing
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Keep lines visible above/below cursor
vim.opt.scrolloff = 8

-- Always leave a gap for signs in number gutter
vim.opt.signcolumn = "yes"

-- Make keys repeat faster
vim.opt.updatetime = 50

-- Draw a hint for manually wrapping lines
vim.opt.colorcolumn = "80"

-- Highlight the line the cursor is on
vim.opt.cursorline = true
