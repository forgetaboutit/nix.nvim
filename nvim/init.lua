local cmd = vim.cmd
local fn = vim.fn
local opt = vim.o
local g = vim.g

-- <leader> key.
g.mapleader = ' '
g.maplocalleader = ','

opt.compatible = false

-- Enable true colour support
if fn.has('termguicolors') then
  opt.termguicolors = true
end

-- See :h <option> to see what the options do

-- Search down into subfolders
opt.path = vim.o.path .. '**'

opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.lazyredraw = true
-- Highlight matching parentheses, etc
opt.showmatch = true
-- Show matches as we type
opt.incsearch = true
-- Don't highlight all matches for search
opt.hlsearch = false

opt.spell = true
opt.spelllang = 'en'

-- Sensible indenting
opt.expandtab = true
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
-- Try to use smart indents for new lines
opt.smartindent = true;

opt.foldenable = true

opt.history = 2000
opt.nrformats = 'bin,hex' -- 'octal'
-- Enable 24 bit colors in the terminal
opt.termguicolors = true

-- Don't create local swap and backup files
opt.swapfile = false
opt.undofile = true
opt.splitright = true
opt.splitbelow = true
opt.cmdheight = 0

-- Never show more than 8 empty rows on the bottom if possible
opt.scrolloff = 8
-- Always show the sign column to prevent jumpiness
opt.signcolumn = "yes"
-- Idleness in milliseconds to update the swap file for recovery
opt.updatetime = 50

opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

-- Configure Neovim diagnostic messages

local function prefix_diagnostic(prefix, diagnostic)
  return string.format(prefix .. ' %s', diagnostic.message)
end

vim.diagnostic.config {
  virtual_text = {
    prefix = '',
    format = function(diagnostic)
      local severity = diagnostic.severity
      if severity == vim.diagnostic.severity.ERROR then
        return prefix_diagnostic('󰅚', diagnostic)
      end
      if severity == vim.diagnostic.severity.WARN then
        return prefix_diagnostic('⚠', diagnostic)
      end
      if severity == vim.diagnostic.severity.INFO then
        return prefix_diagnostic('ⓘ', diagnostic)
      end
      if severity == vim.diagnostic.severity.HINT then
        return prefix_diagnostic('󰌶', diagnostic)
      end
      return prefix_diagnostic('■', diagnostic)
    end,
  },
  signs = {
    text = {
      -- Requires Nerd fonts
      [vim.diagnostic.severity.ERROR] = '󰅚',
      [vim.diagnostic.severity.WARN] = '⚠',
      [vim.diagnostic.severity.INFO] = 'ⓘ',
      [vim.diagnostic.severity.HINT] = '󰌶',
    },
  },
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  float = {
    focusable = false,
    style = 'minimal',
    border = 'rounded',
    source = 'if_many',
    header = '',
    prefix = '',
  },
}

g.editorconfig = true

vim.opt.colorcolumn = '80'

require("catppuccin").setup({
  flavour = "mocha"
})
cmd("colorscheme catppuccin-mocha")

-- Native plugins
cmd.filetype('plugin', 'indent', 'on')
cmd.packadd('cfilter') -- Allows filtering the quickfix list with :cfdo
-- let sqlite.lua (which some plugins depend on) know where to find sqlite
vim.g.sqlite_clib_path = require('luv').os_getenv('LIBSQLITE')
