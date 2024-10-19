return  {
    "tpope/vim-fugitive",
    config = function()
      vim.keymap.set("n", "gs", "<Cmd>Git<CR>")
    end,
}

