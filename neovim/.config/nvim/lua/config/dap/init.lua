local dap_install = require('dap-install')

local adapters = require('config.dap.adapters')

local function cosmetics()
  -- nvim-dap-virtual-text. Show virtual text for current frame
  vim.g.dap_virtual_text = true

  -- nvim-dap-ui
  require('dapui').setup {}
end

local M = {}

function M.dap_update()
  for adapter, _ in pairs(adapters.adapter_settings) do
    require('dap-install.core.install').install_debugger(adapter)
  end
end

function M.setup()
  dap_install.setup({
    installation_path = vim.fn.stdpath('data') .. '/dapinstall/'
  })

  -- telescope-dap
  require('telescope').load_extension('dap')

  cosmetics()

  adapters.set_adapters()

  -- TODO: move to keymapping files.
  vim.cmd [[
    vnoremap <M-k> <Cmd>lua require("dapui").eval()<CR>
  ]]

  vim.cmd [[
    command DAPUpdate call v:lua.require'config.dap'.dap_update()
  ]]
end

return M
