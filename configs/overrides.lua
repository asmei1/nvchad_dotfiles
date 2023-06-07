local M = {}
M.telescope = {
  defaults = {
    path_display = { "smart" },
    file_sorter = require("telescope.sorters").get_fuzzy_file,
    file_ignore_patterns = { "node_modules" },
    generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
    pickers = {
      lsp_code_actions = { previewers = false, theme = "cursor" },
      lsp_references = { layout_strategy = "vertical", previewers = true },
    },
    preview = {
      mime_hook = function(filepath, bufnr, opts)
        local is_image = function(filepath)
          local image_extensions = { "png", "jpg" } -- Supported image formats
          local split_path = vim.split(filepath:lower(), ".", { plain = true })
          local extension = split_path[#split_path]
          return vim.tbl_contains(image_extensions, extension)
        end
        if is_image(filepath) then
          local term = vim.api.nvim_open_term(bufnr, {})
          local function send_output(_, data, _)
            for _, d in ipairs(data) do
              vim.api.nvim_chan_send(term, d .. "\r\n")
            end
          end
          vim.fn.jobstart({
            "catimg",
            filepath, -- Terminal image viewer command
          }, { on_stdout = send_output, stdout_buffered = true, pty = true })
        else
          require("telescope.previewers.utils").set_preview_message(bufnr, opts.winid, "Binary cannot be previewed")
        end
      end,
    },
  },
  extensions = {
    -- options for sorting all other items
    generic = {
      -- override default telescope generic item sorter
      enable = true,

      -- highlight matching text in results
      highlight_results = true,

      -- disable zf filename match priority
      match_filename = false,
    },
  },
  extensions_list = {
    "dap",
    -- "symbols",
    "bibtex",
  },
}
M.treesitter = {
  ensure_installed = {
    "vim",
    "lua",
    "html",
    "css",
    "javascript",
    "tsx",
    "c",
    "markdown",
    "markdown_inline",
  },
  indent = {
    enable = true,
    -- disable = {
    --   "python"
    -- },
  },
}

M.mason = {
  ensure_installed = {
    -- lua stuff
    "lua-language-server",
    "stylua",

    -- web dev stuff
    "css-lsp",
    "html-lsp",
    "typescript-language-server",
    "deno",
    "prettier",

    -- c/cpp stuff
    "clangd",
    "clang-format",
  },
}

-- git support in nvimtree
M.nvimtree = {
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
}
return M
