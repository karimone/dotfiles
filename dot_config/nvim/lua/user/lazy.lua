-- Boostrap lazy packer
--
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

local neoTreePlugin = {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",   -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
    -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
  }
}

local whichKey = {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {}
}

local telescopePlugin = {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.5',
  dependencies = { 'nvim-lua/plenary.nvim' }
}

local luaLinePlugin = {
  -- Set lualine as statusline
  'nvim-lualine/lualine.nvim',
  -- See `:help lualine.txt`
  opts = {
    options = {
      icons_enabled = true,
      theme = 'onedark',
      component_separators = '|',
      section_separators = '',
    },
    sections = {
      lualine_c = {
        {
          'filename',
          file_status = true,      -- Displays file status (readonly status, modified status)
          newfile_status = false,  -- Display new file status (new file means no write after created)
          path = 1,                -- 0: Just the filename
          -- 1: Relative path
          -- 2: Absolute path
          -- 3: Absolute path, with tilde as the home directory
          -- 4: Filename and parent dir, with tilde as the home directory

          shorting_target = 40,    -- Shortens path to leave 40 spaces in the window
          -- for other components. (terrible name, any suggestions?)
          symbols = {
            modified = '[+]',      -- Text to show when the file is modified.
            readonly = '[-]',      -- Text to show when the file is non-modifiable or readonly.
            unnamed = '[No Name]', -- Text to show for unnamed buffers.
            newfile = '[New]',     -- Text to show for newly created file before first write
          }
        }
      }
    }
  },
}

local indentPlugin = {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help indent_blankline.txt`
    main = "ibl",
    opts = {},
}

local nvimTreesitterPlugin = {
  "nvim-treesitter/nvim-treesitter",

  build = ":TSUpdate",

  config = function()
    local configs = require("nvim-treesitter.configs")

    configs.setup({
      ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "sql", "python", "typescript", "javascript", "html" },
      sync_install = false,
      highlight = { enable = true },
      indent = { enable = true },
    })
  end
}

local neoSplashAlphaPlugin = {
    'goolord/alpha-nvim',
    config = function ()
        require'alpha'.setup(require'alpha.themes.startify'.config)
    end
}


local troublePlugin = {
 "folke/trouble.nvim",
 dependencies = { "nvim-tree/nvim-web-devicons" },
 opts = {
  -- your configuration comes here
  -- or leave it empty to use the default settings
  -- refer to the configuration section below
 },
}

local octoPlugin = {
  'pwntester/octo.nvim',
  requires = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
    -- OR 'ibhagwan/fzf-lua',
    'nvim-tree/nvim-web-devicons',
  },
  config = function ()
    require"octo".setup()
  end
}

local neoCommentPlugin = {
    'numToStr/Comment.nvim',
    opts = {
        -- add any options here
    },
    lazy = false,
}

local noicePlugin = {
    "folke/noice.nvim",
    config = function()
      require("noice").setup({
        -- add any options here
        routes = {
          {
            filter = {
              event = 'msg_show',
              any = {
                { find = '%d+L, %d+B' },
                { find = '; after #%d+' },
                { find = '; before #%d+' },
                { find = '%d fewer lines' },
                { find = '%d more lines' },
              },
            },
            opts = { skip = true },
          }
        },
      })
    end,
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    }
  }

local catpPuccinColorPlugin = { "catppuccin/nvim", name = "catppuccin", priority = 1000 }

local zenModePlugin = {
  "folke/zen-mode.nvim",
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }
}

local autoSavePlugin =   {
    "Pocco81/auto-save.nvim",
    config = function()
      require("auto-save").setup({enable = true})
    end,
    lazy = false
  }

local vimFugitivePlugin = {
  "tpope/vim-fugitive",
  config = function()
    vim.cmd("let g:fugitive#blame#date_format = '%r'")
  end,
  dependencies = {
    "tpope/vim-rhubarb",
  }
}

-- ######################
-- Init Lazy with Plugins
-- ######################
--
local myLazyPlugins = {
  neoTreePlugin,
  telescopePlugin,
  luaLinePlugin,
  whichKey,
  nvimTreesitterPlugin,
  -- noicePlugin,
  neoSplashAlphaPlugin,      -- Neo alpha splash screen
  indentPlugin,
  troublePlugin,             -- Trouble plugin
  --'navarasu/onedark.nvim',   -- Nice color theme
  catpPuccinColorPlugin,     -- Catppuccin color theme
  'akinsho/toggleterm.nvim', -- Terminal
  'neovim/nvim-lspconfig',   -- LSP config
  'lewis6991/gitsigns.nvim', -- gitsigns
  'kassio/neoterm',          -- API for the Term
  vimFugitivePlugin,      -- The best git plugin
  'github/copilot.vim',      -- Github Copilot plugin
  octoPlugin,                -- Manage the Github reviews
  neoCommentPlugin,          -- Comment plugin
  zenModePlugin,             -- Zen mode
  autoSavePlugin,            -- Auto save
}

local myLazyOptions = {
  install = {
    missing = true,
  }
}

require("lazy").setup(myLazyPlugins, myLazyOptions)
