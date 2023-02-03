-- @desc: better ui icons
local M = {}

M.opts = {
	override = require("media.icons").WebDevIcons,
	default = true,
}

M.repo = {
	"nvim-tree/nvim-web-devicons",
	opts = M.opts,
	lazy = true,
}

return M
