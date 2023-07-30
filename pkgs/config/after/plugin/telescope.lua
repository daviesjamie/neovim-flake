local builtin = require("telescope.builtin")

-- Use that Ctrl-P muscle memory to find files in `git ls-files`
vim.keymap.set("n", "<C-p>", builtin.git_files, {})

-- Find files with <leader>pf (mnemonic: "Project Find")
vim.keymap.set("n", "<leader>pf", builtin.find_files, {})

-- Search for a string in project (mnemonic: "Project Search")
vim.keymap.set("n", "<leader>ps", builtin.live_grep, {})

-- Search through vim help tags (mnemonic: "Vim Help")
vim.keymap.set("n", "<leader>vh", builtin.help_tags, {})

-- Search through vim options (mnemonic: "Vim Options")
vim.keymap.set("n", "<leader>vo", builtin.vim_options, {})
