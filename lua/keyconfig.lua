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
