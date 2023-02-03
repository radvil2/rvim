-- @desc: hex colorizing
local M = {}

M.repo = {
	"norcalli/nvim-colorizer.lua",
	event = "BufReadPre",
	config = function()
		local colorizer = Call("colorizer")
		if not colorizer then
			vim.notify("colorizer not installed!", vim.log.levels.WARN)
			return
		end
		colorizer.setup()
		Log("/usr/theme/syntax/colorizer.lua", "LOADED")
	end,
}

return M
