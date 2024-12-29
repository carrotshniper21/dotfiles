-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny
lvim.plugins = {
  { "github/copilot.vim"},
  { "blazkowolf/gruber-darker.nvim" },
  { "mg979/vim-visual-multi" },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  },
  {
    "simrat39/inlay-hints.nvim",
    config = function()
      require("inlay-hints").setup()
    end,
  },
  {

    "simrat39/rust-tools.nvim",
    -- events = { "VeryLazy" },
    dependencies = "neovim/nvim-lspconfig",
    config = function()
      local ih = require("inlay-hints")
      local rust_tools = require("rust-tools")
      rust_tools.setup({
        tools = {
          on_initialized = function()
            ih.set_all()
          end,
          runnables = {
            use_telescope = true,
          },
          hover_actions = {
            max_height = function()
              return math.floor(vim.o.lines * 0.75)
            end,
            max_width = function()
              return math.floor(vim.o.columns * 0.75)
            end,
            auto_focus = true,
          },
          inlay_hints = {
            auto = false
          }
        },
        server = {
          settings = {
            ["rust-analyzer"] = {
              -- enable clippy on save
              checkOnSave = {
                command = "cargo",
              },
            },
          },
          on_attach = function(c, b)
            ih.on_attach(c, b)
          end,
        },
      })
    end,
  },
  {
    "iamcco/markdown-preview.nvim",
    config = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
  {
    "andweeb/presence.nvim",
    config = function()
      require("presence").setup()
    end,
  }


}

lvim.colorscheme = "gruber-darker"
lvim.transparent_window = false;
