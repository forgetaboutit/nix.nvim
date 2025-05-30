-- Exit if the language server isn't available
if vim.fn.executable('elixir-ls') ~= 1 then
  return
end

local root_files = {
  'mix.exs',
  'flake.nix',
}

vim.lsp.start {
  name = 'elixir-ls',
  cmd = { 'elixir-ls' },
  root_dir = vim.fs.dirname(vim.fs.find(root_files, { upward = true })[1]),
  capabilities = require('user.lsp').make_client_capabilities(),
  cmd_cwd = vim.fs.dirname(vim.fn.exepath('elixir-ls')),
}
