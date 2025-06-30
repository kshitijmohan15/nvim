local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

return {
  {
    'stevearc/oil.nvim',
    opts = {},
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    lazy = false,
  },
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy", -- Or `LspAttach`
    priority = 1000,    -- needs to be loaded in first
    config = function()
      require('tiny-inline-diagnostic').setup()
      vim.diagnostic.config({ virtual_text = false })   -- Only if needed in your configuration, if you already have native LSP diagnostics
    end
  },
  {
    'jinh0/eyeliner.nvim',
    config = function()
      require('eyeliner').setup({
        highlight_on_key = true,
        dim = false,
        max_length = 9999,
        disabled_filetypes = {},
        disabled_buftypes = {},
        default_keymaps = true,
      })
    end
  },
  {
    'folke/tokyonight.nvim',
    priority = 1000,
    config = function()
      vim.opt.termguicolors = true
      require("tokyonight").setup({
        style = "night"
      })
      vim.cmd([[colorscheme tokyonight]])
    end
  },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    dependencies = {
      'HiPhish/rainbow-delimiters.nvim',
      'nvim-treesitter/nvim-treesitter-textobjects'
    }
  },
  'mbbill/undotree',
  'tpope/vim-fugitive',
  'neovim/nvim-lspconfig',
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'L3MON4D3/LuaSnip',
  'saadparwaiz1/cmp_luasnip',
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
    }
  },
  {
    "kylechui/nvim-surround",
    version = "*",
    config = function()
      require("nvim-surround").setup({})
    end
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" }
  },
  {
    'CRAG666/betterTerm.nvim',
    keys = {
      {
        mode = 'n',
        '<leader>to',
        function()
          require('betterTerm').open()
        end,
        desc = 'Open terminal (main)',
      },
      {
        mode = 'n',
        '<leader>tn',
        function()
          require('betterTerm').open(1)
        end,
        desc = 'Open terminal (secondary)',
      },
      {
        mode = 'n',
        '<leader>tt',
        function()
          require('betterTerm').select()
        end,
        desc = 'Select terminal',
      },
    },
    opts = {
      position = 'bot',
      size = 15,
      startInserted = true,
      show_tabs = true,
      new_tab_mapping = '<C-t>',
    },
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },
}

