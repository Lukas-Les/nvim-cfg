return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        -- "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
        -- "3rd/image.nvim", -- Optional image support in preview window
    },
    config = function()
        vim.keymap.set("n", "<leader>nt", "<Cmd>Neotree toggle<CR>", { desc = "Toggle Neotree" })
        vim.keymap.set("n", "<leader>ntr", "<Cmd>Neotree reveal<CR>", { noremap = true, silent = true })
        require("neo-tree").setup({
            close_if_last_window = true,
            default_component_configs = {
                indent = {
                    expander_collapsed = "▶",
                    expander_expanded = "▼",
                },
                icon = {
                    folder_closed = "▶",
                    folder_open = "▼",
                    folder_empty = "▷",
                    default = " ",
                    highlight = "NeoTreeFileIcon",
                },
                name = {
                    use_git_status_colors = false,
                },
                git_status = {
                    symbols = {
                        added = "",
                        modified = "✹",
                        deleted = "✖",
                        renamed = "➜",
                        untracked = "✭",
                        ignored = "☒",
                        unstaged = "✗",
                        staged = "+",
                        conflict = "C",
                    },
                },
            },
            filesystem = {
                follow_current_file = { "enabled" },
                filtered_items = {
                    hide_dotfiles = false,
                    hide_gitignored = false,
                    never_show = { ".git" },
                },
            },
            window = {
                position = "right",
                mappings = {
                    ["oo"] = { "open", nowait = true },
                    ["Y"] = "copy_filename_to_clipboard",
                },
            },
            commands = {
                copy_filename_to_clipboard = function(state)
                    local node = state.tree:get_node()
                    local filename = node.name
                    vim.fn.setreg("+", filename) -- Copy to system clipboard
                    print("Copied: " .. filename .. " to clipboard")
                end,
            },
        })
    end,
}
