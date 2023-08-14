local DapConfig = {}
local continue = function()
  if vim.fn.filereadable ".vscode/launch.json" then
    require("dap.ext.vscode").load_launchjs()
  end
  require("dap").continue()
end
DapConfig.ui = {
  -- fancy UI for the debugger
  {
    "rcarriga/nvim-dap-ui",
        -- stylua: ignore
        keys = {
          { "<leader>du", function() require("dapui").toggle({ }) end, desc = "Dap UI" },
          { "<leader>de", function() require("dapui").eval() end, desc = "Eval", mode = {"n", "v"} },
          {"<F5>", continue},
          {"<F6>", "<cmd>lua require('dap').run_to_cursor()<CR>"},
          {"<F10>", "<cmd>lua require('dap').step_over()<CR>"},
          {"<F11>", "<cmd>lua require('dap').step_into()<CR>"},
          {"<Shift+F11>", "<cmd>lua require('dap').step_out()<CR>"},
          {"<F3>", "<cmd>lua require('dap').down()<CR>"},
          {"<Shift+F3>", "<cmd>lua require('dap').up()<CR>"},
          -- {"<F9>", "<cmd>lua require('persistent-breakpoints.api').toggle_breakpoint()<cr>"}
          {"<F9>", "<cmd>DapToggleBreakpoint<cr>"},
          {"<F1>", "<cmd>DapTerminate<cr>"},
        },
    opts = {
      layouts = {
        {
          elements = {
            -- Elements can be strings or table with id and size keys.
            "repl",
            "breakpoints",
            "stacks",
            "watches",
          },
          size = 40, -- 40 columns
          position = "left",
        },
        {
          elements = {
            "scopes",
            "console",
          },
          size = 0.25, -- 25% of total lines
          position = "bottom",
        },
      },
      icons = { expanded = "", collapsed = "", current_frame = "" },
      mappings = {
        -- Use a table to apply multiple mappings
        expand = { "<CR>", "<2-LeftMouse>" },
        open = { "o" },
        remove = "d",
        edit = "e",
        repl = "r",
        toggle = "t",
      },
      -- Use this to override mappings for specific elements
      element_mappings = {
        stacks = {
          open = "<cr>",
          expand = "o",
        },
      },
      -- Expand lines larger than the window
      -- Requires >= 0.7
      expand_lines = vim.fn.has "nvim-0.7" == 1,
      controls = {
        -- Requires Neovim nightly (or 0.8 when released)
        enabled = true,
        -- Display controls in this element
        element = "repl",
        icons = {
          pause = "",
          play = "",
          step_into = "",
          step_over = "",
          step_out = "",
          step_back = "",
          run_last = "",
          terminate = "",
        },
      },
      floating = {
        max_height = nil, -- These can be integers or a float between 0 and 1.
        max_width = nil, -- Floats will be treated as percentage of your screen.
        border = "single", -- Border style. Can be "single", "double" or "rounded"
        mappings = {
          close = { "q", "<Esc>" },
        },
      },
      windows = { indent = 1 },
      render = {
        max_type_length = nil, -- Can be integer or nil.
        max_value_lines = 100, -- Can be integer or nil.
      },
    },
    config = function(_, opts)
      local dap = require "dap"
      local dapui = require "dapui"
      dapui.setup(opts)
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open {}
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close {}
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close {}
        require "notify"("Debugger session ended", "warn")
      end
    end,
  },
}
-- virtual text for the debugger
DapConfig.virtual_text = {
  "theHamsta/nvim-dap-virtual-text",
  opts = {},
}
-- mason.nvim integration
DapConfig.mason = {
  "jay-babu/mason-nvim-dap.nvim",
  dependencies = "mason.nvim",
  cmd = { "DapInstall", "DapUninstall" },
  opts = {
    -- Makes a best effort to setup the various debuggers with
    -- reasonable debug configurations
    automatic_setup = true,
    -- You can provide additional configuration to the handlers,
    -- see mason-nvim-dap README for more information
    handlers = {
      codelldb = function(source_name)
        require("dap").adapters.codelldb = {
          name = "codelldb server",
          type = "server",
          port = "${port}",
          executable = {
            command = vim.fn.stdpath "data" .. "/mason/bin/codelldb",
            args = { "--port", "${port}" },

            -- On windows you may have to uncomment this:
            -- detached = false,
          },
        }
        require("dap").adapters.cpp = {
          name = "codelldb server",
          type = "server",
          port = "${port}",
          executable = {
            command = vim.fn.stdpath "data" .. "/mason/bin/codelldb",
            args = { "--port", "${port}" },

            -- On windows you may have to uncomment this:
            -- detached = false,
          },
        }
        require("dap").configurations.cpp = {
          {
            name = "Launch in console",
            type = "cpp",
            request = "launch",
            program = function()
              return vim.fn.input("Path to executable: ", (vim.fn.getcwd() .. "/../"):match "(.*[/\\])", "file")
            end,
            cwd = "${workspaceFolder}",
            stopOnEntry = false,
            args = {},
            runInTerminal = true,
          },
        }
      end,
    },
  },
}
vim.fn.sign_define("DapBreakpoint", { text = "🔴" })
vim.fn.sign_define("DapBreakpointCondition", { text = "📍" })
vim.fn.sign_define("DapBreakpointRejected", { text = "⭕" })
return DapConfig
