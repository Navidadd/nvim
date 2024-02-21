-- plugins
return {
  --
  -- unix helpers
  {
    "tpope/vim-eunuch",
    cmd = {
      "Remove",
      "Unlink",
      "Delete",
      "Copy",
      "Duplicate",
      "Move",
      "Rename",
      "Chmod",
      "Mkdir",
      "Cfind",
      "Lfind",
      "Clocate",
      "Llocate",
      "SudoEdit",
      "SudoWrite",
      "Wall",
      "W",
    }
  },
  { "tpope/vim-unimpaired", keys = { "[", "]" } },
  
  -- better git integration
  {
    "lewis6991/gitsigns.nvim",
    cond = vim.fn.executable("git") == 1,
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("plugins.gitsigns")
    end
  },
  
  -- status bar
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = function()
      require("plugins.lualine")
    end,
    dependencies = "nvim-tree/nvim-web-devicons"
  },
  -- conveniently run git commands from vim
  {
    "tpope/vim-fugitive",
    cond = vim.fn.executable("git") == 1,
    cmd = {
      "G",
      "Git",
      "Ggrep",
      "Glgrep",
      "Gclog",
      "Gllog",
      "Gcd",
      "Glcd",
      "Gedit",
      "Gvsplit",
      "Gtabedit",
      "Gpedit",
      "Gdrop",
      "Gread",
      "Gwrite",
      "Gwq",
      "Gdiffsplit",
      "Ghdiffsplit",
      "GMove",
      "GRename",
      "GDelete",
      "GRemove",
      "GUnlink",
      "GBrowse"
    }
  },

  { "tpope/vim-repeat", event = "VeryLazy" },
  
  -- git commit browser
  {
    "junegunn/gv.vim",
    cond = vim.fn.executable("git") == 1,
    cmd = { "GV" },
    dependencies = { "tpope/vim-fugitive" }
  },
  -- commenter
  {
    "numToStr/Comment.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    keys = { "gc", "gb", { "gc", mode = "v" }, { "gb", mode = "v" } },
    config = true,
  },
  -- indent guides
  --{
  --  "lukas-reineke/indent-blankline.nvim",
  --  event = { "BufReadPost", "BufNewFile" },
  --  dependencies = { "nvim-treesitter/nvim-treesitter" },
  --  opts = {
  --    show_current_context = true,
  --    show_current_context_start = true,
  --  }
  --},
  -- zen mode
  
  --GIT
  { "NeogitOrg/neogit", dependencies = "nvim-lua/plenary.nvim", config = true },

  {
    "folke/zen-mode.nvim",
    keys = {
      { "<leader>z", function() require("zen-mode").toggle() end }
    },
    cmd = { "ZenMode" },
    config = true,
  },
  -- parentheses colorizer
  {
    "junegunn/rainbow_parentheses.vim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      vim.cmd [[RainbowParentheses]]
    end
  },
  -- turn off search highlighting automatically
  {
    "romainl/vim-cool",
    -- load vim-cool when doing a search
    keys = {
      "/",
      "?",
      "n",
      "N",
      "*",
      "#",
      { "*", mode = "v" },
      { "#", mode = "v" },
      "g*",
      "g#",
    }
  },
  -- lsp and completion stuff
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("plugins.lsp")
    end
  },
  {
    "williamboman/mason.nvim",
    cmd = {
      "Mason",
      "MasonInstall",
      "MasonUninstall",
      "MasonUninstallAll",
      "MasonLog"
    },
    config = true,
    dependencies = {
      {
        "williamboman/mason-lspconfig.nvim",
        dependencies = "neovim/nvim-lspconfig",
        opts = {
          automatic_installation = true,
        }
      }
    }
  },
  {
    "glepnir/lspsaga.nvim",
    event = "LspAttach",
    cmd = "Lspsaga",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "nvim-treesitter/nvim-treesitter"
    },
    opts = {
      lightbulb = {
        sign = false
      }
    },
    keys = {
      { "gh",         "<cmd>Lspsaga lsp_finder<CR>" },
      { "<leader>ca", mode = { "n", "v" }, "<cmd>Lspsaga code_action<CR>" },
      { "<leader>rn", "<cmd>Lspsaga rename<CR>" },
      { "<leader>Rn", "<cmd>Lspsaga rename ++project<CR>" },
      { "gd",         "<cmd>Lspsaga goto_definition<CR>" },
      { "gD",         "<cmd>Lspsaga peek_definition<CR>" },
      { "gt",         "<cmd>Lspsaga goto_type_definition<CR>" },
      { "gT",         "<cmd>Lspsaga peek_type_definition<CR>" },
      { "gl",  "<cmd>Lspsaga show_line_diagnostics<CR>" },
      { "[d",         "<cmd>Lspsaga diagnostic_jump_prev<CR>" },
      { "]d",         "<cmd>Lspsaga diagnostic_jump_next<CR>" },
      { "[E",         function() require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR }) end },
      { "]E",         function() require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR }) end },
      { "<leader>o",  "<cmd>Lspsaga outline<CR>" },
      { "K",          "<cmd>Lspsaga hover_doc<CR>" },
      { "<A-d>",      mode = { "n", "v" },                                                                                 "<cmd>Lspsaga term_toggle<CR>" }
    }
  },
  {
    "hrsh7th/nvim-cmp",
    config = function()
      require("plugins.cmp")
    end,
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
       "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      "nvim-tree/nvim-web-devicons"
    }
  },
  {
    "hrsh7th/cmp-cmdline",
    event = "CmdlineEnter",
    dependencies = "hrsh7th/nvim-cmp"
  },
  {
    "hrsh7th/cmp-nvim-lua",
    ft = "lua",
    dependencies = "hrsh7th/nvim-cmp"
  },
  {
    "hrsh7th/cmp-calc",
    event = { "InsertEnter" },
    dependencies = "hrsh7th/nvim-cmp"
  },
  {
    "hrsh7th/cmp-emoji",
    keys = { ":", mode = "i" },
    dependencies = "hrsh7th/nvim-cmp"
  },
  
  {
    "L3MON4D3/LuaSnip",
    event = "InsertEnter",
    config = function()
      require("luasnip")
    end,
    dependencies = {
      {
        "rafamadriz/friendly-snippets",
        config = function()
          require("luasnip/loaders/from_vscode").lazy_load()
        end
      },
    }
  },
  --{
  --  "folke/neodev.nvim",
  --  ft = "lua",
  --  config = function()
  --    require("neodev").setup()
  --      vim.lsp.start({
  --        name = "lua-language-server",
  --        cmd = { "lua-language-server" },
  --        before_init = require("neodev.lsp").before_init,
  --        root_dir = vim.fn.getcwd(),
  --        settings = { Lua = {} },
  --      })
  --  end
  --},

  { "mfussenegger/nvim-jdtls", ft = "java" },
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    config = true,
    dependencies = "nvim-tree/nvim-web-devicons",
    keys = {
      { "<leader>q", "<cmd>Trouble<CR>" },
    }
  },
  -- improved syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    cond = (vim.fn.executable("git") == 1 or (vim.fn.executable("curl") == 1 and vim.fn.executable("tar") == 1)),
    cmd = {
      "TSBufDisable",
      "TSBufEnable",
      "TSBufToggle",
      "TSConfigInfo",
      "TSDisable",
      "TSEditQuery",
      "TSEditQueryUserAfter",
      "TSEnable",
      "TSInstall",
      "TSInstallFromGrammar",
      "TSInstallInfo",
      "TSInstallSync",
      "TSModuleInfo",
      "TSToggle",
      "TSUninstall",
      "TSUpdate",
      "TSUpdateSync",
    },
    init = function()
      if vim.fn.argc() >= 1 then
        require("lazy").load({ plugins = { "nvim-treesitter" } })
      end
    end,
    config = function()
      require("plugins.treesitter")
    end
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("treesitter-context").setup({
        enable = true,
        mode = "cursor",
      })
      vim.cmd [[TSContextEnable]]
    end,
    dependencies = "nvim-treesitter/nvim-treesitter"
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = "nvim-treesitter/nvim-treesitter"
  },
  -- automatically close pairs
  {
    "windwp/nvim-autopairs",
    -- load when starting bracket delimiter is pressed
    keys = {
      { "(", mode = "i" },
      { "{", mode = "i" },
      { "[", mode = "i" },
      { '"', mode = "i" },
      { "'", mode = "i" }
    },
    config = true,
  },
  -- start screen
  {
    "goolord/alpha-nvim",
    cmd = "Alpha",
    init = function()
      if vim.fn.argc() == 0 then
        vim.cmd [[
        autocmd UIEnter * :Alpha
        ]]
      end
    end,
    config = function()
      require("plugins.alpha")
    end,
    dependencies = "nvim-tree/nvim-web-devicons"
  },
  -- fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<leader>ff",       function() require("telescope.builtin").find_files() end },
      { "<leader>fg",       function() require("telescope.builtin").live_grep() end },
      { "<leader><leader>", function() require("telescope.builtin").buffers() end },
      { "<leader>fh",       function() require("telescope.builtin").help_tags() end },
      { "<leader>fd",       function() require("telescope.builtin").diagnostics() end },
      { "<leader>fo",       function() require("telescope.builtin").oldfiles() end },
    },
    cmd = { "Telescope" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
      {
        -- increase telescope search speed
        "nvim-telescope/telescope-fzf-native.nvim",
        cond = vim.fn.executable("make") == 1,
        build = "make",
        config = function()
          require("telescope").load_extension("fzf")
        end
      }
    },
    config = function()
      ---@diagnostic disable-next-line: different-requires
      require("plugins.telescope")
    end
  },
  -- improved movement
  --{
  --  "ggandor/leap.nvim",
  --  keys = {
  --    { "s",  mode = { "n", "x", "o" } },
  --    { "S",  mode = { "n", "x", "o" } },
  --    { "gs", mode = { "n", "x", "o" } },
  --  },
  --  config = function()
  --    require("leap").set_default_keymaps()
  --  end
  --},
  {
    "wellle/targets.vim",
    event = "VeryLazy"
  },
  

  -- icons
  "nvim-tree/nvim-web-devicons",


  -- COLORSCHEME

  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000
  },

  --{
  --  "xero/miasma.nvim",
  --  lazy = false,
  --  priority = 1000,
  --  config = function()
  --    vim.cmd("colorscheme miasma")
  --  end,
  --},
  
  -- NEW IMPLEMENTATIONS OF PLUGINS MIO YO MISMO  
      -- Bufferline
      {'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons'},

    --Nvim tree
    {
        'nvim-tree/nvim-tree.lua',
        lazy = true,
        dependencies = {
            'nvim-tree/nvim-web-devicons',
        },
    },  
}
