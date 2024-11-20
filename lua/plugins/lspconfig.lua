return {
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            -- Setup Rust Analyzer
            lspconfig.rust_analyzer.setup({
                capabilities = capabilities,
                filetypes = { "rust" },
            })
            -- Setup Ruff LSP for linting
            --      lspconfig.ruff_lsp.setup({
            --        capabilities = capabilities,
            --        filetypes = { "python" },
            --      })
            -- Replace 'pylsp' with 'jedi_language_server' if using that instead
            lspconfig.pylsp.setup({
                capabilities = capabilities,
                filetypes = { "python" },
            })

            -- Setup gopls for Go
            lspconfig.gopls.setup({
                capabilities = capabilities,
                cmd = { "gopls" }, -- Ensure gopls is in your PATH
                filetypes = { "go", "gomod" },
                root_dir = lspconfig.util.root_pattern("go.mod", ".git"),
                settings = {
                    gopls = {
                        analyses = {
                            unusedparams = true,
                        },
                        staticcheck = true,
                    },
                },
            })
        end,
    },

    -- nvim-cmp and its sources
    { "hrsh7th/cmp-nvim-lsp" },
    {
        "hrsh7th/nvim-cmp",
        requires = {
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/vim-vsnip",
            "L3MON4D3/LuaSnip",
        },
        config = function()
            local cmp = require("cmp")
            local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
            vim.api.nvim_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", { noremap = true, silent = true })
            cmp.setup({
                snippet = {
                    expand = function(args)
                        vim.fn["vsnip#anonymous"](args.body)
                    end,
                },
                mapping = {
                    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-d>"] = cmp.mapping.scroll_docs(4),
                    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
                    ["<Tab>"] = cmp.mapping.select_next_item(),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.close(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                },
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "buffer" },
                    { name = "path" },
                }),
            })
        end,
    },
}
