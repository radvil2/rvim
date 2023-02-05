--- @desc rainbow bracket pairs
--TODO: not working ?
local M = {}

M.id = "p00f/nvim-ts-rainbow"

--- @type LazySpec
M.repo = {
  M.id,
  cond = function()
    return require("utils").has("nvim-treesitter")
  end,
}

return M
