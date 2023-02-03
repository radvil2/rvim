-- @desc: nice statusline
local M = {}
local env = Env.editor.statusline

M.opts = {}

if env.variant == "rainbow" then
	M.opts = require("usr.ui.lualine.rainbow")
else
	M.opts = require("usr.ui.lualine.default")
end

M.repo = {
	"nvim-lualine/lualine.nvim",
	enabled = env.enable,
	dependencies = { "arkav/lualine-lsp-progress" },
	opts = M.opts,
}

return M
