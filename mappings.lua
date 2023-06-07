---@type MappingsTable
local M = {}
M.general = {
  i = {
    ["<A-j>"] = { "<ESC>:m '.+1<CR>" }, -- move line up(i)
    ["<A-k>"] = { "<ESC>:m '.-2<CR>" }, -- move line down(i)
    ["[["] = { "<cmd>Telekasten insert_link<CR>", "Insert link" },
  },
  x = {
    ["<leader>p"] = { '[["_dP]]', "" },
  },
  v = {
    ["<leader>kc"] = { ":CommentToggle<CR>", "Comment toggle" },
    ["<leader>y"] = { [["+y]], "y, but also yank into system buffer" },
    ["<leader>Y"] = { [["+Y]], "Y, but also yank into system buffer" },
    ["<leader>d"] = { [["+d]], "d, but also yank into system buffer" },
    ["<A-j>"] = { ":m '>+1<CR>gv=gv" }, -- move line up(v)
    ["<A-k>"] = { ":m '<-2<CR>gv=gv" }, -- move line down(v)
  },
  n = {
    ["<leader>ko"] = { "<cmd>ClangdSwitchSourceHeader<CR>", "Switch header/source" },
    ["<A-j>"] = { ":m .+1<CR>==" }, -- move line up(n)
    ["<A-k>"] = { ":m .-2<CR>==" }, -- move line down(n)
    ["<leader>y"] = { [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], "" },
    ["<leader>Y"] = { [["+Y]], "y, but also yank into system buffer" },
    ["<leader>d"] = { [["+d]], "d, but also yank into system buffer" },
    ["<leader>kc"] = { ":CommentToggle<CR>", "Comment toggle" },
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["<leader>tf"] = { "<cmd>NvimTreeFindFile <CR>", "Find file" },
    ["<C-p>"] = { ":Telescope" },
    ["<leader>fs"] = {
      function()
        require("telescope.builtin").grep_string { search = vim.fn.input "Grep For > " }
      end,
      "Grep For",
    },
    ["<leader>fg"] = {
      function()
        require("telescope.builtin").git_files { path_display = { "truncate" } }
      end,
      "Find in git files",
    },
    ["<A-g>"] = {
      function()
        require("telescope.builtin").git_files {}
      end,
      "Find in git files",
    },
    ["<leader>ff"] = {
      function()
        require("telescope.builtin").find_files()
      end,
      "Find files (all)",
    },
    ["<leader>fr"] = {
      function()
        require("telescope.builtin").lsp_references { trim_text = true, fname_width = 80 }
      end,
      "Find references",
    },
    ["<leader>ft"] = {
      function()
        require("telescope.builtin").lsp_dynamic_workspace_symbols()
      end,
      "Find symbol",
    },
    ["<leader>fb"] = {
      function()
        require("telescope.builtin").buffers()
      end,
      "Find in buffers",
    },
    ["<leader>vh"] = {
      function()
        require("telescope.builtin").help_tags()
      end,
      "Find in help tags",
    },
    ["<leader>vrc"] = {
      function()
        require("asmei.telescope").search_dotfiles { hidden = true }
      end,
      "Find in dot files",
    },
    ["<leader>gc"] = {
      function()
        require("telescope.builtin").git_branches()
      end,
      "Show git branches",
    },
    ["<leader>gs"] = {
      function()
        require("telescope.builtin").git_status()
      end,
      "Git status",
    },
    ["<leader>z"] = { "<cmd>Telekasten panel<CR>", "" },
    ["<leader>zf"] = { "<cmd>Telekasten find_notes<CR>", "Find notes" },
    ["<leader>zg"] = { "<cmd>Telekasten search_notes<CR>", "Search notes" },
    ["<leader>zd"] = { "<cmd>Telekasten goto_today<CR>", "Goto today" },
    ["<leader>zz"] = { "<cmd>Telekasten follow_link<CR>", "Follow link" },
    ["<leader>zn"] = { "<cmd>Telekasten new_note<CR>", "New note" },
    -- ["<leader>zc"] = { "<cmd>Telekasten show_calendar<CR>", "Show calendar" },
    ["<leader>zb"] = { "<cmd>Telekasten show_backlinks<CR>", "Show backlinks" },
    ["<leader>zI"] = { "<cmd>Telekasten insert_img_link<CR>", "Insert image link" },
  },
}
-- more keybinds!

return M
