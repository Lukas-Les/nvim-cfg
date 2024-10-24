return {
    "williamboman/mason.nvim",
    dependencies = {"vhyrro/luarocks.nvim"}
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason").setup()
            require("mason-lspconfig").setup()
        end,
    }
}

