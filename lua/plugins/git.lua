return  {
    'tpope/vim-fugitive',
    lazy = false,
    config = function()
      vim.keymap.set('n', 'gs', '<Cmd>Git<CR>')
    end,
}

