-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.t_co = 256 -- enabling support for 256 colors in whichever terminal emulator
vim.g.background = "dark" -- terminal background will use dark or light mode

-- Set to true if you have a Nerd Font installed
vim.g.have_nerd_font = false

-- [[ Setting options ]]
-- See `:help vim.opt`
--  For more options, you can see `:help option-list`

vim.opt.virtualedit = "onemore" -- Allow cursor beyond last character

vim.opt.clipboard = "unnamedplus" -- Sync clipboard between OS and Neovim.

vim.opt.undofile = true -- Save undo history

vim.opt.tabpagemax = 15 -- Show only 15 tabs
vim.opt.showmode = false -- Don't show the mode, since it's already in status line

vim.opt.colorcolumn = "121" -- Highlight column
vim.opt.cursorline = true -- Highlight current line

vim.opt.number = true -- Display line numbers
vim.opt.relativenumber = false -- Display relative line numbers
vim.opt.showmatch = true -- Show matching brackets/parenthesis
vim.opt.hlsearch = true -- Highlight search terms
vim.opt.incsearch = true -- Find as you type search
vim.opt.ignorecase = true -- Case insesitive search
vim.opt.smartcase = true -- Case sensitive when uc present
vim.opt.scrolloff = 10 -- Minimal number of screen lines to keep above and below the cursor
vim.opt.foldenable = false -- Disable code folding
vim.opt.splitright = true -- Puts new vsplit windows to the right of the current
vim.opt.splitbelow = true -- Puts new split windows to the bottom of the current

-- Filetypes
vim.opt.encoding = "utf8" -- str:  String encoding to use
vim.opt.fileencoding = "utf8" -- str:  File encoding to use

-- Formatting
vim.opt.wrap = true -- Wrap long lines
vim.opt.linebreak = true -- Wrap lines at convenient points
vim.opt.autoindent = true -- Indent at the same level of previous line
vim.opt.shiftwidth = 4 -- Use indents of 4 spaces
vim.opt.expandtab = true -- Tabs are spaces
vim.opt.tabstop = 4 -- An indentation every four columns
vim.opt.softtabstop = 4 -- Let backspace delete indent
vim.opt.smartindent = true -- Automatically inserts one extra level of indentation in some cases

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup("plugins", {
    spec = {
        -- add your plugins here
    },
    -- Configure any other settings here. See the documentation for more details.
    -- colorscheme that will be used when installing plugins.
    install = { colorscheme = { "habamax" } },
    -- automatically check for plugin updates
    checker = { enabled = true },
    ui = {
        icons = vim.g.have_nerd_font and {} or {
            cmd = "⌘",
            config = "🛠",
            event = "📅",
            favorite = "⭐",
            ft = "📂",
            init = "⚙",
            import = "📥",
            keys = "🗝",
            lazy = "💤 ",
            plugin = "🔌",
            runtime = "💻",
            require = "🌙",
            source = "📄",
            start = "🚀",
            task = "📌",
        },
    },
})

require("keyconfig")
