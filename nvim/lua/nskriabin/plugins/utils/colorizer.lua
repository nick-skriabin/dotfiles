return {
    "norcalli/nvim-colorizer.lua",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        "css",
        "stylus",
        "sass",
        "javascript",
        "typescript",
        "javascript.react",
        "typescript.react",
        "html",
    },
}
