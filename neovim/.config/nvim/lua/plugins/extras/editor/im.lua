local im_package

if vim.fn.has("mac") == 1 then
  im_package = { "ybian/smartim" }
elseif vim.fn.has("linux") == 1 then
  im_package = { "keaising/im-select.nvim", opts = {} }
end

return { im_package }
