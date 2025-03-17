-- Exit if the language server isn't available
if vim.fn.executable('bash-language-server') ~= 1 then
  return
end

local root_files = {
  '.git',
}

vim.lsp.start {
  name = 'bashls',
  cmd = { 'bash-language-server', 'start' },
  root_dir = vim.fs.dirname(vim.fs.find(root_files, { upward = true })[1]),
  capabilities = require('user.lsp').make_client_capabilities(),
  cmd_cwd = vim.fs.dirname(vim.fn.exepath("bash-language-server")),
}
