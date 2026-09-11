return {
  {
    "norcalli/nvim-colorizer.lua",
    ft = { "css", "scss", "sass", "html", "javascript", "typescript", "vue" },
    config = function()
      require("colorizer").setup({
        "css",
        "scss",
        "sass",
        "html",
        "javascript",
        "typescript",
        "vue",
      }, {
        RGB = true,
        RRGGBB = true,
        names = true,
        RRGGBBAA = true,
        rgb_fn = true,
        hsl_fn = true,
        css = true,
        css_fn = true,
      })
    end,
  },
}
