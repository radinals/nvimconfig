local capabilities = require('cmp_nvim_lsp').default_capabilities()

return {
  servers = {
    bashls = {},
    jedi_language_server = {},
    marksman = {},
    lua_ls = {},
    texlab = {},
    eslint = {},
    html = {},
    cssls = {},
    clangd = {
      cmd = { "clangd", "--background-index" },
      filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
      root_dir = require('lspconfig').util.root_pattern('compile_commands.json', 'CMakeLists.txt', '.git'),
      capabilities = require('cmp_nvim_lsp').default_capabilities()

    }
  },
  on_attach = function(client, bufnr)
    require('cmp').setup.buffer({
      sources = {
        { name = 'nvim_lsp' },  -- LSP completion source
      }
    })
  end,
}

