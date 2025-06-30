-- Create autocmd group for LSP formatting
local lsp_group = vim.api.nvim_create_augroup("LSPFormatting", { clear = true })

-- Setup format on save
local function setup_format_on_save(bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
        group = lsp_group,
        buffer = bufnr,
        callback = function()
            vim.lsp.buf.format({
                bufnr = bufnr,
                async = false,
                timeout_ms = 5000,
                filter = function(client)
                    return client.name == "gopls"
                end
            })
        end
    })
end

-- Function to setup gopls
local function setup_gopls()
    local mason_registry = require("mason-registry")
    local pkg = mason_registry.get_package("gopls")
    
    if not pkg then
        return
    end
    
    local install_path = pkg:get_install_path()
    if not install_path then
        return
    end
    
    local gopls_path = install_path .. "/gopls"
    
    require("lspconfig").gopls.setup({
        cmd = { gopls_path },
        filetypes = { "go", "gomod", "gowork", "gotmpl" },
        single_file_support = true,
        root_dir = require("lspconfig.util").root_pattern("go.mod", ".git"),
        on_attach = function(client, bufnr)
            client.server_capabilities.documentFormattingProvider = true
            setup_format_on_save(bufnr)
        end,
        settings = {
            gopls = {
                gofumpt = true,
                analyses = {
                    unusedparams = true,
                },
                staticcheck = true,
            }
        }
    })
end

-- Basic mason setup only
require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

-- Direct gopls setup without mason-lspconfig
require("lspconfig").gopls.setup({
    on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = true
        setup_format_on_save(bufnr)
    end,
    settings = {
        gopls = {
            gofumpt = true,
            analyses = {
                unusedparams = true,
            },
            staticcheck = true,
        }
    }
})
