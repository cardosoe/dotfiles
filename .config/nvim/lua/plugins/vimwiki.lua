return {
  {
    "vimwiki/vimwiki",
    url = "https://github.com/vimwiki/vimwiki.git",
    lazy = false,
    init = function()
      -- Asegura que la variable global sea interpretada como diccionario/tabla válida
      vim.g.vimwiki_list = {
        {
          path = "~/Dropbox/vimwiki/",
          syntax = "markdown",
          ext = ".md",
        },
      }
    end,
  },
}
