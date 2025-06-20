return {
    {
        "mfussenegger/nvim-dap",
        config = function()
            local dap = require("dap")
            vim.fn.sign_define(
                "DapBreakpoint",
                { text = "B", texthl = "DapBreakpoint", linehl = "", numhl = "DapBreakpoint" }
            )
            vim.fn.sign_define("DapStopped", { text = "→", texthl = "DapStopped", linehl = "", numhl = "DapStopped" })

            vim.api.nvim_set_keymap(
                "n",
                "<leader>db",
                '<cmd>lua require("dap").toggle_breakpoint()<CR>',
                { noremap = true, silent = true }
            )
            vim.api.nvim_set_keymap(
                "n",
                "<leader>dc",
                '<cmd>lua require("dap").continue()<CR>',
                { noremap = true, silent = true }
            )
            vim.api.nvim_set_keymap(
                "n",
                "<leader>ds",
                '<cmd>lua require("dap").step_over()<CR>',
                { noremap = true, silent = true }
            )
            vim.api.nvim_set_keymap(
                "n",
                "<leader>di",
                '<cmd>lua require("dap").step_into()<CR>',
                { noremap = true, silent = true }
            )
            vim.api.nvim_set_keymap(
                "n",
                "<leader>do",
                '<cmd>lua require("dap").step_out()<CR>',
                { noremap = true, silent = true }
            )
            vim.api.nvim_set_keymap(
                "n",
                "<leader>dt",
                '<cmd>lua require("dap").terminate()<CR>',
                { noremap = true, silent = true }
            )
            vim.api.nvim_set_keymap(
                "n",
                "<leader>dr",
                '<cmd>lua require("dap").repl.open()<CR>',
                { noremap = true, silent = true }
            )
            vim.api.nvim_set_keymap(
                "n",
                "<leader>dl",
                '<cmd>lua require("dap").run_last()<CR>',
                { noremap = true, silent = true }
            )
            vim.api.nvim_set_keymap(
                "n",
                "<leader>d;",
                '<cmd>lua require("dap").show_logs()<CR>',
                { noremap = true, silent = true }
            )
            vim.api.nvim_set_keymap(
                "n",
                "<leader>dx",
                '<cmd>lua require("dapui").close()<CR>',
                { noremap = true, silent = true }
            )
            vim.api.nvim_set_keymap(
                "n",
                "<leader>dh",
                '<cmd>lua require("dap.ui.widgets").hover()<CR>',
                { noremap = true, silent = true }
            )
            vim.api.nvim_set_keymap(
                "n",
                "<leader>dp",
                '<cmd>lua require("dap.ui.widgets").preview()<CR>',
                { noremap = true, silent = true }
            )
            vim.api.nvim_set_keymap(
                "n",
                "<leader>dz",
                "<cmd>lua require('dap').down()<CR>",
                { desc = "Move cursor to the current stopped breakpoin" }
            )

            local function get_python_executable()
                local cwd = vim.fn.getcwd()

                if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
                    return cwd .. "/venv/bin/python"
                elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
                    return cwd .. "/.venv/bin/python"
                else
                    -- This will use the 'python' found in your system's PATH
                    -- If you need a specific system python (e.g., python3), you can
                    -- change this to "/usr/bin/python3" or similar absolute path.
                    return "python"
                end
            end

            dap.adapters.python = function(cb, config)
                if config.request == "attach" then
                    ---@diagnostic disable-next-line: undefined-field
                    local port = (config.connect or config).port
                    ---@diagnostic disable-next-line: undefined-field
                    local host = (config.connect or config).host or "127.0.0.1"
                    cb({
                        type = "server",
                        port = assert(port, "`connect.port` is required for a python `attach` configuration"),
                        host = host,
                        options = {
                            source_filetype = "python",
                        },
                    })
                else
                    cb({
                        type = "executable",
                        command = get_python_executable(),
                        args = { "-m", "debugpy.adapter" },
                        options = {
                            source_filetype = "python",
                        },
                    })
                end
            end

            dap.configurations.python = {
                {
                    -- The first three options are required by nvim-dap
                    type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
                    request = "launch",
                    name = "Launch file (from default config)",
                    justMyCode = false,

                    -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

                    program = "${file}", -- This configuration will launch the current file if used.
                    pythonPath = get_python_executable(),
                },
                {
                    -- The first three options are required by nvim-dap
                    type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
                    request = "attach",
                    name = "Attach to server (from default config)",
                    justMyCode = false,
                    connect = {
                        port = 5678,
                        host = "127.0.0.1",
                    },
                },
                {
                    type = "python",
                    request = "attach",
                    name = "Attach to a Docker container (from default config)",
                    connect = {
                        host = "127.0.0.1",
                        port = 5678,
                    },
                    pathMappings = {
                        {
                            localRoot = vim.fn.getcwd(),
                            remoteRoot = "/app",
                        },
                    },
                    justMyCode = false,
                },
            }
            dap.adapters.codelldb = {
                type = "server",
                port = "${port}",
                executable = {
                    command = ".",
                    args = { "--port", "$port" },
                },
            }
            dap.configurations.asm = {
                {
                    name = "Launch Assembly Program",
                    type = "codelldb",
                    request = "launch",
                    program = function()
                        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                    end,
                    cwd = "${workspaceFolder}",
                    stopOnEntry = false,
                    args = {},
                    -- Uncomment if you need to see disassembly
                    -- disableASLR = true,
                    -- displayFormat = 'auto',
                    -- showDisassembly = "always",
                },
            }
        end,
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
        config = function()
            local dapui = require("dapui").setup({
                icons = {
                    expanded = "▾",
                    collapsed = "▸",
                    current_frame = "⭐",
                },
                controls = {
                    icons = {
                        pause = "⏸️",
                        play = "🚀",
                        step_into = "🔽",
                        step_over = "⏩",
                        step_out = "🔼",
                        step_back = "◀️",
                        run_last = "🔁",
                        terminate = "❌",
                        disconnect = "🔌",
                    },
                },
            })
            vim.api.nvim_set_keymap(
                "n",
                "<leader>du",
                '<cmd>lua require("dapui").toggle()<CR>',
                { noremap = true, silent = true }
            )
        end,
    },
}
