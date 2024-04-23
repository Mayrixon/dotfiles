local im_package

if vim.fn.has("mac") then
  im_package = { "ybian/smartim" }
else
  im_package = { "keaising/im-select.nvim", opts = {} }
end

return { im_package }
