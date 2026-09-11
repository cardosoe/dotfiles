-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
--
-- Autocmds adicionales específicos para tu workflow

local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

-- Laravel Blade configuration
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  group = augroup("blade"),
  pattern = "*.blade.php",
  callback = function()
    vim.bo.filetype = "blade"
  end,
})

-- PHP configuration
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("php"),
  pattern = "php",
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.expandtab = true
  end,
})

-- Angular/TypeScript configuration
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("web_dev"),
  pattern = { "typescript", "javascript", "html", "css", "scss", "json" },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.expandtab = true
  end,
})

-- Configuración para abrir PDFs automáticamente
vim.api.nvim_create_autocmd({ "BufReadPost", "FileReadPost" }, {
  pattern = "*.pdf",
  callback = function()
    local file_path = vim.fn.expand("%:p")

    -- Limpiar el buffer actual
    vim.cmd("silent %delete _")

    -- Convertir PDF a texto y cargarlo en el buffer
    local cmd = string.format("pdftotext -layout -nopgbrk -q '%s' -", file_path)
    vim.cmd("silent 0read !" .. cmd)

    -- Eliminar la primera línea vacía si existe
    if vim.fn.getline(1) == "" then
      vim.cmd("silent 1delete _")
    end

    -- Configurar el buffer
    vim.cmd("set nomodified")
    vim.cmd("set readonly")
    vim.cmd("set filetype=text")
    vim.cmd("set syntax=text")

    -- Ir al inicio del archivo
    vim.cmd("normal! gg")

    -- Mensaje informativo
    print("PDF cargado: " .. vim.fn.expand("%:t"))
  end,
})

-- Mapeos de teclas útiles para PDFs
vim.api.nvim_create_autocmd("FileType", {
  pattern = "text",
  callback = function()
    -- Solo aplicar si es un archivo PDF
    if vim.fn.expand("%:e") == "pdf" then
      local opts = { buffer = true, silent = true }

      -- q para cerrar
      vim.keymap.set("n", "q", "<cmd>q<cr>", opts)

      -- r para recargar el PDF
      vim.keymap.set("n", "r", function()
        vim.cmd("e!")
      end, opts)

      -- Mostrar información del archivo con 'i'
      vim.keymap.set("n", "i", function()
        local file_info = vim.fn.system("pdfinfo '" .. vim.fn.expand("%:p") .. "'")
        print(file_info)
      end, opts)
    end
  end,
})
