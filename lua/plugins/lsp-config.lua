
-- Make sure to require lspconfig
local lspconfig = require('lspconfig')

-- Setup for Ruff LSP
lspconfig.ruff_lsp.setup {
  on_attach = function(client, bufnr)
    -- Use ruff-lsp only for diagnostics, disable formatting as we can use black or another formatter.
    client.server_capabilities.documentFormattingProvider = false
  end,
}

