local overrides = require "custom.configs.overrides"
local dapConfig = require "custom.configs.dap"
local telekastenConfig = require "custom.configs.telekasten"
---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },
  {
    "Civitasv/cmake-tools.nvim",
    opts = {
      cmake_dap_configuration = { -- debug settings for cmake
        name = "cpp",
        type = "codelldb",
        request = "launch",
        stopOnEntry = false,
        runInTerminal = true,
        console = "integratedTerminal",
      },
      cmake_executor = { -- executor to use
        name = "terminal", -- name of the executor
        opts = {}, -- the options the executor will get, possible values depend on the executor type. See `default_opts` for possible values.
        default_opts = { -- a list of default and possible values for executors
          quickfix = {
            show = "always", -- "always", "only_on_error"
            position = "belowright", -- "vertical", "horizontal", "leftabove", "aboveleft", "rightbelow", "belowright", "topleft", "botright", use `:h vertical` for example to see help on them
            size = 10,
            encoding = "utf-8", -- if encoding is not "utf-8", it will be converted to "utf-8" using `vim.fn.iconv`
            auto_close_when_success = true, -- typically, you can use it with the "always" option; it will auto-close the quickfix buffer if the execution is successful.
          },
          -- overseer = {
          --     new_task_opts = {
          --         strategy = {
          --             "toggleterm",
          --             direction = "horizontal",
          --             autos_croll = true,
          --             quit_on_exit = "success",
          --         },
          --     }, -- options to pass into the `overseer.new_task` command
          --     on_new_task = function(task)
          --         require("overseer").open { enter = false, direction = "right" }
          --     end, -- a function that gets overseer.Task when it is created, before calling `task:start`
          -- },
          terminal = {
            name = "Main Terminal",
            prefix_name = "[CMakeTools]: ", -- This must be included and must be unique, otherwise the terminals will not work. Do not use a simple spacebar " ", or any generic name
            split_direction = "horizontal", -- "horizontal", "vertical"
            split_size = 11,

            -- Window handling
            single_terminal_per_instance = true, -- Single viewport, multiple windows
            single_terminal_per_tab = true, -- Single viewport per tab
            keep_terminal_static_location = true, -- Static location of the viewport if avialable

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
          -- overseer = {
          --     new_task_opts = {
          --         strategy = {
          --             "toggleterm",
          --             direction = "horizontal",
          --             autos_croll = true,
          --             quit_on_exit = "success",
          --         },
          --     },                    -- options to pass into the `overseer.new_task` command
          --     on_new_task = function(task) end, -- a function that gets overseer.Task when it is created, before calling `task:start`
          -- },
          terminal = {
            name = "Main Terminal",
            prefix_name = "[CMakeTools]: ", -- This must be included and must be unique, otherwise the terminals will not work. Do not use a simple spacebar " ", or any generic name
            split_direction = "horizontal", -- "horizontal", "vertical"
            split_size = 11,

            -- Window handling
            single_terminal_per_instance = true, -- Single viewport, multiple windows
            single_terminal_per_tab = true, -- Single viewport per tab
            keep_terminal_static_location = true, -- Static location of the viewport if avialable

            -- Running Tasks
            start_insert = false, -- If you want to enter terminal with :startinsert upon using :CMakeRun
            focus = false, -- Focus on terminal when cmake task is launched.
            do_not_add_newline = false, -- Do not hit enter on the command inserted when using :CMakeRun, allowing a chance to review or modify the command before hitting enter.
          },
        },
      },
    },
    ft = { "cpp" },
  },
  -- override plugin configs
  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-media-files.nvim",
      "nvim-telescope/telescope-dap.nvim",
      "nvim-telescope/telescope-symbols.nvim",
      "nvim-telescope/telescope-bibtex.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    opts = overrides.telescope,
  },
  -- Install a plugin
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

  {
    "stevearc/conform.nvim",
    --  for users those who want auto-save conform + lazyloading!
    event = "BufWritePre",
    config = function()
      require "custom.configs.conform"
    end,
  },
  {
    "petertriho/nvim-scrollbar",
    lazy = false,
  },
  -- {
  --     "stevearc/overseer.nvim",
  --     opts = {
  --         cmake_dap_configuration = { -- debug settings for cmake
  --             name = "cpp",
  --             type = "codelldb",
  --             request = "launch",
  --             stopOnEntry = false,
  --             runInTerminal = true,
  --             console = "integratedTerminal",
  --         },
  --     },
  --     ft = { "cpp" },
  -- },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
    dependencies = "tyru/open-browser.vim",
  },
  {
    "stevearc/dressing.nvim",
    opts = {},
    lazy = false,
  },
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      dapConfig.ui,
      dapConfig.virtual_text,
      dapConfig.mason,
      "rcarriga/nvim-notify",
      "Weissle/persistent-breakpoints.nvim",
    },
  },
  {
    "renerocksai/telekasten.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    opts = telekastenConfig,
    event = "VimEnter",
  },
  {
    "HakonHarnes/img-clip.nvim",
    event = "BufEnter",
    opts = {
      show_dir_path_in_prompt = true,
      markdown = {
        relative_to_current_file = true,
        show_dir_path_in_prompt = true,
        url_encode_path = true,
        dir_path = "zettelkasten/img",
        template = "![$CURSOR]($FILE_PATH)",
      },
      -- add options here
      -- or leave it empty to use the default settings
    },
    keys = {
      -- suggested keymap
      { "<leader>p", "<cmd>PasteImage<cr>", desc = "Paste clipboard image" },
    },
  },
  -- {
  --   "Fildo7525/pretty_hover",
  --   event = "LspAttach",
  --   -- lazy = false,
  --   opts = {
  --     {
  --       -- Tables grouping the detected strings and using the markdown highlighters.
  --       header = {
  --         detect = { "[\\@]class", "[\\]class" },
  --         styler = "###",
  --       },
  --       line = {
  --         detect = { "[\\@]brief", "[\\]brief", "[\\]details" },
  --         styler = "**",
  --       },
  --       listing = {
  --         detect = { "[\\@]li", "[\\]li" },
  --         styler = " - ",
  --       },
  --       references = {
  --         detect = { "[\\@]ref", "[\\]ref", "[\\]p", "[\\@]c", "[\\@]name" },
  --         styler = { "**", "`" },
  --       },
  --       word = {
  --         detect = { "[\\@]param", "[\\]param", "[\\@]tparam", "[\\]tparam", "[\\@]see", "[\\@]*param*" },
  --         styler = "`",
  --       },
  --
  --       -- Tables used for cleaner identification of hover segments.
  --       code = {
  --         start = { "[\\@]code" },
  --         ending = { "[\\@]endcode" },
  --       },
  --       return_statement = {
  --         "[\\@]return",
  --         "[\\]return",
  --         "[\\@]*return*",
  --       },
  --
  --       -- Highlight groups used in the hover method. Feel free to define your own highlight group.
  --       hl = {
  --         error = {
  --           color = "#DC2626",
  --           detect = { "[\\@]error", "[\\@]bug" },
  --           line = false, -- Flag detecting if the whole line should be highlighted
  --         },
  --         warning = {
  --           color = "#FBBF24",
  --           detect = { "[\\@]warning", "[\\@]thread_safety", "[\\@]throw" },
  --           line = false,
  --         },
  --         info = {
  --           color = "#2563EB",
  --           detect = { "[\\@]remark", "[\\@]note", "[\\@]notes" },
  --         },
  --         -- Here you can setup your own highlight groups.
  --       },
  --
  --       border = "rounded",
  --       max_width = nil,
  --       max_height = nil,
  --       toggle = false,
  --     },
  --   },
  -- },
}

return plugins
