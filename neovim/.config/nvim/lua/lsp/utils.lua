local wk_ok, wk = pcall(require, "which-key")
if not wk_ok then
  print("Missing which-key.")
  return
end

local keymaps = require("keymaps")

local M = {}

function M.set_buffer_options(bufnr)
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
end

function M.set_lsp_keymaps(client, bufnr)
  -- Set non-leader keymaps
  for key, binding in pairs(keymaps.lsp_keys.non_leader.normal) do
    vim.api.nvim_buf_set_keymap(bufnr, "n", key, binding, keymaps.opts.generic_opts.normal_mode)
  end

  -- Set leader keymaps
  wk.register(keymaps.lsp_keys.leader.normal, keymaps.get_opts(keymaps.opts.leader.normal, "<leader>", bufnr))
  wk.register(keymaps.lsp_keys.leader.visual, keymaps.get_opts(keymaps.opts.leader.visual, "<leader>", bufnr))

  -- Set keymaps according to LSP server capabilities
  for _, m in pairs(keymaps.lsp_keys.capability_mappings) do
    local capability, key, prefix, mode = unpack(m)
    if client.resolved_capabilities[capability] then
      wk.register(key, keymaps.get_opts(keymaps.opts.leader[mode], prefix, bufnr))
    end
  end

  -- Set key hints
  wk.register(keymaps.lsp_keys.hints, { buffer = bufnr })
end

return M
