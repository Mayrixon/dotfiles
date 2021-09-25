-- TODO: check function sys_init()
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'
local fn = vim.fn

local function packer_init()
  local install_path = fn.stdpath 'data' .. '/site/pack/packer/opt/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({
      'git', 'clone', '--depth', '1',
      'https://github.com/wbthomason/packer.nvim', install_path
    })
  end
  vim.cmd [[packadd packer.nvim]]
  vim.cmd [[
    augroup packer_user_config
      autocmd!
      autocmd BufWritePost plugins.lua source <afile> | PackerCompile
    augroup end
  ]]
end

-- local function sys_init()
--   -- Performance
--   -- require 'impatient'
-- end

-------------------------------- Start loading ---------------------------------

packer_init()

-- sys_init()

require('defaults').setup()

require('keymappings').setup()

-- BUG: Solve the problem of open file dump. Neovim would crash if open a file
-- in the terminal with plugins.
require('plugins').setup()

require('settings').setup()

require('config.lsp').setup()

-- require('config.dap').setup()

--------------------------------- End loading ----------------------------------
