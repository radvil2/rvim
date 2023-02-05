local M = {}

M.id = "ThePrimeagen/harpoon"

M.api = {
  mark_current = function()
    require("harpoon.mark").add_file()
    vim.notify("📌 Document marked")
  end,

  quick_menu = function()
    require("harpoon.ui").toggle_quick_menu()
  end,
}

M.keys = {
  {
    "<Leader>'",
    M.api.mark_current,
    desc = "Mark to harpoon menu",
  },
  {
    '<Leader>"',
    M.api.quick_menu,
    desc = "Harpoon quick menu",
  },
}

M.opts = {
  mark_branch = false,
  save_on_change = false,
  save_on_toggle = false,
  enter_on_sendcmd = false,
  tmux_autoclose_windows = false,
  excluded_filetypes = { "harpoon" },
  menu = {
    width = Api.nvim_win_get_width(0) - 13,
  },
}

M.repo = {
  M.id,
  keys = M.keys,
  opts = M.opts,
  event = "BufReadPre",
}

return M
