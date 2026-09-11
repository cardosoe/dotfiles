return {
  {
    "Exafunction/codeium.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("codeium").setup({
        enable_cmp_source = false,
        virtual_text = {
          enabled = true,
          key_bindings = {
            accept = "<C-l>", -- Ctrl+L - muy intuitivo para "accept"
            accept_word = "<C-Right>", -- Aceptar solo una palabra
            next = "<M-]>",
            prev = "<M-[>",
            clear = "<C-x>", -- Limpiar sugerencias
          },
        },
      })
    end,
  },
}
