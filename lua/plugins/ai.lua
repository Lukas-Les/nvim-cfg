return {
    "olimorris/codecompanion.nvim",
    opts = {},
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    config = function()
        require("codecompanion").setup({
            strategies = {
                chat = {
                    adapter = "gemini",
                },
                inline = {
                    adapter = "gemini",
                },
            },
            adapters = {
                gemini = function()
                    return require("codecompanion.adapters").extend("gemini", {
                        env = {
                            api_key = "GEMINI_API_KEY",
                        },
                    })
                end,
            },
            display = {
                action_pallete = { provider = "telescope" },
            },
        })
        vim.keymap.set("n", "<leader>cc", "<cmd>CodeCompanionChat Toggle<CR>", { desc = "[C]odeCompanion [C]hat" })
        vim.keymap.set("n", "<leader>ca", "<cmd>CodeCompanionActions<CR>", { desc = "[C]odeCompanion [A]ctions" })
        vim.keymap.set(
            { "n", "v" },
            "<leader>ce",
            "<cmd>CodeCompanion /explain<CR>",
            { desc = "[C]odeCompanion [E]xplain" }
        )
        vim.keymap.set(
            { "n", "v" },
            "<leader>cr",
            "<cmd>CodeCompanion /review<CR>",
            { desc = "[C]odeCompanion [R]eview" }
        )
        vim.keymap.set(
            { "n", "v" },
            "<leader>ci",
            "<cmd>CodeCompanion<CR>",
            { desc = "[C]odeCompanion [I]nline Suggestion" }
        )
    end,
}
