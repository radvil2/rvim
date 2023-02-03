--@desc: easily jump to any location and enhanced f/t motions for Leap
local M = {}

M.id = "ggandor/leap.nvim"

M.dependencies = {
	{
		"ggandor/flit.nvim",
		opts = { labeled_modes = "nv" },
	},
}

M.config = function(_, opts)
	for k, v in pairs(opts) do
		require("leap").opts[k] = v
	end
	require("leap").add_default_mappings(true)
end

M.repo = {
	M.id,
	event = "VeryLazy",
	dependencies = M.dependencies,
	config = M.config,
}

return M
