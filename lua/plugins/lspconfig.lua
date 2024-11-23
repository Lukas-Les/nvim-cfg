return {
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            -- Rust Analyzer is configured by the Rustaceanvim
            lspconfig.rust_analyzer.setup({
                capabilities = capabilities,
                filetypes = { "rust" },
                on_attach = function(client, bufnr)
                    require("dap-lldb")
                end,
            })

            lspconfig.pyright.setup({
                capabilities = capabilities,
                filetypes = { "python" },
                on_attach = function(client, bufnr)
                    require("dap-python")
                end,
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
    { "L3MON4D3/LuaSnip" },
    {
        "hrsh7th/nvim-cmp",
        requires = {
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/vim-vsnip",
            "saadparwaiz1/cmp_luasnip",
        },
        config = function()
            local luasnip = require("luasnip")
            local cmp = require("cmp")
            local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
            vim.api.nvim_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", { noremap = true, silent = true })
            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
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
                    { name = 'luasnip' },
                }),
            })
        end,
    },
    -- Rust LSP and debugger
    -- {
    --   "mrcjkb/rustaceanvim",
    --   version = "^5", -- Recommended
    --   lazy = false, -- This plugin is already lazy
    -- },
}
