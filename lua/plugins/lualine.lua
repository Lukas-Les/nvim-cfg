return {
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
}
