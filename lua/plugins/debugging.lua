return {
    {
        "mfussenegger/nvim-dap",
        config = function()
            local dap = require("dap")
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
                        command = "./.venv/bin/python",
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
                    name = "Launch file",
                    justMyCode = false,

                    -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

                    program = "${file}", -- This configuration will launch the current file if used.
                    pythonPath = function()
                        -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
                        -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
                        -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
                        local cwd = vim.fn.getcwd()
                        if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
                            return cwd .. "/venv/bin/python"
                        elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
                            return cwd .. "/.venv/bin/python"
                        else
                            return "/usr/bin/python"
                        end
                    end,
                },
                {
                    -- The first three options are required by nvim-dap
                    type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
                    request = "attach",
                    name = "Attach to server",
                    justMyCode = false,
                    connect = {
                        port = 5678,
                        host = "127.0.0.1",
                    },
                },
                {
                    type = "python",
                    request = "attach",
                    name = "Attach to a Docker container",
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
        end,
    },
}
