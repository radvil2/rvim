local M = {}

M.id = "abecodes/tabout.nvim"

M.dependencies = { "nvim-cmp", "nvim-treesitter" }

M.opts = {
  tabkey = "<A-l>",
  backwards_tabkey = "<A-h>",
}

M.repo = {
  M.id,
  opts = M.opts,
  dependencies = M.dependencies,
}

return M
