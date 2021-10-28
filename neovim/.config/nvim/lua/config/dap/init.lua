-- TODO: separate this file.
-- TODO: check python adapter.
local dap_install = require('dap-install')

local adaptors = {python = {}, codelldb = {}}

local function cosmetics()
  -- nvim-dap-virtual-text. Show virtual text for current frame
  vim.g.dap_virtual_text = true

  -- nvim-dap-ui
  require('dapui').setup {}
end

local function setup_adaptors()
  dap_install.setup({
    installation_path = vim.fn.stdpath('data') .. '/dapinstall/'
  })
  for adaptor, setting in pairs(adaptors) do
    dap_install.config(adaptor, setting)
  end

  -- one-small-step-for-vimkind
  local dap = require 'dap'
  dap.configurations.lua = {
    {
      type = 'nlua',
      request = 'attach',
      name = 'Attach to running Neovim instance',
      host = function()
        local value = vim.fn.input('Host [127.0.0.1]: ')
        if value ~= '' then return value end
        return '127.0.0.1'
      end,
      port = function()
        local val = tonumber(vim.fn.input('Port: '))
        assert(val, 'Please provide a port number')
        return val
      end
    }
  }

  dap.adapters.nlua = function(callback, config)
    callback({type = 'server', host = config.host, port = config.port})
  end
end

local M = {}

function M.dap_update()
  for adaptor, _ in pairs(adaptors) do
    require('dap-install.core.install').install_debugger(adaptor)
  end
end

function M.setup()

  cosmetics()

  setup_adaptors()

  -- telescope-dap
  require('telescope').load_extension('dap')

  vim.cmd [[
    command DAPUpdate call v:lua.require'config.dap'.dap_update()
  ]]
end

return M
