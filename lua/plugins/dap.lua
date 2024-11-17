return {
    {
        "mfussenegger/nvim-dap",
        config = function()
            local dap = require("dap")

            -- Function to get the correct Python interpreter for each project
            local function get_python_path()
                local venv = vim.fn.getcwd() .. "/.venv/bin/python"
                if vim.fn.filereadable(venv) == 1 then
                    return venv
                else
                    return "python"
                end
            end

            -- Set up Python debugging with nvim-dap-python
            require("dap-python").setup(get_python_path())

            -- Key mappings for DAP
            vim.api.nvim_set_keymap(
                "n",
                "<F5>",
                '<cmd>lua require("dap").continue()<CR>',
                { noremap = true, silent = true }
            )
            vim.api.nvim_set_keymap(
                "n",
                "<F10>",
                '<cmd>lua require("dap").step_over()<CR>',
                { noremap = true, silent = true }
            )
            vim.api.nvim_set_keymap(
                "n",
                "<F11>",
                '<cmd>lua require("dap").step_into()<CR>',
                { noremap = true, silent = true }
            )
            vim.api.nvim_set_keymap(
                "n",
                "<F12>",
                '<cmd>lua require("dap").step_out()<CR>',
                { noremap = true, silent = true }
            )
            vim.api.nvim_set_keymap(
                "n",
                "<leader>b",
                '<cmd>lua require("dap").toggle_breakpoint()<CR>',
                { noremap = true, silent = true }
            )
            vim.api.nvim_set_keymap(
                "n",
                "<leader>B",
                '<cmd>lua require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>',
                { noremap = true, silent = true }
            )
            vim.api.nvim_set_keymap(
                "n",
                "<leader>dr",
                '<cmd>lua require("dap").repl.open()<CR>',
                { noremap = true, silent = true }
            )
        end,
        dependencies = { "mfussenegger/nvim-dap-python", "rcarriga/nvim-dap-ui", "nvim-neotest/nvim-nio" },
    },
    {
        "mfussenegger/nvim-dap-python",
        dependencies = { "mfussenegger/nvim-dap" },
    },
    {
        "rcarriga/nvim-dap-ui",
        config = function()
            local dapui = require("dapui")
            dapui.setup()

            -- Optional: Automatically open and close DAP UI during debugging sessions
            local dap = require("dap")
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
        dependencies = { "mfussenegger/nvim-dap" },
    },
}
