local M = {}

local colors = {
  bg = "#1A1B23",
  fg = "#ffffff",
  blue = "#51afef",
  cyan = "#8AD3C8",
  darkblue = "#081633",
  green = "#6DD390",
  magenta = "#c678dd",
  orange = "#FF8800",
  red = "#ec5f67",
  pink = "#E76EB1",
  violet = "#a9a1e1",
  yellow = "#ECBE7B",
}

M.palette = colors

M.vim_mode = {
  n = colors.red,
  i = colors.green,
  v = colors.orange,
  [""] = colors.orange,
  V = colors.orange,
  c = colors.magenta,
  no = colors.red,
  s = colors.pink,
  S = colors.pink,
  [""] = colors.pink,
  ic = colors.cyan,
  R = colors.violet,
  Rv = colors.violet,
  cv = colors.blue,
  ce = colors.blue,
  r = colors.magenta,
  rm = colors.magenta,
  ["r?"] = colors.magenta,
  ["!"] = colors.red,
  t = colors.red,
}

return M
