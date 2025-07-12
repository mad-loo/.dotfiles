-- Load traditional vim syntax highlighting first
vim.cmd([[
  syntax enable
  filetype plugin indent on
]])

-- Basic settings
vim.opt.number = true               -- Show line numbers
vim.opt.expandtab = true            -- Use spaces instead of tabs
vim.opt.shiftwidth = 2              -- Set indent width to 2 spaces
vim.opt.tabstop = 2                 -- Set tab width to 2 spaces
vim.opt.cursorline = true           -- Highlight current line
vim.opt.clipboard = "unnamedplus"   -- Use system clipboard
vim.opt.scrolloff = 5               -- Keep 5 lines visible when scrolling
vim.opt.autoindent = true           -- Copy indent from current line
vim.opt.smartindent = true          -- Smart auto-indenting
vim.opt.mouse = "a"                 -- Enable mouse support

-- Enhanced syntax and appearance
vim.opt.synmaxcol = 200             -- Only highlight the first 200 columns
vim.opt.laststatus = 2              -- Always show status line
vim.g.syntax_on = true              -- Ensure syntax is on

-- Search settings
vim.opt.incsearch = true            -- Incremental search
vim.opt.hlsearch = true             -- Highlight search results
vim.opt.ignorecase = true           -- Case insensitive search
vim.opt.smartcase = true            -- Case sensitive if uppercase present

-- File and encoding settings
vim.opt.encoding = "utf-8"          -- Set internal encoding
vim.opt.fileencoding = "utf-8"      -- Set file encoding
vim.opt.hidden = true               -- Allow switching buffers without saving

-- Avoid backup files
vim.opt.backup = false              -- No backup files
vim.opt.writebackup = false         -- No backup during editing
vim.opt.swapfile = false            -- No swap files

-- Usability improvements
vim.opt.wildmenu = true             -- Command-line completion menu
vim.opt.ruler = true                -- Show cursor position
vim.opt.showcmd = true              -- Show partial commands
vim.opt.splitright = true           -- New vertical splits to the right
vim.opt.splitbelow = true           -- New horizontal splits below

-- Leader key
vim.g.mapleader = " "               -- Use space as leader key

-- Add default colorscheme (helps with syntax highlighting)
vim.cmd('colorscheme shine')       -- Use a default colorscheme that works everywhere

-- Fix status line colors for better readability
vim.cmd([[
  " Make status line background lighter and text darker
  highlight StatusLine   cterm=bold ctermfg=0 ctermbg=7 gui=bold guifg=#000000 guibg=#d3d3d3
  highlight StatusLineNC cterm=none ctermfg=0 ctermbg=7 gui=none guifg=#444444 guibg=#bbbbbb
]])

-- Key mappings
-- Quick save and quit
vim.keymap.set('n', '<leader>w', ':w<CR>')
vim.keymap.set('n', '<leader>q', ':q<CR>')

-- Navigate between splits
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')
