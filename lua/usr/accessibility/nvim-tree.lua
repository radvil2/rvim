local M = {}
local icons = require("media.icons")

M.keys = {
  {
    "<Leader>e",
    "<Cmd>NvimTreeToggle<Cr>",
    desc = "Toggle Explorer",
  },
  {
    "<Leader>`",
    "<CMD>NvimTreeCollapse<CR>",
    desc = "Collapse Explorer",
  },
}

M.opts = {
  hijack_unnamed_buffer_when_opening = true,
  auto_reload_on_write = true,
  hijack_cursor = true,
  sort_by = "name",
  hijack_directories = {
    auto_open = true,
    enable = true,
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
    icons = {
      warning = icons.Diagnostics.Warn,
      error = icons.Diagnostics.Error,
      hint = icons.Diagnostics.Hint,
      info = icons.Diagnostics.Info,
    },
  },
  update_focused_file = {
    update_cwd = false,
    enable = true,
  },
  git = {
    ignore = false,
    timeout = 200,
    enable = true,
  },
  view = {
    relativenumber = false,
    hide_root_folder = true,
    signcolumn = "yes",
    number = false,
    side = "left",
    width = 66,
  },
  renderer = {
    highlight_opened_files = "name",
    root_folder_modifier = ":t",
    indent_markers = {
      enable = false,
      icons = {
        corner = "└",
        edge = "│ ",
        none = "  ",
      },
    },
    icons = {
      symlink_arrow = " " .. icons.Common.SymlinkArrow .. " ",
      padding = " ",
      show = {
        folder_arrow = false,
        folder = true,
        file = true,
        git = true,
      },
      glyphs = {
        symlink = icons.Common.Symlink,
        default = icons.Common.File,
        folder = {
          symlink_open = icons.Folder.SymlinkOpened,
          arrow_closed = icons.Folder.ArrowClosed,
          arrow_open = icons.Folder.ArrowOpened,
          empty_open = icons.Folder.EmptyOpened,
          default = icons.Folder.Default,
          symlink = icons.Folder.Symlink,
          open = icons.Folder.Opened,
          empty = icons.Folder.Empty,
        },
        git = {
          untracked = icons.Git.Untracked,
          unstaged = icons.Git.Unstaged,
          unmerged = icons.Git.Unmerged,
          renamed = icons.Git.Renamed,
          deleted = icons.Git.Deleted,
          ignored = icons.Git.Ignored,
          staged = icons.Git.Staged,
        },
      },
    },
    special_files = {
      "Cargo.toml",
      "README.md",
      "readme.md",
      "Makefile",
    },
  },
  filters = {
    custom = {
      "node_modules",
      "\\.cache",
      "dist",
    },
    dotfiles = true,
  },
  trash = {
    require_confirm = true,
    cmd = "trash",
  },
  actions = {
    use_system_clipboard = true,
    change_dir = {
      restrict_above_cwd = false,
      global = false,
      enable = true,
    },
    open_file = {
      quit_on_open = true,
      resize_window = false,
    },
  },
  on_attach = function(buffer)
    local tree_cb = require("nvim-tree.config").nvim_tree_callback
    local opts = { buffer = buffer }
    Map("n", "R", "<CMD>NvimTreeRefresh<CR>", opts)
    Map("n", "sv", tree_cb("vsplit"), opts)
    Map("n", "sh", tree_cb("split"), opts)
    Map("n", "q", "<Cmd>close<Cr>", opts)
    Map("n", "J", "5j", opts)
    Map("n", "L", "g_", opts)
  end,
}

M.repo = {
  "nvim-tree/nvim-tree.lua",
  enabled = false,
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  cmd = "NvimTree",
  opts = M.opts,
  keys = M.keys,
}

return M
