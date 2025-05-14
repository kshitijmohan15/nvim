require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

local servers = {
    'lua_ls',
    'pyright',
    'ruff',
    'clangd',
    'gopls',
    'tailwindcss',
    'html',
    'cssls',
    'rust_analyzer',
    'eslint',
    'jsonls',
    'yamlls'
}

require("mason-lspconfig").setup({
    ensure_installed = servers,
    automatic_installation = true,
})

-- Setup LSP servers
local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Define default on_attach function
local on_attach = function(client, bufnr)
    -- Enable format on save
    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format({ bufnr = bufnr })
            end,
        })
    end
end

-- The capabilities are already set up in lsp.lua, so we just need basic setup here
for _, server in ipairs(servers) do
    if server == "ruff" then
        lspconfig[server].setup({
            capabilities = capabilities,
            on_attach = function(client, bufnr)
                on_attach(client, bufnr)
                -- Enable formatting for Ruff
                client.server_capabilities.documentFormattingProvider = true
            end,
            init_options = {
                settings = {
                    -- Format files on save
                    format = true,
                    -- Organize imports on save
                    organizeImports = true,
                    -- Fix all auto-fixable problems on save
                    fixAll = true,
                }
            }
        })
    else
        lspconfig[server].setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })
    end
end
