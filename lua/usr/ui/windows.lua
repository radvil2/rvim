---@desc auto-resize windows on focused

local M = {}

M.id = "anuvyklack/windows.nvim"

M.dependencies = {
  { "anuvyklack/middleclass" },
  { "anuvyklack/animation.nvim", enabled = true },
}

M.keys = {
  {
    "<Leader>wm",
    "<Cmd>WindowsMaximize<Cr>",
    desc = "[Window] Toggle maximize",
  },
  {
    "<Leader>w=",
    "<Cmd>WindowsEqualize<Cr>",
    desc = "[Window] Equalize size",
  },
  {
    "<Leader>wa",
    "<Cmd>WindowsToggleAutowidth<Cr>",
    desc = "[Window] Toggle auto resize",
  },
}

M.config = function()
  vim.o.winwidth = 5
  vim.o.winminwidth = 5
  ---@desc disable this if you wanna animate
  vim.o.equalalways = false
  require("windows").setup({
    animation = {
      enable = true,
      duration = 150,
    },
  })
end

M.repo = {
  M.id,
  keys = M.keys,
  event = "WinNew",
  config = M.config,
  dependencies = M.dependencies,
}

return M
