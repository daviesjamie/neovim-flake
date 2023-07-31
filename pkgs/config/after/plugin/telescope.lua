local builtin = require("telescope.builtin")

-- Find files
vim.keymap.set(
    "n",
    "<C-p>",
    builtin.git_files,
    { desc = "Fuzzy find git-tracked files" }
)
vim.keymap.set(
    "n",
    "<leader>pf",
    builtin.find_files,
    { desc = "Project Find: Fuzzy find files" }
)

-- Find string
vim.keymap.set(
    "n",
    "<leader>ps",
    builtin.live_grep,
    { desc = "Project Search: Search across files" }
)
vim.keymap.set(
    "n",
    "<leader>/",
    builtin.live_grep,
    { desc = "Project Search: Search across files" }
)

-- Find vim stuff
vim.keymap.set(
    "n",
    "<leader>vh",
    builtin.help_tags,
    { desc = "Vim Help: Search vim help tags" }
)
vim.keymap.set(
    "n",
    "<leader>vo",
    builtin.vim_options,
    { desc = "Vim Options: Search vim options" }
)
