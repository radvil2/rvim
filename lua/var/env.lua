local M = {}

M.devmode = false
M.diagnostic_enabled = true

M.path = {
  home = os.getenv("HOME"),
  cache = os.getenv("HOME") .. "/.cache/nvim",
  data = os.getenv("HOME") .. "/.local/share/nvim",
  config = os.getenv("HOME") .. "/.config/nvim",
}

M.user = {
  name = "Radvil Laode",
  email = "radvil.developer@gmail.com",
  github = "https://github.com/radvil",
  facebook = "https://facebook.com/radvilardian",
}

M.g = {
  mapleader = " ",
  maplocalleader = " ",
}

M.theme = {
  colorscheme = "catppuccin",
  colorvariant = "mocha",
  transparentbg = false,
  darkmode = true,
  icons = {},
}

-- @deprecated
M.session_manager = {
  enable = true,
  commands = {
    save = "SSave",
    load = "SLoad",
    close = "SClose",
    delete = "SDelete",
    show = "SShow",
    list = "SList",
    migrate = "SMigrate",
  },
}

M.editor = {
  bufferline = {
    enable = true,
    style = "thin",
    show_indicators = true,
    show_buffer_close = false,
    keymaps = {
      n = {
        ["<A-b>"] = "<Cmd>BufferLinePick<CR>",
        ["<A-[>"] = "<Cmd>BufferLineMovePrev<CR>",
        ["<A-]>"] = "<Cmd>BufferLineMoveNext<CR>",
        ["<A-,>"] = "<Cmd>BufferLineCyclePrev<CR>",
        ["<A-.>"] = "<Cmd>BufferLineCycleNext<CR>",
        ["<Leader>P"] = "<Cmd>BufferLineTogglePin<CR>",
        ["<A-1>"] = "<Cmd>BufferLineGoToBuffer 1<CR>",
        ["<A-2>"] = "<Cmd>BufferLineGoToBuffer 2<CR>",
        ["<A-3>"] = "<Cmd>BufferLineGoToBuffer 3<CR>",
        ["<A-4>"] = "<Cmd>BufferLineGoToBuffer 4<CR>",
        ["<A-5>"] = "<Cmd>BufferLineGoToBuffer 5<CR>",
      },
    },
  },
  sidebar = {
    width = 66,
    height = 36,
    style = "left",
    update_cwd = false,
    dynamic_size = false,
    fileicon_color = true,
    reload_on_save = true,
    quit_on_file_open = true,
    show_hidden_files = true,
    show_folder_arrow = false,
    show_git_indicator = true,
    show_indent_markers = false,
    show_relativenumber = false,
    show_diagnostics_icons = true,
    hightlight_opened_files = "name",
    keymaps = {
      n = {
        ["Q"] = "<CMD>NvimTreeFindFile<CR>",
        ["<R>"] = "<CMD>NvimTreeRefresh<CR>",
        ["<Leader>q"] = "<CMD>NvimTreeToggle<CR>",
        ["<Leader>`"] = "<CMD>NvimTreeCollapse<CR>",
      },
    },
  },
  statusline = {
    enable = true,
    is_global = true,
    variant = "slanted",
    disabled_filetypes = { "help", "dashboard" },
	},
	symbols_outline = {
		enable = true,
	}
}

M.finder = {
	wordjump = {
		enable = true,
		keymap = "<Leader>j",
	},
	illuminate = {
		enable = true,
	}
}

M.treesitter = {
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = 1000,
  },
  ensure_installed = {
    "bash",
    "css",
    "dockerfile",
    "go",
    "help",
    "html",
    "javascript",
    "lua",
    "markdown",
    "markdown_inline",
    "python",
    "rust",
    "scss",
    "typescript",
    "tsx",
    "vim",
  },
}

M.lsp = {
  formatonsave = false,
  saga = {
    enable = true,
    keymaps = {
      LspFinder = "gf",
      CodeAction = "g.",
      Rename = "gr",
      RenamePlus = "gR",
      PeekDefinition = "gP",
      GoToDefinition = "gd",
      ShowLineDiagnostics = "g_",
      ShowCursorDiagnostics = "g-",
      ShowBufferDiagnostics = "gx",
      DiagnosticJumpPrev = "[d",
      DiagnosticJumpNext = "]d",
      DiagnosticGotoPrevError = "[e",
      DiagnosticGotoNextError = "]e",
      HoverDoc = "gh",
      HoverDocSticky = "gH",
      IncomingCalls = "g]", -- @desc: show child method hierarchy
      OutGoingCalls = "g[", -- @desc: show parent method hierarchy
      ToggleSymbolOutlinesMap = "gM",
      ToggleFloatingTerminal = "gT",
    },
		opts = {}
  },
  servers = {
    "cssls",
    "jsonls",
    "tsserver",
    "emmet_ls",
    "angularls",
    "rust_analyzer",
  },
  kind_icons = {
    Package = "  ",
    String = "  ",
    Number = "  ",
    Boolean = "  ",
    Key = "  ",
    Null = "  ",
    Array = "  ",
    Object = " ",
    Text = " ",
    Method = " ",
    Function = " ",
    Constructor = " ",
    Field = " ",
    Variable = " ",
    Class = " ",
    Interface = " ",
    Module = "硫 ",
    Namespace = " ",
    Property = " ",
    Unit = " ",
    Value = " ",
    Enum = " ",
    Keyword = "ﱃ ",
    Snippet = " ",
    Color = " ",
    File = " ",
    Reference = "  ",
    Folder = " ",
    EnumMember = " ",
    Constant = " ",
    Struct = " ",
    Event = " ",
    Operator = " ",
    TypeParameter = "  ",
  },
}

_G.Env = M
