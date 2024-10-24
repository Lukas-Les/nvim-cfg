return {
    'neovim/nvim-lspconfig',
    config = function()
      local lspconfig = require('lspconfig')

      -- Setup Ruff LSP
      lspconfig.ruff_lsp.setup {
        on_attach = function(client, bufnr)
          client.server_capabilities.documentFormattingProvider = false
        end,
      }
    end,
}
