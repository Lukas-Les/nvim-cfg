return {
    {
        "UtkarshVerma/molokai.nvim",
        priority = 1000,
        config = function()
            require("molokai").setup({
                styles = {
                    comments = { italic = false },
                    keywords = { italic = false },
                },
            })

            vim.cmd.colorscheme("molokai")
        end,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        ---@module "ibl"
        ---@type ibl.config
        opts = {},
    },
    {
        "nvim-lualine/lualine.nvim",
        -- dependencies = { 'nvim-tree/nvim-web-devicons' }
        opts = {
            options = {
                icons_enabled = false,
                theme = "molokai",
                component_separators = { left = "", right = "" },
                section_separators = { left = "", right = "" },
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "branch", "diff", "diagnostics" },
                lualine_c = { "filename" },
                lualine_x = { "encoding", "fileformat", "filetype" },
                lualine_y = { "progress" },
                lualine_z = { "location" },
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = {},
            },
            extensions = { "neo-tree", "nvim-dap-ui" },
        },
    },
}
