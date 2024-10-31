return  {
    "tpope/vim-fugitive",

    config = function()
        local function in_git_repo()
            local git_dir = vim.fn.systemlist("git rev-parse --git-dir")[1]
            return git_dir and #git_dir > 0 and not git_dir:match("^fatal")
        end

        vim.keymap.set("n", "gsc", "<Cmd>Git commit<CR>", { desc = "Git commit" })
        vim.keymap.set("n", "gsl", "<Cmd>Git pull<CR>", { desc = "Git pull" })
        vim.keymap.set("n", "gsd", "<Cmd>Git diff<CR>", { desc = "Git diff" })

        vim.keymap.set("v", "gss", ":Gwrite<CR>", { desc = "Git stage selected" })
        vim.keymap.set("v", "gsr", ":Git reset<CR>", { desc = "Git reset selected" })

        vim.keymap.set("n", "gs", function()
            if in_git_repo() then
                vim.cmd("Git")
            else
                vim.notify("Not in a git repository", vim.log.levels.WARN)
            end
        end, { desc = "Git status" })

        vim.keymap.set("n", "gsb", function()
            if in_git_repo() then
                vim.cmd("Git blame")
            else
                vim.notify("Not in a git repository", vim.log.levels.WARN)
            end
        end, { desc = "Git blame" })

        vim.keymap.set("n", "gsp", function()
            if in_git_repo() then
                vim.cmd("Git push")
            else
                vim.notify("Not in a git repository", vim.log.levels.WARN)
            end
        end, { desc = "Git push" })
    end,
}

