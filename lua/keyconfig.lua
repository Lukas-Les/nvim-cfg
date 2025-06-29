-- map jj to escape
vim.keymap.set("i", "jj", "<Esc>", { noremap = true, silent = true })

vim.keymap.set("n", "<C-s>", "<Cmd>:w<CR>", { desc = "Save file" })

-- Buffers
vim.keymap.set("n", "<leader>b", ":bn<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>B", ":bN<CR>", { desc = "Previous buffer" })

-- Windows
vim.keymap.set("n", "<C-c>", "<Cmd>:q<CR>", { remap = true, silent = true, desc = "Close the window" })
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

-- Tabs
vim.keymap.set("n", "<C-t>", ":tabnew<CR>", { desc = "Open new tab" })
vim.keymap.set("n", "<C-q>", ":tabclose<CR>", { desc = "Close current tab" })

-- Search
vim.keymap.set(
    "n",
    "<leader>/",
    "<Cmd>set invhlsearch<CR>",
    { remap = true, silent = true, desc = "Hide search highlights" }
)
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- If you visually select something and hit paste
-- that thing gets yanked into your buffer. This
-- generally is annoying when you're copying one item
-- and repeatedly pasting it. This changes the paste
-- command in visual mode so that it doesn't overwrite
-- whatever is in your paste buffer.
vim.keymap.set("v", "p", '"_dP"')

vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- move lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
