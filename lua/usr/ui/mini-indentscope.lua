-- @desc: active indent guide and indent text objects
local M = {}

M.opts = {
	symbol = "│",
	options = {
		try_as_border = true,
	},
}

M.repo = {
	"echasnovski/mini.indentscope",
	event = "BufReadPre",
	version = false, -- wait till new 0.7.0 release to put it back on semver
	opts = M.opts,
	config = function(_, opts)
		vim.api.nvim_create_autocmd("FileType", {
			pattern = {
				"dashboard",
				"nvim-tree",
				"neo-tree",
				"Trouble",
				"alpha",
				"mason",
				"help",
				"lazy",
			},
			callback = function()
				vim.b.miniindentscope_disable = true
			end,
		})
		require("mini.indentscope").setup(opts)
	end,
}

return M
