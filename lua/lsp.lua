require('mason').setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

local server_list = { 'pylsp', 'clangd', 'lua_ls', 'rust_analyzer', "asm_lsp" }

require('mason-lspconfig').setup({
    -- A list of servers to automatically install if they're not already installed
    ensure_installed = server_list,
})
-- Set different settings for different languages' LSP
-- LSP list: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
-- How to use setup({}): https://github.com/neovim/nvim-lspconfig/wiki/Understanding-setup-%7B%7D
--     - the settings table is sent to the LSP
--     - on_attach: a lua callback function to run after LSP atteches to a given buffer
local lspconfig = require('lspconfig')

-- Customized on_attach function
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
-- vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    -- go xxx
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', 'gh', vim.lsp.buf.hover, bufopts)

    -- diagnostics
    vim.keymap.set('n', 'go', vim.diagnostic.open_float, bufopts)
    vim.keymap.set('n', 'gp', vim.diagnostic.goto_prev, bufopts)
    vim.keymap.set('n', 'gn', vim.diagnostic.goto_next, bufopts)

end

-- setup lsp
for _, server_name in pairs(server_list) do
    lspconfig[server_name].setup {
        on_attach = on_attach,
    }
end
-- lspconfig.pylsp.setup({
--     on_attach = on_attach,
-- })
-- lspconfig.clangd.setup({
--     on_attach = on_attach,
-- })
-- lspconfig.rust_analyzer.setup({
--     on_attach = on_attach,
-- })
-- lspconfig.lua_ls.setup({
--     on_attach = on_attach,
-- })
