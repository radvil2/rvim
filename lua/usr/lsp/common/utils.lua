local M = {}

---@param on_attach fun(client, buffer)
---TODO: rename to on_lsp_client_attach
function M.on_attach(on_attach)
  CreateAutoCmd("LspAttach", {
    callback = function(args)
      local buffer = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      on_attach(client, buffer)
    end,
  })
end

return M
