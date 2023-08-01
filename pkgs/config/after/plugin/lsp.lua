local lsp = require("lsp-zero").preset({})

-- Enable autocomplete
lsp.on_attach(function(client, bufnr)
    local opts = function(desc)
        return {
            buffer = bufnr,
            desc = desc,
            remap = false,
        }
    end

    -- Navigation
    vim.keymap.set("n", "gd", function()
        vim.lsp.buf.definition()
    end, opts("Go to Definition of symbol"))

    vim.keymap.set("n", "gD", function()
        vim.lsp.buf.declaration()
    end, opts("Go to Declaration of symbol"))

    vim.keymap.set("n", "gt", function()
        vim.lsp.buf.type_definition()
    end, opts("Go to definition of Type"))

    vim.keymap.set("n", "[d", function()
        vim.diagnostic.goto_prev()
    end, opts("Go to previous diagnostic"))

    vim.keymap.set("n", "]d", function()
        vim.diagnostic.goto_next()
    end, opts("Go to next diagnostic"))

    -- Hints
    vim.keymap.set("n", "K", function()
        vim.lsp.buf.hover()
    end, opts("Hover: Show info about symbol"))

    vim.keymap.set("i", "<C-h>", function()
        vim.lsp.buf.signature_help()
    end, opts("Show signature of symbol"))

    -- Actions
    vim.keymap.set("n", "<leader>la", function()
        vim.lsp.buf.code_action()
    end, opts("Lsp: code Action"))

    vim.keymap.set("n", "<leader>lr", function()
        vim.lsp.buf.rename()
    end, opts("Lsp: Rename symbol"))

    vim.keymap.set("n", "<leader>lR", function()
        vim.lsp.buf.references()
    end, opts("Lsp: find all References"))
end)

lsp.setup_servers({
    "bashls",
    "lua_ls",
    "nil_ls",
    "tsserver",
})

require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())