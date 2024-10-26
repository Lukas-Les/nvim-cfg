return {
    'neovim/nvim-lspconfig',
    config = function()
      local lspconfig = require('lspconfig')

      -- Setup Ruff LSP
      lspconfig.ruff_lsp.setup()
    end,
}
