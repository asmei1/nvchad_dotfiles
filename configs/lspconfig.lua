local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

-- if you just want default config for the servers then put them in a table
-- local servers = { "html", "cssls", "tsserver", "clangd" }
local servers = { "clangd" }
capabilities.offsetEncoding = "utf-8"
lspconfig["clangd"].setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { "clangd", "--header-insertion=never", "--clang-tidy", "--cross-file-rename" },
  on_new_config = function(new_config, new_cwd)
    local status, cmake = pcall(require, "cmake-tools")
    if status then
      cmake.clangd_on_new_config(new_config)
    end
  end,
}
lspconfig.pyright.setup {}
-- lspconfig.pyright.setup { blabla}
