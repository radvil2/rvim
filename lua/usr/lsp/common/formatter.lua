local util = require("lazy.core.util")

local M = {}

M.autoformat = true

function M.toggle()
	M.autoformat = not M.autoformat
	local opts = { title = "Format" }
	if M.autoformat then
		util.info("Enabled format on save", opts)
	else
		util.warn("Disabled format on save", opts)
	end
end

function M.format()
	local buf = Api.nvim_get_current_buf()
	local ft = vim.bo[buf].filetype
	local have_nls = #require("null-ls.sources").get_available(ft, "NULL_LS_FORMATTING") > 0

	vim.lsp.buf.format(vim.tbl_deep_extend("force", {
		bufnr = buf,
		filter = function(client)
			if have_nls then
				return client.name == "null-ls"
			end
			return client.name ~= "null-ls"
		end,
	}, require("rvim.util").opts("nvim-lspconfig").format or {}))
end

function M.on_attach(client, buf)
	if client.supports_method("textDocument/formatting") then
		CreateAutoCmd("BufWritePre", {
			group = Api.nvim_create_augroup("LspFormat." .. buf, {}),
			buffer = buf,
			callback = function()
				if M.autoformat then
					M.format()
				end
			end,
		})
	end
end

return M
