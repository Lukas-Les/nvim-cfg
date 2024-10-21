return {
    'rcarriga/nvim-dap-ui',
    dependencies = {'mfussenegger/nvim-dap'},
    config = function()
      require('plugins.dap')  -- This will load the init file in `lua/plugins/dap/`
    end
}

