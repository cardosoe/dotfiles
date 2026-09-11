return {
  {
    "mattn/emmet-vim",
    ft = { "html", "css", "javascript", "typescript", "php", "blade", "vue", "jsx", "tsx" },
    config = function()
      vim.g.user_emmet_leader_key = "<C-e>"
      vim.g.user_emmet_settings = {
        php = {
          extends = "html",
          filters = "c",
        },
        blade = {
          extends = "html",
          filters = "c",
        },
        typescript = {
          extends = "html",
        },
        javascript = {
          extends = "html",
        },
      }
    end,
  },
}
