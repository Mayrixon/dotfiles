-- INFO: there is a new function vim.keymap.set() provided in neovim v0.7 which could substitute vim.api.nvim_set_keymap() and vim.api.nvim_buf_set_keymap().
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local keymaps = require("keymaps")

-- Map non-leader keymaps without plugin which-key.
local non_leader_keys = keymaps.non_leader_keys
for mode, mode_keymaps in pairs(non_leader_keys.mappings) do
  mode = keymaps.opts.mode_adapters[mode] and keymaps.opts.mode_adapters[mode] or mode
  for key, mapping in pairs(mode_keymaps) do
    local opts = keymaps.opts.generic_opts[mode] and keymaps.opts.generic_opts[mode] or keymaps.opts.fallback_opts
    if type(mapping) == "table" then
      opts = mapping[2]
      mapping = mapping[1]
    end
    vim.api.nvim_set_keymap(mode, key, mapping, opts)
  end
end

-- Requiring plugin which-key.
local wk_ok, wk = pcall(require, "which-key")
if wk_ok then
  wk.setup({
    plugins = { registers = false },
    -- operators = keymaps.non_leader_keys.wk_operators,
    key_labels = {
      ["<space>"] = "<Space>",
      ["<cr>"] = "<CR>",
      ["<tab>"] = "<Tab>",
    },
  })

  -- Map leader keymaps.
  local leader_keys = keymaps.leader_keys
  wk.register(leader_keys.normal, keymaps.get_wk_opts(keymaps.opts.leader.normal, "<leader>"))
  wk.register(leader_keys.visual, keymaps.get_wk_opts(keymaps.opts.leader.visual, "<leader>"))

  -- Map local leader keymaps.
  local localleader_keys = keymaps.localleader_keys
  wk.register(localleader_keys.normal, keymaps.get_wk_opts(keymaps.opts.leader.normal, "<localleader>"))
  wk.register(localleader_keys.visual, keymaps.get_wk_opts(keymaps.opts.leader.visual, "<localleader>"))

  -- Add key hints.
  wk.register(non_leader_keys.hints)
else
  print("Missing which-key.")
  return
end
