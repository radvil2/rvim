---@desc: syntax tree hi, hirarchy, etc, etc, ...
local M = {}

M.id = "nvim-treesitter/nvim-treesitter"

M.dependencies = {
	"nvim-treesitter/nvim-treesitter-textobjects", --TODO: check for dups
	"JoosepAlviste/nvim-ts-context-commentstring", -- TODO: check for dups
	"nvim-treesitter/nvim-treesitter-context",
	"p00f/nvim-ts-rainbow",
	{
		"radvil2/nvim-treesitter-angular",
		branch = "jsx-parser-fix",
		ft = "typescript",
	},
}

M.keys = {
	{
		"<C-Space>",
		desc = "Increment selection",
	},
	{
		"<Bs>",
		desc = "Schrink selection",
		mode = "x",
	},
}

---@diagnostic disable-next-line: undefined-doc-name
---@type TSConfig
M.opts = {
	highlight = {
		enable = true,
	},
	indent = {
		enable = true,
	},
	rainbow = {
		enable = true,
		extended_mode = false,
		max_file_lines = 1000,
	},
	context_commentstring = {
		enable_autocmd = false,
		enable = true,
	},
	ensure_installed = {
		"bash",
		"help",
		"html",
		"javascript",
		"json",
		"lua",
		"markdown",
		"markdown_inline",
		"python",
		"query",
		"regex",
		"tsx",
		"typescript",
		"vim",
		"yaml",
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			node_incremental = "<C-Space>",
			init_selection = "<C-Space>",
			scope_incremental = "<Nop>",
			node_decremental = "<Bs>",
		},
	},
}

---@diagnostic disable-next-line: undefined-doc-name
---@param opts TSConfig
M.config = function(_, opts)
	require("nvim-treesitter.configs").setup(opts)
end

M.repo = {
	M.id,
	event = "BufReadPost",
	build = ":TSUpdate",
	config = M.config,
	version = false, -- last release is way too old and doesn't work on Windows
	keys = M.keys,
	opts = M.opts,
}

return M
