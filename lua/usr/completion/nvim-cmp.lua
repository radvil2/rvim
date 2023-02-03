-- @desc: auto completion
local M = {}

M.id = "hrsh7th/nvim-cmp"

M.dependencies = {
	"saadparwaiz1/cmp_luasnip",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
}

M.opts = function()
	local cmp = require("cmp")
	return {
		completion = {
			completeopt = "menu,menuone,noinsert",
		},
		snippet = {
			expand = function(args)
				require("luasnip").lsp_expand(args.body)
			end,
		},
		mapping = cmp.mapping.preset.insert({
			["<C-b>"] = cmp.mapping.scroll_docs(-4),
			["<C-f>"] = cmp.mapping.scroll_docs(4),
			["<C-Space>"] = cmp.mapping.complete({}),
			["<C-e>"] = cmp.mapping.abort(),
			-- Accept currently selected item.
			-- Set `select` to `false` to only confirm explicitly selected items.
			["<CR>"] = cmp.mapping.confirm({ select = true }),
		}),
		sources = cmp.config.sources({
			{ name = "nvim_lsp" },
			{ name = "luasnip" },
			{ name = "buffer" },
			{ name = "path" },
		}),
		formatting = {
			format = function(_, item)
				local icons = require("media.icons").KindIcons
				if icons[item.kind] then
					item.kind = icons[item.kind] .. item.kind
				end
				return item
			end,
		},
		experimental = {
			ghost_text = {
				hl_group = "LspCodeLens",
			},
		},
	}
end

M.repo = {
	M.id,
	event = "InsertEnter",
	dependencies = M.dependencies,
	version = false, -- last release is way too old
	opts = M.opts,
}

return M
