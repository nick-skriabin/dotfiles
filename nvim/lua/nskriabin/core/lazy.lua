local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    { import = "nskriabin.plugins.theme" },
    { import = "nskriabin.plugins.ai" },
    { import = "nskriabin.plugins.dap" },
    { import = "nskriabin.plugins.ui" },
    { import = "nskriabin.plugins.git" },
    { import = "nskriabin.plugins.code" },
    { import = "nskriabin.plugins.nav" },
    { import = "nskriabin.plugins.utils" },
    { import = "nskriabin.plugins.lsp" },
}, {
    rocks = {
        hererocks = true,
    },
    install = {
        missing = true,
        colorscheme = { "zenbones" },
    },
    checker = {
        enabled = true,
        notify = false,
    }, -- automatically check for plugin updates
    change_detection = {
        notify = false,
    },
    dev = {
        path = "~/Git",
    },
})

require("nskriabin.auto")
