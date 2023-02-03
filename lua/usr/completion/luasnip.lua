local M = {}

M.id = "L3MON4D3/LuaSnip"

M.dependencies = {
	"rafamadriz/friendly-snippets",
	config = function()
		require("luasnip.loaders.from_vscode").lazy_load()
	end,
}

M.opts = {
	delete_check_events = "TextChanged",
	history = true,
}

M.keys = {
	{
		"<Tab>",
		function()
			return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<Tab>"
		end,
		silent = true,
		expr = true,
		mode = "i",
	},
	{
		"<Tab>",
		function()
			require("luasnip").jump(1)
		end,
		mode = "s",
	},
	{
		"<S-Tab>",
		function()
			require("luasnip").jump(-1)
		end,
		mode = { "i", "s" },
	},
}

M.repo = {
	M.id,
	opts = M.opts,
	keys = M.keys,
	dependencies = M.dependencies,
}

return M
