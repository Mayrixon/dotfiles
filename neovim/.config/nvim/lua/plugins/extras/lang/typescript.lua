return {
  --------------------- Modified LazyVim's plugin settings ---------------------
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
              LazyVim.lsp.action["source.organizeImports"],
              desc = "Organize Imports",
            },
            {
              "<LocalLeader>M",
              LazyVim.lsp.action["source.addMissingImports.ts"],
              desc = "Add missing imports",
            },
            {
              "<LocalLeader>u",
              LazyVim.lsp.action["source.removeUnused.ts"],
              desc = "Remove unused imports",
            },
            {
              "<LocalLeader>D",
              LazyVim.lsp.action["source.fixAll.ts"],
              desc = "Fix all diagnostics",
            },
            {
              "<LocalLeader>V",
              function()
                LazyVim.lsp.execute({ command = "typescript.selectTypeScriptVersion" })
              end,
              desc = "Select TS workspace version",
            },
          },
        },
      },
    },
  },
  ------------------------------ End modification ------------------------------
}
