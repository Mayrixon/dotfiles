local wk = require('which-key')
-- TODO: find the way to load user defined functions.
-- local mappings = require('config.nvim.lua.keymappings.init')

wk.register({l = {name = 'VimTeX'}}, {prefix = '<localleader>', mode = 'n'})
wk.register({l = {name = 'VimTeX'}}, {prefix = '<localleader>', mode = 'v'})
