local lspconfig = require('lspconfig')

-- Configure Ruff
lspconfig.ruff.setup({
    on_attach = function(client, bufnr)
        -- Enable formatting capabilities
        client.server_capabilities.documentFormattingProvider = true
        client.server_capabilities.documentRangeFormattingProvider = true
    end,
    settings = {
        ruff = {
            format = {
                args = { "--line-length=88" }
            }
        }
    }
})

-- Create an autocmd group for Python
local python_group = vim.api.nvim_create_augroup("Python", { clear = true })

-- Auto format and organize imports on save for Python files
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.py",
    group = python_group,
    callback = function()
        -- Format the file
        vim.lsp.buf.format({ async = false })
    end,
})

-- Configure Pyright to not handle formatting
require('lspconfig').pyright.setup({
    on_attach = function(client, bufnr)
        -- Disable formatting since we're using Ruff
        client.server_capabilities.documentFormattingProvider = false
    end,
}) 