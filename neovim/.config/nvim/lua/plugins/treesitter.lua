return {
  --------------------- Modified LazyVim's plugin settings ---------------------
  {
    "nvim-treesitter",
    opts = {
      -- Disable for large files
      disable = function(lang, buf)
        local max_filesize = 1024 * 1024 -- 1 MiB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
          return true
        end
      end,
    },
  },
  ------------------------------ End modification ------------------------------
}
