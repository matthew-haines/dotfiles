local Plug = vim.fn['plug#']
vim.call('plug#begin', '~/.config/nvim/plugged')
  Plug 'matthew-haines/vim-hybrid'
  Plug('projekt0n/github-nvim-theme', { ['tag'] = 'v0.0.7' })

  Plug('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'})

  Plug 'neovim/nvim-lspconfig'

  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/cmp-nvim-lsp'

  Plug 'lervag/vimtex'
  vim.g.tex_flavor='latex'
  vim.g.vimtex_view_method='skim'
  vim.g.vimtex_format_enabled = true

  Plug 'nvim-lua/plenary.nvim'
  Plug('nvim-telescope/telescope.nvim', { ['tag'] = '0.1.x' })

  Plug 'geg2102/nvim-python-repl'
vim.call('plug#end')

vim.g.python3_host_prog = '/usr/local/bin/python3.11'
vim.g.python_recommended_style = false

vim.opt.cursorline = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.number = true
vim.opt.showmatch = true
vim.opt.ic = true
vim.opt.splitright = true
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"

require("github-theme").setup()

vim.cmd [[
  syntax enable
  colorscheme github_light
  hi Normal guibg=#1e1e1e
  
  filetype on
  filetype indent on
  filetype plugin on

  function! s:check_back_space() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~ '\s'
  endfunction
]]

local map = vim.api.nvim_set_keymap
map('n', '<Leader>cd', ':cd %:p:h<CR>', {noremap = true})

require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "cpp", "lua", "vim", "typescript", "python", "rust", "help", "query" },
  highlight = {
    enable = true
  },
}

-- Setup LSP
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lspconfig = require('lspconfig')
lspconfig.clangd.setup {
  capabilities,
  cmd = { "/Library/Developer/CommandLineTools/usr/bin/clangd" }
}
lspconfig.rust_analyzer.setup {
  capabilities,
  cmd = { "/Users/matthew/.rustup/toolchains/nightly-x86_64-apple-darwin/bin/rust-analyzer" },
  settings = {
    ['rust-analyzer'] = {
      experimental = {
        procAttrMacros = true;
      },
      procMacro = {
        enable = true
      }
    }
  },
}
lspconfig.tsserver.setup {
  capabilities
}
lspconfig.pyright.setup {
  capabilities
}
-- https://dzfrias.dev/blog/neovim-unity-setup/
lspconfig.omnisharp.setup {
  cmd = {
    'mono',
    '--assembly-loader=strict',
    '/Users/matthew/bin/omnisharp-osx/omnisharp/OmniSharp.exe',
  },
  use_mono = true,
}


-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Buffer local mappings.
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

-- format on save
vim.api.nvim_create_autocmd('BufWritePre', {
  callback = function(ev)
    vim.lsp.buf.format()
  end
})

-- Setup tab completion
local cmp = require 'cmp'
cmp.setup {
  mapping = cmp.mapping.preset.insert({
    ['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
    ['<C-d>'] = cmp.mapping.scroll_docs(4), -- Down
    -- C-b (back) C-f (forward) for snippet placeholder navigation.
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {
    { name = 'nvim_lsp' },
  },
}

-- Telescope
local builtin = require('telescope.builtin')
local utils = require('telescope.utils')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fc', function() builtin.find_files({cwd = utils.buffer_dir()}) end)
require "telescope".setup {
  extensions = {
    file_browser = {
      mappings = {
        ["i"] = {
          ["<C-t>"] = require "telescope.actions".select_tab
        }
      }
    }
  }
}

-- Exit terminal to normal mode with control \
vim.api.nvim_set_keymap('t', '<C-\\>', [[<C-\><C-n>]], {noremap = true})

require("nvim-python-repl").setup({
    execute_on_send=true, 
    vsplit=false,
})

vim.keymap.set("n", '<space>rf', function() require('nvim-python-repl').send_statement_definition() end, { desc = "Send semantic unit to REPL"})
vim.keymap.set("v", '<space>rv', function() require('nvim-python-repl').send_visual_to_repl() end, { desc = "Send visual selection to REPL"})
vim.keymap.set("n", '<space>rb', function() require('nvim-python-repl').send_buffer_to_repl() end, { desc = "Send entire buffer to REPL"})
-- vim.keymap.set("n", [your keymap], function() require('nvim-python-repl').toggle_execute() end, { desc = "Automatically execute command in REPL after sent"})
vim.keymap.set("n", '<space>re', function() require('nvim-python-repl').toggle_vertical() end, { desc = "Create REPL in vertical or horizontal split"})
