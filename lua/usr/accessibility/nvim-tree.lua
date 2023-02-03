local M = {}
local env = Env.editor.sidebar
local icons = require("media.icons")

M.keys = {
	{
		"<Leader>`",
		"<CMD>NvimTreeCollapse<CR>",
		desc = "Collapse Tree",
	},
	{
		"<Leader>e",
		"<CMD>NvimTreeToggle<CR>",
		desc = "Toggle Tree",
	},
	{
		"<Leader>`",
		"<CMD>NvimTreeRefresh<CR>",
		desc = "Refresh Tree",
	},
}

M.opts = {
	hijack_unnamed_buffer_when_opening = true,
	auto_reload_on_write = env.reload_on_save,
	update_cwd = env.update_cwd,
	open_on_setup_file = false,
	open_on_setup = false,
	hijack_cursor = true,
	disable_netrw = true,
	hijack_netrw = true,
	open_on_tab = false,
	sort_by = "name",
	hijack_directories = {
		auto_open = true,
		enable = true,
	},
	diagnostics = {
		enable = env.show_diagnostics_icons,
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
		ignore_list = {},
		enable = true,
	},
	git = {
		enable = env.show_git_indicator,
		ignore = false,
		timeout = 200,
	},
	view = {
		relativenumber = env.show_relativenumber,
		preserve_window_proportions = false,
		adaptive_size = env.dynamic_size,
		hide_root_folder = true,
		-- height = env.height,
		signcolumn = "yes",
		width = env.width,
		side = env.style,
		number = false,
		float = {
			enable = Env.editor.sidebar.style == "float",
			open_win_config = {
				height = env.height,
				relative = "editor",
				border = "single",
				width = env.width,
				row = 1,
				col = 1,
			},
		},
	},
	renderer = {
		highlight_opened_files = env.hightlight_opened_files,
		highlight_git = env.show_git_indicator,
		root_folder_modifier = ":t",
		indent_markers = {
			enable = env.show_indent_markers,
			icons = {
				corner = "└",
				edge = "│ ",
				none = "  ",
			},
		},
		icons = {
			symlink_arrow = " " .. icons.Common.SymlinkArrow .. " ",
			webdev_colors = env.fileicon_color,
			padding = " ",
			show = {
				folder_arrow = env.show_folder_arrow,
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
		dotfiles = env.show_hidden_files,
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
			quit_on_open = env.quit_on_file_open,
			resize_window = false,
			window_picker = {
				chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
				enable = true,
				exclude = {
					filetype = {
						"qf",
						"diff",
						"notify",
						"packer",
						"fugitive",
						"fugitiveblame",
					},
					buftype = {
						"terminal",
						"nofile",
						"help",
					},
				},
			},
		},
	},
	log = {
		truncate = false,
		enable = false,
		types = {
			diagnostics = false,
			copy_paste = false,
			profile = false,
			config = false,
			all = false,
			git = false,
		},
	},
	on_attach = function(bufnr)
		Map("n", "H", "^", { buffer = bufnr })
		Map("n", "J", "5j", { buffer = bufnr })
		Map("n", "K", "5k", { buffer = bufnr })
		Map("n", "L", "g_", { buffer = bufnr })
		Map("n", "q", "<Cmd>close<Cr>", { buffer = bufnr })

		Map("n", "sh", function()
			require("nvim-tree.config").nvim_tree_callback("split")
		end, { buffer = bufnr })

		Map("n", "sv", function()
			require("nvim-tree.config").nvim_tree_callback("vsplit")
		end, { buffer = bufnr })
	end,
}

M.repo = {
	"kyazdani42/nvim-tree.lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	keys = M.keys,
	opts = M.opts,
}

return M
