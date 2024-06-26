local telescope_options = {}

telescope_options = {
  defaults = {
    path_display = { "shorten" },
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
        local is_image = function()
          local image_extensions = { "png", "jpg" } -- Supported image formats
          local split_path = vim.split(filepath:lower(), ".", { plain = true })
          local extension = split_path[#split_path]
          return vim.tbl_contains(image_extensions, extension)
        end
        if is_image() then
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
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case", -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    },
    -- options for sorting all other items
    generic = {
      -- override default telescope generic item sorter
      enable = true,

      -- highlight matching text in results
      highlight_results = true,

      -- disable zf filename match priority
      match_filename = false,
    },
    media_files = {
      filetypes = { "png", "webp", "jpg", "jpeg" },
      find_cmd = "fdfind",
    },
  },
  extensions_list = {
    "dap",
    -- "symbols",
    "media_files",
    "bibtex",
    "fzf",
  },
}

return telescope_options
