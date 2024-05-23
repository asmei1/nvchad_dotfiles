local dapConfig = require "configs.dap"
return {
    {
        "stevearc/conform.nvim",
        event = "BufWritePre", -- uncomment for format on save
        config = function()
            require "configs.conform"
        end,
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            require("nvchad.configs.lspconfig").defaults()
            require "configs.lspconfig"
        end,
    },
    {
        "stevearc/dressing.nvim",
        opts = {},
        lazy = false,
    },
    {
        "petertriho/nvim-scrollbar",
        lazy = false,
    },
    {

        "hrsh7th/nvim-cmp",
        opts = require("configs.cmp")
    },
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            dapConfig.ui,
            dapConfig.virtual_text,
            dapConfig.mason,
            "rcarriga/nvim-notify",
            "Weissle/persistent-breakpoints.nvim",
            "nvim-neotest/nvim-nio",
        },
    },
    {
        "nvim-tree/nvim-tree.lua",
        opts = {
            git = {
                enable = true,
            },
            filters = {
                dotfiles = false,
            },
            renderer = {
                highlight_git = true,
                group_empty = true,
                icons = {
                    show = {
                        git = true,
                    },
                },
            },
            view = {
                preserve_window_proportions = true,
            },
        },
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
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-telescope/telescope-media-files.nvim",
            "nvim-telescope/telescope-dap.nvim",
            "nvim-telescope/telescope-symbols.nvim",
            "nvim-telescope/telescope-bibtex.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        },
        opts = require "configs.telescope",
    },
    {
        "williamboman/mason.nvim",
        opts = {
            ensure_installed = {
                "lua-language-server",
                "stylua",
                "clangd",
                "pyright",
                "black",
            },
        },
    },
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            highlight = {
                enable = true
            },
            indent = {
                enable = true
            },
        },
    },
    {
        "renerocksai/telekasten.nvim",
        dependencies = { "nvim-telescope/telescope.nvim" },
        opts = require "configs.telekasten",
        event = "VimEnter",
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
            cmake_executor = {     -- executor to use
                name = "terminal", -- name of the executor
            },
            cmake_virtual_text_support = false,
        },
        ft = { "cpp" },
    },
}
