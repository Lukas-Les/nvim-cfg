return {
  -- Load nvim-dap
  {
    'mfussenegger/nvim-dap',
    config = function()
      local dap = require('dap')

      -- Python DAP Configuration
      dap.adapters.python = {
        type = 'executable',
        command = 'python', -- Adjust if using a virtual environment
        args = { '-m', 'debugpy.adapter' },
      }

      dap.configurations.python = {
        {
          type = 'python',
          request = 'launch',
          name = "Launch file",
          program = "${file}",
          pythonPath = function()
            return 'python'
          end,
        },
      }

      -- Add configurations for other languages (e.g., Rust) here
    end,
  },

  -- Load nvim-dap-ui and link it to nvim-dap
  {
    'rcarriga/nvim-dap-ui',
    dependencies = {
        'mfussenegger/nvim-dap',
        "nvim-neotest/nvim-nio",
    },
    config = function()
      local dapui = require('dapui')
      dapui.setup()

      local dap = require('dap')
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },
}

