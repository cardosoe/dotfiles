-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local keymap = vim.keymap.set

-- Keymaps personalizados adicionales
keymap("n", "<leader>gg", ":LazyGit<CR>", { desc = "LazyGit" })
keymap("n", "<leader>e", ":Neotree toggle<CR>", { desc = "Toggle Explorer" })

-- Keymaps específicos para desarrollo web
keymap("n", "<leader>lf", ":lua vim.lsp.buf.format()<CR>", { desc = "Format Document" })

---:
