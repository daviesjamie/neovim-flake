vim.g.ledger_bin = "hledger"
vim.g.ledger_extra_options = "--strict"

vim.g.ledger_fold_blanks = 1

vim.g.ledger_maxwidth = 80

vim.g.ledger_default_commodity = "£"
vim.g.ledger_commodity_before = 1

-- Remap paragraph navigation to move by transactions instead
vim.keymap.set("n", "{", [[?^\d<CR>]])
vim.keymap.set("n", "}", [[/^\d<CR>]])

-- Use <Tab> to align transaction amounts
vim.keymap.set("i", "<Tab>", "<C-r>=ledger#autocomplete_and_align()<CR>")
vim.keymap.set("v", "<Tab>", ":LedgerAlign<CR>")

-- Use [s and ]s to toggle through transaction statuses
vim.keymap.set("n", "[s", ":call ledger#transaction_state_toggle(line('.'), '* !')<CR>")
vim.keymap.set("n", "]s", ":call ledger#transaction_state_toggle(line('.'), '! *')<CR>")
