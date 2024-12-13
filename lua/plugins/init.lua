local getConfig = function(conf) return require("plugins/config/" .. conf) end
return {

   {
    "goolord/alpha-nvim",
    -- dependencies = { 'echasnovski/mini.icons' },
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local startify = require("alpha.themes.startify")
      -- available: devicons, mini, default is mini
      -- if provider not loaded and enabled is true, it will try to use another provider
      startify.file_icons.provider = "devicons"
      require("alpha").setup(
        startify.config
      )
    end,
  },

  {
    "NvChad/nvim-colorizer.lua",
    event = "BufReadPre",
    ft = {"css", "javascript", "html"},
    config = function ()
      require("colorizer").setup()
    end
  },

  {
    "eddyekofo94/gruvbox-flat.nvim",
    config = function()
      getConfig("conf_gruvbox")
    end
  },

  {
    'junnplus/lsp-setup.nvim',
    dependencies = {
      'neovim/nvim-lspconfig',
      'williamboman/mason.nvim',           -- optional
      'williamboman/mason-lspconfig.nvim', -- optional
    },
    config = function()
      require('lsp-setup').setup(getConfig("conf_lsp"))
    end
  },

  { "CRAG666/code_runner.nvim", config = true },

  {
    "stevearc/conform.nvim",
    config = function()
      require('conform').setup(getConfig("conf_conform"))
    end
  },

  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("bufferline").setup(getConfig("conf_bufferline"))
    end
  },

  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end

  },

  {
    "roobert/action-hints.nvim",
    config = function()
      require("action-hints").setup({
        use_virtual_text = true,

      })
    end,
  },


  {
      "rachartier/tiny-code-action.nvim",
    dependencies = {
        {"nvim-lua/plenary.nvim"},
        {"nvim-telescope/telescope.nvim"},
    },
    event = "LspAttach",
    config = function()
        require('tiny-code-action').setup()
    end
  },

  {
    'windwp/nvim-autopairs',
    config = function ()
      require("nvim-autopairs").setup({
        check_ts = true,
      })
    end
  },

  {
    'ray-x/lsp_signature.nvim',
    config = function ()
      require('lsp_signature').on_attach({
        bind = true,
        handler_opts = {border = 'single'}
      })
    end
  },

  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      'doxnit/cmp-luasnip-choice',
      'hrsh7th/cmp-nvim-lsp',      -- LSP source for nvim-cmp
      'hrsh7th/cmp-buffer',        -- Buffer source for nvim-cmp
      'hrsh7th/cmp-path',          -- Path source for nvim-cmp
      'saadparwaiz1/cmp_luasnip',  -- LuaSnip source for nvim-cmp
    },
    config = function()
      require("cmp").setup(getConfig("conf_cmp"))
    end
  },

  {
    "hinell/lsp-timeout.nvim",
    dependencies={ "neovim/nvim-lspconfig" }
  },

  {
    "Wansmer/symbol-usage.nvim",
    event = 'BufReadPre',
    config = function()
      require('symbol-usage').setup(getConfig("conf_symbol_usage"))
    end
  },

  {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = true
  },

  {
    "terrortylor/nvim-comment",
    config = function()
      require("nvim_comment").setup(getConfig("conf_comment"))
    end
  },

  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require("nvim-treesitter.configs").setup(getConfig("conf_treesitter"))
    end
  },

  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require("telescope").setup(getConfig("conf_telescope"))
    end
  },

  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
  }

}
