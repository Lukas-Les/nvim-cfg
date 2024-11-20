return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
          'rcarriga/nvim-dap-ui',
          'nvim-neotest/nvim-nio',
          'mfussenegger/nvim-dap-python',
        },
        config = function()
            local dap = require("dap")

            local dapui = require("dapui")
            dapui.setup()

            -- Optional: Automatically open and close DAP UI during debugging sessions
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end
            -- Set up Python debugging with nvim-dap-python
            require("dap-python").setup()

            -- Key mappings for DAP
            vim.api.nvim_set_keymap(
                "n",
                "<leader>dc",
                '<cmd>lua require("dap").continue()<CR>',
                { noremap = true, silent = true }
            )
            vim.api.nvim_set_keymap(
                "n",
                "<leader>db",
                '<cmd>lua require("dap").toggle_breakpoint()<CR>',
                { noremap = true, silent = true }
            )
        end,
    },
}
