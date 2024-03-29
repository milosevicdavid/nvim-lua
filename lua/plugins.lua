-- Plugin definition and loading
-- local execute = vim.api.nvim_command
local fn = vim.fn
local cmd = vim.cmd

-- Boostrap Packer
local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'
local packer_bootstrap
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone','https://github.com/wbthomason/packer.nvim', install_path})
end

-- Load Packer
cmd([[packadd packer.nvim]])

-- Rerun PackerCompile everytime pluggins.lua is updated
cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

-- Initialize pluggins
return require('packer').startup(function(use)
  -- Let Packer manage itself
  use({'wbthomason/packer.nvim', opt = true})

  -- LSP server
  use({
    'neovim/nvim-lspconfig',
    config = function() require('plugins.lspconfig') end
  })
  use 'williamboman/nvim-lsp-installer'  -- Helper for installing most language servers

  -- Autocomplete
  use({
    "hrsh7th/nvim-cmp",
    -- Sources for nvim-cmp
    requires = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function() require('plugins.cmp') end,
  })

  -- -- Treesitter
  -- use({
  --   'nvim-treesitter/nvim-treesitter',
  --   config = function() require('plugins.treesitter') end,
  --   run = ':TSUpdate'
  -- })

  use {
  'rmagatti/auto-session',
  config = function()
    require("auto-session").setup {
      log_level = "error",
      auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/"},
    }
  end
 }

  -- Snippets
  use {"L3MON4D3/LuaSnip", config = function() require('plugins.snippets') end}
  use "rafamadriz/friendly-snippets"

  -- Signature help
  use "ray-x/lsp_signature.nvim"

  use "lukas-reineke/indent-blankline.nvim"


  -- Telescope
  use({
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/plenary.nvim'}},
    config = function() require('plugins.telescope') end,
  })

  use({'nvim-telescope/telescope-fzf-native.nvim', run ='make'})

  -- bufferline
  use({
    'akinsho/bufferline.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function() require('plugins.bufferline') end,
    event = 'BufWinEnter',
  })

  -- statusline
  use({
    'hoob3rt/lualine.nvim',
    config = function() require('plugins.lualine') end,
  })

  -- NvimTree
  use({
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function() require('plugins.nvimtree') end,  -- Must add this manually
  })

  -- Startify
  use({
    'mhinz/vim-startify',
    config = function()
      local path = vim.fn.stdpath('config')..'/lua/plugins/startify.vim'
      vim.cmd('source '..path)
    end
  })

  -- git commands
  use 'tpope/vim-fugitive'

  -- Gitsigns
  use ({
    'lewis6991/gitsigns.nvim',
    requires = {'nvim-lua/plenary.nvim'},
    config = function() require('plugins.gitsigns') end
  })

  -- Formatting
  use 'tpope/vim-commentary'
  use 'tpope/vim-unimpaired'
  use 'tpope/vim-surround'
  use 'tpope/vim-repeat'
  use 'junegunn/vim-easy-align'

  -- Python formatting
  use "EgZvor/vim-black"
  use 'jeetsukumaran/vim-python-indent-black'

  -- Python
  -- use 'heavenshell/vim-pydocstring'   -- Overwrites a keymap, need to fix.
  -- use 'bfredl/nvim-ipy'

  -- Markdown
  use 'godlygeek/tabular'
  use 'ellisonleao/glow.nvim'

  -- TOML Files
  use 'cespare/vim-toml'

  -- Poetry
  -- use({'petobens/poet-v',
  --   config = function()
  --     local path = vim.fn.stdpath('config')..'/lua/plugins/poet-v.vim'
  --     vim.cmd('source '..path)
  --   end
  -- })

  -- kitty config syntax-highlight
  use "fladson/vim-kitty"

  -- note taking with zettelkasten

  -- Pairs
  use 'jiangmiao/auto-pairs'

  use 'pechorin/any-jump.vim'

  -- Leap
  use 'ggandor/leap.nvim'

  -- Vue
  use 'storyn26383/vim-vue'

  -- Javascript
  use 'pangloss/vim-javascript'

  -- Typescrupt
  use 'leafgarland/typescript-vim'

  -- Scss
  use 'cakebaker/scss-syntax.vim'

  -- Css
  use 'hail2u/vim-css3-syntax'

  -- Themes
  use 'folke/tokyonight.nvim'
  use 'marko-cerovac/material.nvim'
  use 'jacoborus/tender.vim'
  use 'preservim/vim-colors-pencil'
  use 'pineapplegiant/spaceduck'
  use 'tomasr/molokai'
  use 'sjl/badwolf'
  use 'NLKNguyen/papercolor-theme'
  use 'sainnhe/everforest'
  use 'sainnhe/gruvbox-material'
  use 'morhetz/gruvbox'
  use 'rebelot/kanagawa.nvim'
  use 'rakr/vim-two-firewatch'
  use 'cseelus/vim-colors-lucid'

  -- Eslint
  use 'eslint/eslint'
  use 'mtscout6/syntastic-local-eslint.vim'
  use 'prettier/vim-prettier'

  --Emmet
  use { 'mattn/emmet-vim',
    config = function()
      local path = vim.fn.stdpath('config')..'/lua/plugins/emmet.vim'
      vim.cmd('source '..path)
    end
}


  -- Ale
  use { 'dense-analysis/ale',
    config = function()
      local path = vim.fn.stdpath('config')..'/lua/plugins/ale.vim'
      vim.cmd('source '..path)
    end
}

 -- Lazygit
 use {'kdheepak/lazygit.nvim',
    config = function()
      local path = vim.fn.stdpath('config')..'/lua/plugins/lazygit.vim'
      vim.cmd('source '..path)
    end
 }

use 'Exafunction/codeium.vim'


-- Float term
use  {
'voldikss/vim-floaterm',
    config = function()
      local path = vim.fn.stdpath('config')..'/lua/plugins/float-term.vim'
      vim.cmd('source '..path)
    end
}


  if packer_bootstrap then
    require('packer').sync()
  end
end)
