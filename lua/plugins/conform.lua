return {
  "stevearc/conform.nvim",
  config = function ()
    require("conform").setup({
        formatters_by_ft = {
            lua = { "stylua" },
            python = { "isort", "black" },
            rust = { "rustfmt", lsp_format = "fallback" },
            json = { "jq" },
        },
        opts = {
            lsp_format = "fallback",
        }
    })
    vim.api.nvim_set_keymap(
        "n",
        "<leader>fm",
        '<cmd>lua require("conform").format()<CR>',
        { noremap = true, silent = true }
    )
  end
}
