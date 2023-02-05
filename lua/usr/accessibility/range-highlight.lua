---@desc: highlight range on cmdline
--Should deactivate relative number for this,
-- TODO: set condition on vim.opt.relativenumber value changes
--
local M = {}

M.id = "winston0410/range-highlight.nvim"

M.dependencies = {
  "winston0410/cmd-parser.nvim",
}

M.opts = {
  highlight = "Visual",
  highlight_with_out_range = {
    d = true,
    delete = true,
    m = true,
    move = true,
    y = true,
    yank = true,
    c = true,
    change = true,
    j = true,
    join = true,
    ["<"] = true,
    [">"] = true,
    s = true,
    subsititue = true,
    sno = true,
    snomagic = true,
    sm = true,
    smagic = true,
    ret = true,
    retab = true,
    t = true,
    co = true,
    copy = true,
    ce = true,
    center = true,
    ri = true,
    right = true,
    le = true,
    left = true,
    sor = true,
    sort = true,
  },
}

M.repo = {
  M.id,
  opts = M.opts,
  enabled = false,
  event = "CmdlineEnter",
  dependencies = M.dependencies,
}

return M
