return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        vtsls = {
          keys = {
            { "<Leader>co", false },
            { "<Leader>cM", false },
            { "<Leader>cu", false },
            { "<Leader>cD", false },
            { "<Leader>cV", false },
            {
              "<LocalLeader>o",
              function()
                require("vtsls").commands.organize_imports(0)
              end,
              desc = "Organize Imports",
            },
            {
              "<LocalLeader>M",
              function()
                require("vtsls").commands.add_missing_imports(0)
              end,
              desc = "Add missing imports",
            },
            {
              "<LocalLeader>u",
              function()
                require("vtsls").commands.remove_unused_imports(0)
              end,
              desc = "Remove unused imports",
            },
            {
              "<LocalLeader>D",
              function()
                require("vtsls").commands.fix_all(0)
              end,
              desc = "Fix all diagnostics",
            },
            {
              "<LocalLeader>V",
              function()
                require("vtsls").commands.select_ts_version(0)
              end,
              desc = "Select TS workspace version",
            },
          },
        },
      },
    },
  },
}
