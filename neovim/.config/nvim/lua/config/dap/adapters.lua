local dap = require 'dap'
local dap_install = require('dap-install')

local adapter_settings = {python = {}, codelldb = {}}

local M = {}

function M.set_adapters()
  for adapter, setting in pairs(adapter_settings) do
    dap_install.config(adapter, setting)
  end

  -- one-small-step-for-vimkind
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

return M
