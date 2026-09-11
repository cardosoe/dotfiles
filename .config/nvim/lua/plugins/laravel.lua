return {
  -- Laravel IDE helper support
  {
    "tpope/vim-projectionist",
    event = "VeryLazy",
    config = function()
      vim.g.projectionist_heuristics = {
        ["artisan"] = {
          ["app/Models/*.php"] = {
            type = "model",
            alternate = "database/factories/{}Factory.php",
          },
          ["app/Http/Controllers/*.php"] = {
            type = "controller",
            alternate = "tests/Feature/{}Test.php",
          },
          ["database/migrations/*.php"] = {
            type = "migration",
          },
          ["resources/views/*.blade.php"] = {
            type = "view",
            alternate = "app/Http/Controllers/{}Controller.php",
          },
          ["routes/*.php"] = {
            type = "route",
          },
          ["tests/Feature/*.php"] = {
            type = "test",
            alternate = "app/Http/Controllers/{}Controller.php",
          },
        },
      }
    end,
  },
}
