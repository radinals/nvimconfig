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
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },


  {
    "windwp/nvim-ts-autotag",
    ft = { "astro", "glimmer", "handlebars", "html", "javascript",
    "jsx", "markdown", "php", "rescript", "svelte", "tsx",
    "twig", "typescript", "vue", "xml" },
    config = function ()
      require('nvim-ts-autotag').setup({
        opts = {
          -- Defaults
          enable_close = true, -- Auto close tags
          enable_rename = true, -- Auto rename pairs of tags
          enable_close_on_slash = false -- Auto close on trailing </
        },
      })
    end
  },

  {
    "mfussenegger/nvim-dap",
    config = function ()
      local dap = require("dap")
      dap.adapters.gdb = {
        type = "executable",
        command = "gdb",
        args = { "--interpreter=dap", "--eval-command", "set print pretty on" }
      }
      dap.configurations.cpp = {
        {
          name = "Launch C/C++ Program",
          type = "gdb",         -- Matches the adapter name
          request = "launch",
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = '${workspaceFolder}',
          stopOnEntry = true,
          stopAtBeginningOfMainSubprogram = false,
          args = {},

          setupCommands = {
            {
              text = '-enable-pretty-printing',
              description = 'Enable pretty printing',
              ignoreFailures = false,
            },
          }

        },
      }
    end,
  },

  {
    "theHamsta/nvim-dap-virtual-text",
    dependencies = {
      "mfussenegger/nvim-dap",
    },
    config = function ()
      require("nvim-dap-virtual-text").setup()
    end
  },


  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio"
    },
    config =function ()
      vim.fn.sign_define('DapBreakpoint', {text='●', texthl='DapBreakpoint', linehl='', numhl=''})
      vim.fn.sign_define('DapBreakpointCondition', {text='◆', texthl='DapBreakpointCondition', linehl='', numhl=''})
      vim.fn.sign_define('DapLogPoint', {text='✎', texthl='DapLogPoint', linehl='', numhl=''})
      vim.fn.sign_define('DapStopped', {text='→', texthl='DapStopped', linehl='DapStoppedLine', numhl=''})
      local dap = require("dap")
      
      require("dapui").setup()
    end
  },

  {
    'stevearc/overseer.nvim',
    opts = {},
    config = function()
      require("overseer").setup()
    end,
  },

  {
    'Civitasv/cmake-tools.nvim',
    dependencies = { 'stevearc/overseer.nvim' },
    ft = {"cpp"},
    config = function ()
      local osys = require("cmake-tools.osys")
      require("cmake-tools").setup {
        cmake_command = "cmake", -- this is used to specify cmake command path
        ctest_command = "ctest", -- this is used to specify ctest command path
        cmake_use_preset = true,
        cmake_regenerate_on_save = true, -- auto generate when save CMakeLists.txt
        cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=1" }, -- this will be passed when invoke `CMakeGenerate`
        cmake_build_options = {}, -- this will be passed when invoke `CMakeBuild`
        -- support macro expansion:
        --       ${kit}
        --       ${kitGenerator}
        --       ${variant:xx}
        cmake_build_directory = function()
          if osys.iswin32 then
            return "out\\${variant:buildType}"
          end
          return "out/${variant:buildType}"
        end, -- this is used to specify generate directory for cmake, allows macro expansion, can be a string or a function returning the string, relative to cwd.
        cmake_soft_link_compile_commands = true, -- this will automatically make a soft link from compile commands file to project root dir
        cmake_compile_commands_from_lsp = false, -- this will automatically set compile commands file location using lsp, to use it, please set `cmake_soft_link_compile_commands` to false
        cmake_kits_path = nil, -- this is used to specify global cmake kits path, see CMakeKits for detailed usage
        cmake_variants_message = {
          short = { show = true }, -- whether to show short message
          long = { show = true, max_length = 40 }, -- whether to show long message
        },
        cmake_dap_configuration = { -- debug settings for cmake
          name = "cpp",
          type = "gdb",
          request = "launch",
          stopOnEntry = false,
          runInTerminal = true,
          console = "integratedTerminal",
        },
        cmake_executor = { -- executor to use
          name = "quickfix", -- name of the executor
          opts = {}, -- the options the executor will get, possible values depend on the executor type. See `default_opts` for possible values.
          default_opts = { -- a list of default and possible values for executors
            quickfix = {
              show = "always", -- "always", "only_on_error"
              position = "belowright", -- "vertical", "horizontal", "leftabove", "aboveleft", "rightbelow", "belowright", "topleft", "botright", use `:h vertical` for example to see help on them
              size = 10,
              encoding = "utf-8", -- if encoding is not "utf-8", it will be converted to "utf-8" using `vim.fn.iconv`
              auto_close_when_success = true, -- typically, you can use it with the "always" option; it will auto-close the quickfix buffer if the execution is successful.
            },
            toggleterm = {
              direction = "float", -- 'vertical' | 'horizontal' | 'tab' | 'float'
              close_on_exit = false, -- whether close the terminal when exit
              auto_scroll = true, -- whether auto scroll to the bottom
              singleton = true, -- single instance, autocloses the opened one, if present
            },
            overseer = {
              new_task_opts = {
                strategy = {
                  "toggleterm",
                  direction = "horizontal",
                  autos_croll = true,
                  quit_on_exit = "success"
                }
              }, -- options to pass into the `overseer.new_task` command
              on_new_task = function(task)
                require("overseer").open(
                { enter = false, direction = "right" }
                )
              end,   -- a function that gets overseer.Task when it is created, before calling `task:start`
            },
            terminal = {
              name = "Main Terminal",
              prefix_name = "[CMakeTools]: ", -- This must be included and must be unique, otherwise the terminals will not work. Do not use a simple spacebar " ", or any generic name
              split_direction = "horizontal", -- "horizontal", "vertical"
              split_size = 11,

              -- Window handling
              single_terminal_per_instance = true, -- Single viewport, multiple windows
              single_terminal_per_tab = true, -- Single viewport per tab
              keep_terminal_static_location = true, -- Static location of the viewport if avialable
              auto_resize = true, -- Resize the terminal if it already exists

              -- Running Tasks
              start_insert = false, -- If you want to enter terminal with :startinsert upon using :CMakeRun
              focus = false, -- Focus on terminal when cmake task is launched.
              do_not_add_newline = false, -- Do not hit enter on the command inserted when using :CMakeRun, allowing a chance to review or modify the command before hitting enter.
            }, -- terminal executor uses the values in cmake_terminal
          },
        },
        cmake_runner = { -- runner to use
          name = "terminal", -- name of the runner
          opts = {}, -- the options the runner will get, possible values depend on the runner type. See `default_opts` for possible values.
          default_opts = { -- a list of default and possible values for runners
            quickfix = {
              show = "always", -- "always", "only_on_error"
              position = "belowright", -- "bottom", "top"
              size = 10,
              encoding = "utf-8",
              auto_close_when_success = true, -- typically, you can use it with the "always" option; it will auto-close the quickfix buffer if the execution is successful.
            },
            toggleterm = {
              direction = "float", -- 'vertical' | 'horizontal' | 'tab' | 'float'
              close_on_exit = false, -- whether close the terminal when exit
              auto_scroll = true, -- whether auto scroll to the bottom
              singleton = true, -- single instance, autocloses the opened one, if present
            },
            overseer = {
              new_task_opts = {
                strategy = {
                  "toggleterm",
                  direction = "horizontal",
                  autos_croll = true,
                  quit_on_exit = "success"
                }
              }, -- options to pass into the `overseer.new_task` command
              on_new_task = function(task)
              end,   -- a function that gets overseer.Task when it is created, before calling `task:start`
            },
            terminal = {
              name = "Main Terminal",
              prefix_name = "[CMakeTools]: ", -- This must be included and must be unique, otherwise the terminals will not work. Do not use a simple spacebar " ", or any generic name
              split_direction = "horizontal", -- "horizontal", "vertical"
              split_size = 11,

              -- Window handling
              single_terminal_per_instance = true, -- Single viewport, multiple windows
              single_terminal_per_tab = true, -- Single viewport per tab
              keep_terminal_static_location = true, -- Static location of the viewport if avialable
              auto_resize = true, -- Resize the terminal if it already exists

              -- Running Tasks
              start_insert = false, -- If you want to enter terminal with :startinsert upon using :CMakeRun
              focus = false, -- Focus on terminal when cmake task is launched.
              do_not_add_newline = false, -- Do not hit enter on the command inserted when using :CMakeRun, allowing a chance to review or modify the command before hitting enter.
            },
          },
        },
        cmake_notifications = {
          runner = { enabled = true },
          executor = { enabled = true },
          spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }, -- icons used for progress display
          refresh_rate_ms = 100, -- how often to iterate icons
        },
        cmake_virtual_text_support = true, -- Show the target related to current file using virtual text (at right corner)
      }

    end
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
    dependencies = {
      'nvim-lua/plenary.nvim',
      "desdic/telescope-rooter.nvim"
    },
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
