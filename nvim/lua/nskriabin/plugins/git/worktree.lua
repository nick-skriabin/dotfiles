return {
    "ThePrimeagen/git-worktree.nvim",
    lazy = true,
    config = function()
        require("git-worktree").setup()
    end,
}
