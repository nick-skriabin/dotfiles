return {
  "RRethy/vim-illuminate",
  event = { "BufReadPre", "BufNewFile" },
  opts = {},
  config = function()
    require("illuminate").configure({
      filetype_denylist = {
        "neotree",
        "oil",
        "dirbuf",
        "dirvish",
        "fugitive",
        "octo",
      },
    })
  end,
}
