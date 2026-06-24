local function is_markdown()
  return vim.bo.filetype == "markdown"
end
return {
  --------------------- Modified LazyVim's plugin settings ---------------------
  {
    "conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        markdown = function(bufnr)
          local conform = require("conform")
          local prettier = conform.get_formatter_info("prettierd", bufnr).available and "prettierd" or "prettier"

          return { "markdown-toc", prettier }
        end,
        ["markdown.mdx"] = function(bufnr)
          local conform = require("conform")
          local prettier = conform.get_formatter_info("prettierd", bufnr).available and "prettierd" or "prettier"
          return { "markdown-toc", prettier }
        end,
      },
    },
  },
  {
    "mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "marksman" })
    end,
  },

  {
    "iamcco/markdown-preview.nvim",
    keys = {
      { "<Leader>cp", false },
      {
        "<LocalLeader>p",
        ft = "markdown",
        "<Cmd>MarkdownPreviewToggle<CR>",
        desc = "Markdown Preview",
      },
    },
  },
  ------------------------------ End modification ------------------------------

  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "markdown", "markdown_inline" })
      end
    end,
  },

  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<LocalLeader>l", group = "mkdx" },
        {
          "<LocalLeader>t",
          function()
            local cmd = "typora"

            if vim.fn.executable(cmd) == 0 then
              vim.notify("Typora executable not found: " .. cmd, vim.log.levels.ERROR)
              return
            end

            local file = vim.fn.expand("%:p")
            if file == "" then
              vim.notify("No file to open in Typora", vim.log.levels.WARN)
              return
            end

            vim.cmd("write")

            local job_id = vim.fn.jobstart({ cmd, file }, { detach = true })

            if job_id <= 0 then
              vim.notify("Failed to start Typora", vim.log.levels.ERROR)
            end
          end,
          desc = "Open in Typora",
          mode = "n",
        },
      },
    },
  },
  {
    "SidOfc/mkdx",
    ft = { "markdown", "rmd" },
    config = function()
      vim.g["mkdx#settings"] = {
        highlight = { enable = 1 },
        enter = { shift = 1 },
        links = { external = { enable = 1 } },
        map = { prefix = "<localleader>l", enable = 1 },
        toc = { update_on_write = 1 },
        fold = { enable = 1 },
      }

      -- Add shortcut to add wikilinks
      vim.keymap.set("n", "<LocalLeader>lw", function()
        vim.fn["mkdx#WrapText"]("n", "[[", "]]")
      end, { desc = "Add Wiki Link to Current Word", buffer = true })
      vim.keymap.set(
        "v",
        "<LocalLeader>lw",
        ':call mkdx#WrapText("v", "[[", "]]")<CR>',
        { desc = "Add Wiki Link", buffer = true }
      )
    end,
  },
  {
    "ellisonleao/glow.nvim",
    cmd = "Glow",
    ft = "markdown",
    keys = {
      { "<LocalLeader>g", "<Cmd>Glow<CR>", desc = "Glow Preview" },
    },
    config = true,
  },
}
