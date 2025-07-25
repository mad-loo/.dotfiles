-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Configure plugins
require("lazy").setup({
  -- Syntax highlighting
  {
    'nvim-treesitter/nvim-treesitter',
    build = ":TSUpdate",
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = {
          "lua",
          "vim",
          "javascript", "typescript", "html", "css",
          "c", "cpp", "make", "cmake"
        },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end
  },

  -- Statusline
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      -- Light theme-friendly color scheme
      local light_theme = {
        normal = {
          a = { bg = '#4a6da7', fg = '#ffffff', gui = 'bold' },  -- Soft blue
          b = { bg = '#d8dee9', fg = '#3b4252' },                -- Light gray background, dark text
          c = { bg = '#eceff4', fg = '#3b4252' }                 -- Lighter background
        },
        insert = {
          a = { bg = '#5e8d87', fg = '#ffffff', gui = 'bold' },  -- Soft teal
          b = { bg = '#d8dee9', fg = '#3b4252' },
          c = { bg = '#eceff4', fg = '#3b4252' }
        },
        visual = {
          a = { bg = '#8f6c93', fg = '#ffffff', gui = 'bold' },  -- Soft purple
          b = { bg = '#d8dee9', fg = '#3b4252' },
          c = { bg = '#eceff4', fg = '#3b4252' }
        },
        replace = {
          a = { bg = '#a3636a', fg = '#ffffff', gui = 'bold' },  -- Soft red
          b = { bg = '#d8dee9', fg = '#3b4252' },
          c = { bg = '#eceff4', fg = '#3b4252' }
        },
        command = {
          a = { bg = '#9a7a4d', fg = '#ffffff', gui = 'bold' },  -- Soft amber
          b = { bg = '#d8dee9', fg = '#3b4252' },
          c = { bg = '#eceff4', fg = '#3b4252' }
        },
        inactive = {
          a = { bg = '#c0c0c0', fg = '#4c566a' },
          b = { bg = '#e5e9f0', fg = '#4c566a' },
          c = { bg = '#e5e9f0', fg = '#4c566a' }
        }
      }

      require('lualine').setup({
        options = {
          theme = light_theme,
          component_separators = { left = '│', right = '│' },  -- Simple separator
          section_separators = { left = '', right = '' },      -- Borderless separator
          globalstatus = true,
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = {
            { 'filename', color = { fg = '#2e3440', gui = 'bold' } },
            { 'branch', icon = '', color = { fg = '#5e81ac' } }  -- Soft blue
          },
          lualine_c = {
            { 'diff',
              colored = true,
              diff_color = {
                added    = { fg = '#5e8d87' },  -- Soft green
                modified = { fg = '#9a7a4d' },  -- Soft yellow
                removed  = { fg = '#a3636a' }   -- Soft red
              }
            }
          },
          lualine_x = {
            { 'diagnostics',
              sources = { 'nvim_diagnostic' },
              symbols = { error = '✘ ', warn = '▲ ', info = 'ℹ ', hint = '⚑ ' },  -- More concise symbols
              diagnostics_color = {
                error = { fg = '#a3636a' },  -- Soft red
                warn  = { fg = '#9a7a4d' },  -- Soft yellow
                info  = { fg = '#5e81ac' },  -- Soft blue
                hint  = { fg = '#5e8d87' }   -- Soft green
              }
            }
          },
          lualine_y = {
            { 'filetype', icon_only = false, color = { fg = '#2e3440' } }
          },
          lualine_z = {
            { 'progress', color = { fg = '#2e3440' } },
            { 'location', color = { fg = '#2e3440' } }
          }
        }
      })
    end
  },

  -- Fuzzy finder
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('telescope').setup()
      vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>')
      vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<cr>')
      vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<cr>')
    end
  },

  -- File explorer
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('nvim-tree').setup()
      vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<cr>')
    end
  },

  -- EditorConfig support (reduces redundant configuration)
  'gpanders/editorconfig.nvim',

  -- Auto-completion
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lsp',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
    },
    config = function()
      local cmp = require('cmp')
      local luasnip = require('luasnip')

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end, { 'i', 's' }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'buffer' },
          { name = 'path' },
        })
      })
    end
  },

  -- LSP Support
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
    },
    config = function()
      require('mason').setup()
      require('mason-lspconfig').setup({
        ensure_installed = { "clangd" }
      })

      -- Configure clangd
      require('lspconfig').clangd.setup{
        cmd = {
          "clangd",
          "--background-index",
          "--suggest-missing-includes",
          "--clang-tidy",
          "--header-insertion=iwyu",
        }
      }

      -- Basic key mappings for LSP functionality
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
      vim.keymap.set('n', 'K', vim.lsp.buf.hover)
      vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action)
      vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename)
      -- C Support hotkeys
      vim.keymap.set('n', '<leader>ci', vim.lsp.buf.implementation)
      vim.keymap.set('n', '<leader>cr', vim.lsp.buf.references)
      vim.keymap.set('n', '<leader>ct', vim.lsp.buf.type_definition)
    end
  },

  -- Git integration
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end
  },

  -- Comment code easily
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  },

  -- nvim autopairs
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",  -- Lazy loading to improve startup speed
    config = function()
      require('nvim-autopairs').setup({
        check_ts = true,  -- Use treesitter to check context
        disable_filetype = { "TelescopePrompt" },  -- Disable in specific file types
        -- Quick wrapping of existing text
        fast_wrap = {
          map = '<M-e>',  -- Alt+e triggers quick wrapping
          chars = { '{', '[', '(', '"', "'" },
          pattern = [=[[%'%"%>%]%)%}%,]]=],
          end_key = '$',
          keys = 'qwertyuiopzxcvbnmasdfghjkl',
          check_comma = true,
        },
      })

      -- Integrate nvim-cmp
      if package.loaded['cmp'] then
        local cmp_autopairs = require('nvim-autopairs.completion.cmp')
        local cmp = require('cmp')
        cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
      end
    end
  },

  -- Formatter
  {
    'mhartington/formatter.nvim',
    config = function()
      require('formatter').setup({
        filetype = {
          c = {
            function()
              return {
                exe = "clang-format",
                args = {"--assume-filename", vim.api.nvim_buf_get_name(0)},
                stdin = true
              }
            end
          }
        }
      })
      vim.keymap.set('n', '<leader>f', ':Format<CR>')
    end
  },

  -- C Debugger Support LLDB
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'rcarriga/nvim-dap-ui',
      'theHamsta/nvim-dap-virtual-text',
    },
    config = function()
      -- Add Debugger configuration
      local dap = require('dap')
      dap.adapters.lldb = {
        type = 'executable',
        command = '/usr/bin/lldb-vscode',
        name = 'lldb'
      }
      dap.configurations.c = {
        {
          name = "Launch",
          type = "lldb",
          request = "launch",
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
          args = {},
        },
      }

      vim.keymap.set('n', '<leader>db', require('dap').toggle_breakpoint)
      vim.keymap.set('n', '<leader>dc', require('dap').continue)
      vim.keymap.set('n', '<leader>ds', require('dap').step_over)
      vim.keymap.set('n', '<leader>di', require('dap').step_into)
      vim.keymap.set('n', '<leader>do', require('dap').step_out)
    end
  }
})

