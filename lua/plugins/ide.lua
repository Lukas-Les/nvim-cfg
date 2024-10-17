return {
	{
	  "folke/which-key.nvim",
	  event = "VeryLazy",
	  opts = {
	    -- your configuration comes here
	    -- or leave it empty to use the default settings
	    -- refer to the configuration section below
	  },
	  keys = {
	    {
	      "<leader>?",
	      function()
		    require("which-key").show({ global = false })
	      end,
	      desc = "Buffer Local Keymaps (which-key)",
	    },
	  },
	},
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      -- "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    config = function()
      require('neo-tree').setup({
        close_if_last_window = true,

        default_component_configs = {
          indent = {
            expander_collapsed = '▶',
            expander_expanded = '▼',
          },
          icon = {
            folder_closed = '▶',
            folder_open = '▼',
            folder_empty = '▷',
            default = ' ',
            highlight = 'NeoTreeFileIcon',
          },
          name = {
            use_git_status_colors = false,
          },
          git_status = {
            symbols = {
              added = '',
              modified = '✹',
              deleted = '✖',
              renamed = '➜',
              untracked = '✭',
              ignored = '☒',
              unstaged = '✗',
              staged = '+',
              conflict = 'C',
            },
          },
        },

        filesystem = {
          filtered_items = {
            hide_dotfiles = false,
            hide_gitignored = false,
            never_show = { '.git' },
          },
        },

        window = {
          position = 'left',
          mappings = {
            ['oo'] = { 'open', nowait = true },
          },
        },
      })
    end,
  },
}
