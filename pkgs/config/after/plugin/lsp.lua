local lsp = require("lsp-zero").preset({})

lsp.setup_servers({
    "bashls",
    "lua_ls",
    "nil_ls",
    "tsserver",
})

require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())
