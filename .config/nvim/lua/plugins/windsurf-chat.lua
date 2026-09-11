-- ~/.config/nvim/lua/plugins/windsurf-chat.lua
-- Chat AI integrado (opcional)

return {
  {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    enabled = false, -- Cambia a true y configura API key para activar
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "folke/trouble.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("chatgpt").setup({
        api_key_cmd = "echo $OPENAI_API_KEY",
        openai_params = {
          model = "gpt-3.5-turbo",
          frequency_penalty = 0,
          presence_penalty = 0,
          max_tokens = 300,
          temperature = 0,
          top_p = 1,
          n = 1,
        },
      })
    end,
    keys = {
      { "<leader>ai", "<cmd>ChatGPT<CR>", desc = "ChatGPT" },
      { "<leader>ae", "<cmd>ChatGPTEditWithInstruction<CR>", mode = { "n", "v" }, desc = "Edit with instruction" },
      { "<leader>ag", "<cmd>ChatGPTRun grammar_correction<CR>", mode = { "n", "v" }, desc = "Grammar Correction" },
      { "<leader>at", "<cmd>ChatGPTRun translate<CR>", mode = { "n", "v" }, desc = "Translate" },
      { "<leader>ak", "<cmd>ChatGPTRun keywords<CR>", mode = { "n", "v" }, desc = "Keywords" },
      { "<leader>ad", "<cmd>ChatGPTRun docstring<CR>", mode = { "n", "v" }, desc = "Docstring" },
      {
        "<leader>ac",
        "<cmd>ChatGPTRun code_readability_analysis<CR>",
        mode = { "n", "v" },
        desc = "Code Readability Analysis",
      },
    },
  },
}
