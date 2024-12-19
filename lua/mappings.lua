-- require "nvchad.mappings"

local map = vim.keymap.set

map('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>')
map('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>')
map('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>')
map("x", "<leader>p", '[["_dP]]')

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "<C-b>", "<ESC>^i", { desc = "Move Beginning of line" })
map("i", "<C-b>", "<ESC>^i", { desc = "Move Beginning of line" })
map("i", "<C-e>", "<End>", { desc = "Move End of line" })
map("i", "<C-h>", "<Left>", { desc = "Move Left" })
map("i", "<C-l>", "<Right>", { desc = "Move Right" })
map("i", "<C-j>", "<Down>", { desc = "Move Down" })
map("i", "<C-k>", "<Up>", { desc = "Move Up" })

map("v", "<leader>y", '[["+y]]', { desc = "y, but also yank into system buffer" })
map("v", "<leader>Y", '[["+Y]]', { desc = "Y, but also yank into system buffer" })
map("v", "<leader>d", '[["+d]]', { desc = "d, but also yank into system buffer" })

map("i", "<A-j>", "<ESC>:m .+1<CR>", { desc = "Move line up(v)" })
map("i", "<A-k>", "<ESC>:m .-2<CR>", { desc = "Move line down(v)" })
map("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line up(v)" })
map("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line down(v)" })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move line up(v)" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move line down(v)" })

map("n", "<leader>ko", "<cmd>ClangdSwitchSourceHeader<CR>", { desc = "[Clang] Switch header/source" })

map("n", "<Esc>", "<cmd>noh<CR>", { desc = "General Clear highlights" })

map("n", "<C-h>", "<C-w>h", { desc = "Switch Window left" })
map("n", "<C-l>", "<C-w>l", { desc = "Switch Window right" })
map("n", "<C-j>", "<C-w>j", { desc = "Switch Window down" })
map("n", "<C-k>", "<C-w>k", { desc = "Switch Window up" })

map("n", "<C-s>", "<cmd>w<CR>", { desc = "File Save" })
map("n", "<leader>ch", "<cmd>NvCheatsheet<CR>", { desc = "Toggle NvCheatsheet" })



map("n", "<leader>fm", function()
    require("conform").format { lsp_fallback = true }
end, { desc = "Format Files" })


--- LSP ----
map("n", "<leader>lf", vim.diagnostic.open_float, { desc = "Lsp floating diagnostics" })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Lsp prev diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Lsp next diagnostic" })
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Lsp diagnostic loclist" })



-- tabufline
map("n", "<leader>b", "<cmd>enew<CR>", { desc = "Buffer New" })

map("n", "<tab>", function()
    require("nvchad.tabufline").next()
end, { desc = "Buffer Goto next" })

map("n", "<S-tab>", function()
    require("nvchad.tabufline").prev()
end, { desc = "Buffer Goto prev" })

map("n", "<leader>x", function()
    require("nvchad.tabufline").close_buffer()
end, { desc = "Buffer Close" })

-- Comment
map('n', '<leader>/', 'gcc', { remap = true })
map('v', '<leader>/', 'gcc', { remap = true })

-- nvimtree
map("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { desc = "Nvimtree Toggle window" })
map("n", "<leader>e", "<cmd>NvimTreeFocus<CR>", { desc = "Nvimtree Focus window" })


-- telescope
map("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "Telescope Live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Telescope Find buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Telescope Help page" })

map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "Telescope Find oldfiles" })
map("n", "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "Telescope Find in current buffer" })
map("n", "<leader>cm", "<cmd>Telescope git_commits<CR>", { desc = "Telescope Git commits" })
map("n", "<leader>gt", "<cmd>Telescope git_status<CR>", { desc = "Telescope Git status" })
-- map("n", "<leader>pt", "<cmd>Telescope terms<CR>", { desc = "Telescope Pick hidden term" })
-- map("n", "<leader>th", "<cmd>Telescope themes<CR>", { desc = "Telescope Nvchad themes" })
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Telescope Find files" })
map("n", "<leader>fr", "<cmd>Telescope lsp_references<cr>", { desc = "Telescope Find LSP references" })
map("n", "<leader>fr", function()
    require("telescope.builtin").git_files { path_display = { "truncate" } }
end, { desc = "Telescope Find LSP references" })
map(
    "n",
    "<leader>fa",
    "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
    { desc = "Telescope Find all files" }
)

-- Telekasten
map("n", "<leader>z", "<cmd>Telekasten panel<CR>", { desc = "Telekasten panel" })
map("n", "<leader>zf", "<cmd>Telekasten find_notes<CR>", { desc = "Telekasten Find notes" })
map("n", "<leader>zg", "<cmd>Telekasten search_notes<CR>", { desc = "Telekasten Search notes" })
map("n", "<leader>zd", "<cmd>Telekasten goto_today<CR>", { desc = "Telekasten Goto Today" })
map("n", "<leader>zz", "<cmd>Telekasten folow_link<CR>", { desc = "Telekasten Follow Link" })
map("n", "<leader>zn", "<cmd>Telekasten new_note<CR>", { desc = "Telekasten NewNote" })
map("n", "<leader>zb", "<cmd>Telekasten show_backlinks<CR>", { desc = "Telekasten Show backlinks" })
map("n", "<leader>zI", "<cmd>Telekasten insert_img_links<CR>", { desc = "Telekasten insert image link" })
