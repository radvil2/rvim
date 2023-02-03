-- @desc: search/replace in multiple files
local M = {}

M.id = "windwp/nvim-spectre"

M.keys = {
	{
		"<Leader>sr",
		function()
			require("spectre").open()
		end,
		desc = "Replace in files (Spectre)",
	},
}

M.repo = { M.id, keys = M.keys }

return M
