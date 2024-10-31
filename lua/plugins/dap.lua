return {
  {
    'mfussenegger/nvim-dap',
    config = function()
      local dap = require('dap')

      -- Function to get the correct Python interpreter for each project
      local function get_python_path()
        -- Check if there's a virtualenv in the project directory
        local venv = vim.fn.getcwd() .. '/.venv/bin/python'
        if vim.fn.filereadable(venv) == 1 then
          return venv
        else
          -- Fallback to system Python if no project-specific venv is found
          return 'python'
        end
      end

      -- Set up Python debugging with nvim-dap-python
      require('dap-python').setup(get_python_path())

      -- Key mappings for DAP
      vim.api.nvim_set_keymap('n', '<F5>', '<cmd>lua require("dap").continue()<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<F10>', '<cmd>lua require("dap").step_over()<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<F11>', '<cmd>lua require("dap").step_into()<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<F12>', '<cmd>lua require("dap").step_out()<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<leader>b', '<cmd>lua require("dap").toggle_breakpoint()<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<leader>B', '<cmd>lua require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<leader>dr', '<cmd>lua require("dap").repl.open()<CR>', { noremap = true, silent = true })

      -- Optional: Set up nvim-dap-ui for a visual interface
      require("dapui").setup()
      vim.api.nvim_set_keymap('n', '<leader>dui', '<cmd>lua require("dapui").toggle()<CR>', { noremap = true, silent = true })
    end,
  },
  {
    'nvim-neotest/nvim-nio', -- Explicitly add nvim-nio as a plugin
  },
  {
    'mfussenegger/nvim-dap-python',
    requires = {'mfussenegger/nvim-dap'}
  },
  {
    'rcarriga/nvim-dap-ui', -- nvim-dap-ui for a visual debugging interface
    requires = {
      'mfussenegger/nvim-dap',
      'nvim-neotest/nvim-nio' -- nvim-nio dependency
    },
    config = function()
      local dapui = require("dapui")
      dapui.setup()
      -- Automatically open and close DAP UI during debugging sessions
      require('dap').listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      require('dap').listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      require('dap').listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end
  },
}

