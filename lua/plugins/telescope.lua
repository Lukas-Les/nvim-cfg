return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",
        -- or branch = '0.1.x',
        dependencies = {
            "nvim-lua/plenary.nvim",
            "Myzel394/jsonfly.nvim",
        },

        config = function()
            -- Setup for Telescope
            local telescope = require("telescope")
            local builtin = require("telescope.builtin")
            telescope.setup({})
            local jsonfly = require("telescope").load_extension("jsonfly")
            -- Keybindings
            vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
            vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
            vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
            vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
            vim.keymap.set("n", "<leader>j", "<cmd>Telescope jsonfly<cr>", { desc = "Open jsonfly" })
        end,
    },
}
