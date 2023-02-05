local M = {}

M.custom_labels = {
	angularls = "Angular 2+",
	sumneko_lua = "Lua Dev",
	["null-ls"] = "NLS",
}

M.get_filesize = function()
	local file = vim.fn.expand("%:p")
	if file == nil or #file == 0 then
		return ""
	end
	local size = vim.fn.getfsize(file)
	if size <= 0 then
		return ""
	end
	local suffixes = { "b", "k", "m", "g" }
	local i = 1
	while size > 1024 and i < #suffixes do
		size = size / 1024
		i = i + 1
	end
	local format = i == 1 and "%d%s" or "%.1f%s"
	local fsize = string.format(format, size, suffixes[i])
	return " 🎲 " .. fsize
end

M.get_filename = function()
	local prefix = " ⚓ "
	if GetBufOpt("mod") then
		prefix = " 💋 "
	end
	return prefix .. vim.fn.expand("%:t")
end

M.get_server_names = function()
	local buffer_ft = Api.nvim_buf_get_option(0, "filetype")
	local active_clients = vim.lsp.get_active_clients()
	if next(active_clients) ~= nil then
		for _, client in ipairs(active_clients) do
			local file_type = client.config.filetypes
			if file_type and vim.fn.index(file_type, buffer_ft) ~= -1 then
				return M.custom_labels[client.name] or client.name
			end
		end
	end
	return "No Lsp attached"
end

Warn("/usr/ui/lualine/utils.lua", "SHOULD NOT LOGGED!")
return M
