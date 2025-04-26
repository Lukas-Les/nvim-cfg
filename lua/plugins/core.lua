return {
    { -- You can easily change to a different colorscheme.
        -- Change the name of the colorscheme plugin below, and then
        -- change the command in the config to whatever the name of that colorscheme is.
        --
        -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
        "folke/tokyonight.nvim",
        priority = 1000, -- Make sure to load this before all the other start plugins.
        config = function()
            ---@diagnostic disable-next-line: missing-fields
            require("tokyonight").setup({
                styles = {
                    comments = { italic = false }, -- Disable italics in comments
                },
            })

            -- Load the colorscheme here.
            -- Like many other themes, this one has different styles, and you could load
            -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
            vim.cmd.colorscheme("tokyonight-night")
        end,
    },
    {
        "folke/which-key.nvim",
        event = "VimEnter",
        opts = {
            delay = 0,
            icons = {
                mappings = vim.g.have_nerd_font,
                keys = vim.g.have_nerd_font and {} or {
                    Up = "<Up> ",
                    Down = "<Down> ",
                    Left = "<Left> ",
                    Right = "<Right> ",
                    C = "<C-…> ",
                    M = "<M-…> ",
                    D = "<D-…> ",
                    S = "<S-…> ",
                    CR = "<CR> ",
                    Esc = "<Esc> ",
                    ScrollWheelDown = "<ScrollWheelDown> ",
                    ScrollWheelUp = "<ScrollWheelUp> ",
                    NL = "<NL> ",
                    BS = "<BS> ",
                    Space = "<Space> ",
                    Tab = "<Tab> ",
                    F1 = "<F1>",
                    F2 = "<F2>",
                    F3 = "<F3>",
                    F4 = "<F4>",
                    F5 = "<F5>",
                    F6 = "<F6>",
                    F7 = "<F7>",
                    F8 = "<F8>",
                    F9 = "<F9>",
                    F10 = "<F10>",
                    F11 = "<F11>",
                    F12 = "<F12>",
                },
            },
            spec = {
                { "<leader>s", group = "[S]earch" },
                { "<leader>t", group = "[T]oggle" },
                { "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },
            },
        },
    },
    {
        "nvim-telescope/telescope.nvim",
        event = "VimEnter",
        dependencies = {
            "nvim-lua/plenary.nvim",
            { -- If encountering errors, see telescope-fzf-native README for installation instructions
                "nvim-telescope/telescope-fzf-native.nvim",

                -- `build` is used to run some command when the plugin is installed/updated.
                -- This is only run then, not every time Neovim starts up.
                build = "make",

                -- `cond` is a condition used to determine whether this plugin should be
                -- installed and loaded.
                cond = function()
                    return vim.fn.executable("make") == 1
                end,
            },
            { "nvim-telescope/telescope-ui-select.nvim" },
            { "Myzel394/jsonfly.nvim" },
        },
        config = function()
            require("telescope").setup({
                defaults = {
                    mappings = {
                        i = {
                            ["<C-d>"] = function(prompt_bufnr)
                                require("telescope.actions").delete_buffer(prompt_bufnr)
                                vim.api.nvim_buf_delete(prompt_bufnr, {})
                            end,
                        },
                        n = {
                            ["<C-d>"] = function(prompt_bufnr)
                                require("telescope.actions").delete_buffer(prompt_bufnr)
                                vim.api.nvim_buf_delete(prompt_bufnr, {})
                            end,
                        },
                    },
                },
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown(),
                    },
                },
            })

            pcall(require("telescope").load_extension, "fzf")
            pcall(require("telescope").load_extension, "ui-select")

            local builtin = require("telescope.builtin")

            vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
            vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
            vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
            vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
            vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
            vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
            vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
            vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
            vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
            vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })
            vim.keymap.set("n", "<leader>sm", builtin.git_status, { desc = "[S]earch [M]odified files" })

            -- Slightly advanced example of overriding default behavior and theme
            vim.keymap.set("n", "<leader>sb", function()
                -- You can pass additional configuration to Telescope to change the theme, layout, etc.
                builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
                    winblend = 10,
                    previewer = false,
                }))
            end, { desc = "[sb] Fuzzily search in current buffer" })

            -- Shortcut for searching your Neovim configuration files
            vim.keymap.set("n", "<leader>snf", function()
                builtin.find_files({ cwd = vim.fn.stdpath("config") })
            end, { desc = "[S]earch [N]eovim [F]iles" })

            vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
                pattern = { "*.json", "*.xml", "*.yaml", "*.yml" },
                callback = function()
                    vim.keymap.set("n", "<leader>j", "<cmd>Telescope jsonfly<CR>", { desc = "Open jsonfly" })
                end,
            })
        end,
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            -- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
            -- {
            --   "s1n7ax/nvim-window-picker", -- for open_with_window_picker keymaps
            --   version = "2.*",
            --   config = function()
            --     require("window-picker").setup({
            --       filter_rules = {
            --         include_current_win = false,
            --         autoselect_one = true,
            --         -- filter using buffer options
            --         bo = {
            --           -- if the file type is one of following, the window will be ignored
            --           filetype = { "neo-tree", "neo-tree-popup", "notify" },
            --           -- if the buffer type is one of following, the window will be ignored
            --           buftype = { "terminal", "quickfix" },
            --         },
            --       },
            --     })
            --   end,
            -- },
        },
        lazy = false,
        -----Instead of using `config`, you can use `opts` instead, if you'd like:
        -----@module "neo-tree"
        -----@type neotree.Config
        --opts = {},
        config = function()
            vim.opt.spell = true
            vim.opt.spelllang = { "en_us" }
            -- If you want icons for diagnostic errors, you'll need to define them somewhere.
            -- In Neovim v0.10+, you can configure them in vim.diagnostic.config(), like:
            --
            vim.diagnostic.config({
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = "E",
                        [vim.diagnostic.severity.WARN] = "W",
                        [vim.diagnostic.severity.INFO] = "I",
                        [vim.diagnostic.severity.HINT] = "H",
                    },
                },
            })
            --
            -- In older versions, you can define the signs manually:
            -- vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
            -- vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
            -- vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
            -- vim.fn.sign_define("DiagnosticSignHint", { text = "󰌵", texthl = "DiagnosticSignHint" })

            require("neo-tree").setup({
                close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
                popup_border_style = "rounded",
                enable_git_status = true,
                enable_diagnostics = true,
                open_files_do_not_replace_types = { "terminal", "trouble", "qf" }, -- when opening files, do not use windows containing these filetypes or buftypes
                open_files_using_relative_paths = false,
                sort_case_insensitive = false, -- used when sorting files and directories in the tree
                sort_function = nil, -- use a custom function for sorting files and directories in the tree
                -- sort_function = function (a,b)
                --       if a.type == b.type then
                --           return a.path > b.path
                --       else
                --           return a.type > b.type
                --       end
                --   end , -- this sorts files and directories descendantly
                default_component_configs = {
                    container = {
                        enable_character_fade = true,
                    },
                    indent = {
                        indent_size = 2,
                        padding = 1, -- extra padding on left hand side
                        -- indent guides
                        with_markers = true,
                        indent_marker = "│",
                        last_indent_marker = "└",
                        highlight = "NeoTreeIndentMarker",
                        -- expander config, needed for nesting files
                        with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
                        expander_collapsed = ">",
                        expander_expanded = "~",
                        expander_highlight = "NeoTreeExpander",
                    },
                    icon = {
                        folder_closed = "▶",
                        folder_open = "▼",
                        folder_empty = "▷",
                        default = " ",
                        highlight = "NeoTreeFileIcon",
                    },
                    modified = {
                        symbol = "[+]",
                        highlight = "NeoTreeModified",
                    },
                    name = {
                        trailing_slash = false,
                        use_git_status_colors = true,
                        highlight = "NeoTreeFileName",
                    },
                    git_status = {
                        symbols = {
                            -- Change type
                            added = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
                            modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
                            deleted = "✖", -- this can only be used in the git_status source
                            renamed = "r", -- this can only be used in the git_status source
                            -- Status type
                            untracked = "u",
                            ignored = "i",
                            unstaged = "U",
                            staged = "S",
                            conflict = "C",
                        },
                    },
                    -- If you don't want to use these columns, you can set `enabled = false` for each of them individually
                    file_size = {
                        enabled = true,
                        width = 12, -- width of the column
                        required_width = 64, -- min width of window required to show this column
                    },
                    type = {
                        enabled = true,
                        width = 10, -- width of the column
                        required_width = 122, -- min width of window required to show this column
                    },
                    last_modified = {
                        enabled = true,
                        width = 20, -- width of the column
                        required_width = 88, -- min width of window required to show this column
                    },
                    created = {
                        enabled = true,
                        width = 20, -- width of the column
                        required_width = 110, -- min width of window required to show this column
                    },
                    symlink_target = {
                        enabled = false,
                    },
                },
                -- A list of functions, each representing a global custom command
                -- that will be available in all sources (if not overridden in `opts[source_name].commands`)
                -- see `:h neo-tree-custom-commands-global`
                commands = {},
                window = {
                    position = "right",
                    width = 40,
                    mapping_options = {
                        noremap = true,
                        nowait = true,
                    },
                    mappings = {
                        ["<space>"] = {
                            "toggle_node",
                            nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
                        },
                        ["<2-LeftMouse>"] = "open",
                        ["<cr>"] = "open",
                        ["<esc>"] = "cancel", -- close preview or floating neo-tree window
                        ["P"] = { "toggle_preview", config = { use_float = true, use_image_nvim = true } },
                        -- Read `# Preview Mode` for more information
                        ["l"] = "focus_preview",
                        ["S"] = "open_split",
                        ["s"] = "open_vsplit",
                        -- ["S"] = "split_with_window_picker",
                        -- ["s"] = "vsplit_with_window_picker",
                        ["t"] = "open_tabnew",
                        -- ["<cr>"] = "open_drop",
                        -- ["t"] = "open_tab_drop",
                        ["w"] = "open_with_window_picker",
                        --["P"] = "toggle_preview", -- enter preview mode, which shows the current node without focusing
                        ["C"] = "close_node",
                        -- ['C'] = 'close_all_subnodes',
                        ["z"] = "close_all_nodes",
                        --["Z"] = "expand_all_nodes",
                        ["a"] = {
                            "add",
                            -- this command supports BASH style brace expansion ("x{a,b,c}" -> xa,xb,xc). see `:h neo-tree-file-actions` for details
                            -- some commands may take optional config options, see `:h neo-tree-mappings` for details
                            config = {
                                show_path = "none", -- "none", "relative", "absolute"
                            },
                        },
                        ["A"] = "add_directory", -- also accepts the optional config.show_path option like "add". this also supports BASH style brace expansion.
                        ["d"] = "delete",
                        ["r"] = "rename",
                        ["b"] = "rename_basename",
                        ["y"] = "copy_to_clipboard",
                        ["x"] = "cut_to_clipboard",
                        ["p"] = "paste_from_clipboard",
                        ["c"] = "copy", -- takes text input for destination, also accepts the optional config.show_path option like "add":
                        -- ["c"] = {
                        --  "copy",
                        --  config = {
                        --    show_path = "none" -- "none", "relative", "absolute"
                        --  }
                        --}
                        ["m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
                        ["q"] = "close_window",
                        ["R"] = "refresh",
                        ["?"] = "show_help",
                        ["<"] = "prev_source",
                        [">"] = "next_source",
                        ["i"] = "show_file_details",
                        -- ["i"] = {
                        --   "show_file_details",
                        --   -- format strings of the timestamps shown for date created and last modified (see `:h os.date()`)
                        --   -- both options accept a string or a function that takes in the date in seconds and returns a string to display
                        --   -- config = {
                        --   --   created_format = "%Y-%m-%d %I:%M %p",
                        --   --   modified_format = "relative", -- equivalent to the line below
                        --   --   modified_format = function(seconds) return require('neo-tree.utils').relative_date(seconds) end
                        --   -- }
                        -- },
                    },
                },
                nesting_rules = {},
                filesystem = {
                    filtered_items = {
                        visible = false, -- when true, they will just be displayed differently than normal items
                        hide_dotfiles = true,
                        hide_gitignored = true,
                        hide_hidden = true, -- only works on Windows for hidden files/directories
                        hide_by_name = {
                            --"node_modules"
                        },
                        hide_by_pattern = { -- uses glob style patterns
                            --"*.meta",
                            --"*/src/*/tsconfig.json",
                        },
                        always_show = { -- remains visible even if other settings would normally hide it
                            --".gitignored",
                        },
                        always_show_by_pattern = { -- uses glob style patterns
                            --".env*",
                        },
                        never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
                            --".DS_Store",
                            --"thumbs.db"
                        },
                        never_show_by_pattern = { -- uses glob style patterns
                            --".null-ls_*",
                        },
                    },
                    follow_current_file = {
                        enabled = false, -- This will find and focus the file in the active buffer every time
                        --               -- the current file is changed while the tree is open.
                        leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
                    },
                    group_empty_dirs = false, -- when true, empty folders will be grouped together
                    hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
                    -- in whatever position is specified in window.position
                    -- "open_current",  -- netrw disabled, opening a directory opens within the
                    -- window like netrw would, regardless of window.position
                    -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
                    use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes
                    -- instead of relying on nvim autocmd events.
                    window = {
                        mappings = {
                            ["<bs>"] = "navigate_up",
                            ["."] = "set_root",
                            ["H"] = "toggle_hidden",
                            ["/"] = "fuzzy_finder",
                            ["D"] = "fuzzy_finder_directory",
                            ["#"] = "fuzzy_sorter", -- fuzzy sorting using the fzy algorithm
                            -- ["D"] = "fuzzy_sorter_directory",
                            ["f"] = "filter_on_submit",
                            ["<c-x>"] = "clear_filter",
                            ["[g"] = "prev_git_modified",
                            ["]g"] = "next_git_modified",
                            ["o"] = {
                                "show_help",
                                nowait = false,
                                config = { title = "Order by", prefix_key = "o" },
                            },
                            ["oc"] = { "order_by_created", nowait = false },
                            ["od"] = { "order_by_diagnostics", nowait = false },
                            ["og"] = { "order_by_git_status", nowait = false },
                            ["om"] = { "order_by_modified", nowait = false },
                            ["on"] = { "order_by_name", nowait = false },
                            ["os"] = { "order_by_size", nowait = false },
                            ["ot"] = { "order_by_type", nowait = false },
                            -- ['<key>'] = function(state) ... end,
                        },
                        fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
                            ["<down>"] = "move_cursor_down",
                            ["<C-n>"] = "move_cursor_down",
                            ["<up>"] = "move_cursor_up",
                            ["<C-p>"] = "move_cursor_up",
                            ["<esc>"] = "close",
                            -- ['<key>'] = function(state, scroll_padding) ... end,
                        },
                    },

                    commands = {}, -- Add a custom command or override a global one using the same function name
                },
                buffers = {
                    follow_current_file = {
                        enabled = true, -- This will find and focus the file in the active buffer every time
                        --              -- the current file is changed while the tree is open.
                        leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
                    },
                    group_empty_dirs = true, -- when true, empty folders will be grouped together
                    show_unloaded = true,
                    window = {
                        mappings = {
                            ["d"] = "buffer_delete",
                            ["bd"] = "buffer_delete",
                            ["<bs>"] = "navigate_up",
                            ["."] = "set_root",
                            ["o"] = {
                                "show_help",
                                nowait = false,
                                config = { title = "Order by", prefix_key = "o" },
                            },
                            ["oc"] = { "order_by_created", nowait = false },
                            ["od"] = { "order_by_diagnostics", nowait = false },
                            ["om"] = { "order_by_modified", nowait = false },
                            ["on"] = { "order_by_name", nowait = false },
                            ["os"] = { "order_by_size", nowait = false },
                            ["ot"] = { "order_by_type", nowait = false },
                        },
                    },
                },
                git_status = {
                    window = {
                        position = "float",
                        mappings = {
                            ["A"] = "git_add_all",
                            ["gu"] = "git_unstage_file",
                            ["ga"] = "git_add_file",
                            ["gr"] = "git_revert_file",
                            ["gc"] = "git_commit",
                            ["gp"] = "git_push",
                            ["gg"] = "git_commit_and_push",
                            ["o"] = {
                                "show_help",
                                nowait = false,
                                config = { title = "Order by", prefix_key = "o" },
                            },
                            ["oc"] = { "order_by_created", nowait = false },
                            ["od"] = { "order_by_diagnostics", nowait = false },
                            ["om"] = { "order_by_modified", nowait = false },
                            ["on"] = { "order_by_name", nowait = false },
                            ["os"] = { "order_by_size", nowait = false },
                            ["ot"] = { "order_by_type", nowait = false },
                        },
                    },
                },
            })

            vim.keymap.set("n", "<leader>ntr", "<Cmd>Neotree reveal<CR>")
        end,
    },
}
