local M = {}

M.id = "glepnir/dashboard-nvim"

M.opts = {
  theme = "doom",
  hide = {
    statusline = true,
    tabline = false,
    winbar = false,
  },
  config = {
    header = require("media.ascii-arts").Default,
    footer = {
      "                       ",
      "                       ",
      "🔥 WELCOME BACK FUCKER!",
    },
    center = {
      {
        key = "M",
        icon = "  ",
        desc = "Manage Plugins                           ",
        desc_hi = "DashboardCenter",
        action = "Lazy",
      },
      {
        key = "O",
        icon = "📁 ",
        desc = "Open recent files                        ",
        desc_hi = "DashboardCenter",
        action = "Telescope oldfiles",
      },
      {
        key = "F",
        icon = "🔎 ",
        desc = "Find files                               ",
        desc_hi = "DashboardCenter",
        action = "Telescope find_files",
      },
      {
        key = "T",
        icon = "📌 ",
        desc = "List all todo(s)                         ",
        desc_hi = "DashboardCenter",
        action = "TodoTelescope",
      },
      {
        key = ".",
        icon = "🔧 ",
        desc = "Open dotfiles                            ",
        desc_hi = "DashboardCenter",
        action = 'lua require("utils").telescope("files", { cwd = $HOME/.config/nvim })',
      },
      {
        key = "R",
        icon = "👻 ",
        desc = "Restore session                          ",
        desc_hi = "DashboardCenter",
        action = 'lua require("usr.misc.persistence").api.restore_session()',
      },
    },
  },
}

M.repo = {
  M.id,
  event = "VimEnter",
  opts = M.opts,
}

return M
