return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "nvim-neotest/nvim-nio",
        },
        config = function()
            local dap = require("dap")

            local dapui = require("dapui")
            dapui.setup({
                icons = {
                    expanded = "▾",
                    collapsed = "▸",
                    current_frame = "⭐",
                },
                controls = {
                    icons = {
                        pause = "⏸️,",
                        play = "🚀",
                        step_into = "🔽",
                        step_over = "⏩",
                        step_out = "🔼",
                        step_back = "◀️,",
                        run_last = "🔁",
                        terminate = "❌",
                        disconnect = "🔌",
                    },
                },
            })
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
    {
        "julianolf/nvim-dap-lldb",
        lazy = true,
        config = function()
            require("dap-lldb").setup()
        end,
    },
    {
        "mfussenegger/nvim-dap-python",
        lazy = true,
        config = function()
            require("dap-python").setup()
        end,
    },
    {
        "leoluz/nvim-dap-go",
        lazy = true,
        config = function()
            require("dap-go").setup()
        end,
    }
}
