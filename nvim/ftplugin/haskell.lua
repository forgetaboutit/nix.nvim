-- Exit if the language server isn't available
if vim.fn.executable('haskell-language-server-wrapper') ~= 1 then
  return
end

local root_files = {
  'hie.yaml',
  'stack.yaml',
  'cabal.project',
  '*.cabal',
  'package.yaml'
}

vim.lsp.start {
  name = 'hls',
  cmd = { 'haskell-language-server-wrapper', '--lsp' },
  root_dir = vim.fs.dirname(vim.fs.find(root_files, { upward = true })[1]),
  capabilities = require('user.lsp').make_client_capabilities(),
  cmd_cwd = vim.fs.dirname(vim.fn.exepath("haskell-language-server-wrapper")),
}
