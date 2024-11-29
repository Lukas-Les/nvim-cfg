return {
    'nvim-lualine/lualine.nvim',
    -- dependencies = { 'nvim-tree/nvim-web-devicons' }
    opts = {
        options = {
            icons_enabled = false,
            component_separators = { left = '', right = '' },
            section_separators = { left = '', right = '' },
        },
        extensions = { 'neo-tree', 'nvim-dap-ui' },
    }
}
