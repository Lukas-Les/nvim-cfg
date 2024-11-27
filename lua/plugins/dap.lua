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

            vim.api.nvim_set_keymap(
                "n",
                "<leader>db", '<cmd>lua require("dap").toggle_breakpoint()<CR>',
                { noremap = true, silent = true }
            )
            vim.api.nvim_set_keymap(
                "n",
                "<leader>ds", '<cmd>lua require("dap").step_over()<CR>',
                { noremap = true, silent = true }
            )
            vim.api.nvim_set_keymap(
                "n",
                "<leader>di", '<cmd>lua require("dap").step_into()<CR>',
                { noremap = true, silent = true }
            )
            vim.api.nvim_set_keymap(
                "n",
                "<leader>do", '<cmd>lua require("dap").step_out()<CR>',
                { noremap = true, silent = true }
            )
            vim.api.nvim_set_keymap(
                "n",
                "<leader>dt", '<cmd>lua require("dap").terminate()<CR>',
                { noremap = true, silent = true }
            )
            vim.api.nvim_set_keymap(
                "n",
                "<leader>dr", '<cmd>lua require("dap").repl.open()<CR>',
                { noremap = true, silent = true }
            )
            vim.api.nvim_set_keymap(
                "n",
                "<leader>dl", '<cmd>lua require("dap").run_last()<CR>',
                { noremap = true, silent = true }
            )
            vim.api.nvim_set_keymap(
                "n",
                "<leader>d;", '<cmd>lua require("dap").show_logs()<CR>',
                { noremap = true, silent = true }
            )
            vim.api.nvim_set_keymap(
                "n",
                "<leader>dh", '<cmd>lua require("dap.ui.widgets").hover()<CR>',
                { noremap = true, silent = true }
            )
            vim.api.nvim_set_keymap(
                "n",
                "<leader>dp", '<cmd>lua require("dap.ui.widgets").preview()<CR>',
                { noremap = true, silent = true }
            )
        end,
        keys = {
            { "<leader>dc", '<cmd>lua require("dap").continue()<CR>', desc = "Turn On DAP / Continue"},
        },
    },
    {
        "julianolf/nvim-dap-lldb", lazy = true
    },
    {
        "mfussenegger/nvim-dap-python", lazy = true
    },
    {
        "leoluz/nvim-dap-go", lazy = true
    }
}
