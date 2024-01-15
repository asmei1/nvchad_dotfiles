local overrides = require "custom.configs.overrides"
local dapConfig = require "custom.configs.dap"
local telekastenConfig = require "custom.configs.telekasten"
---@type NvPluginSpec[]
local plugins = {

    -- Override plugin definition options

    {
        "neovim/nvim-lspconfig",
        dependencies = {
            -- format & linting
            {
                "jose-elias-alvarez/null-ls.nvim",
                config = function()
                    require "custom.configs.null-ls"
                end,
            },
        },
        config = function()
            require "plugins.configs.lspconfig"
            require "custom.configs.lspconfig"
        end, -- Override to setup mason-lspconfig
    },
    {
        "Civitasv/cmake-tools.nvim",
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
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
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
        "petertriho/nvim-scrollbar",
        lazy = false,
    },
    {
        "stevearc/overseer.nvim",
        opts = {
            cmake_dap_configuration = { -- debug settings for cmake
                name = "cpp",
                type = "codelldb",
                request = "launch",
                stopOnEntry = false,
                runInTerminal = true,
                console = "integratedTerminal",
            },
        },
        ft = { "cpp" },
    },
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
    }
}

return plugins
