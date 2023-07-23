-- options
require("core.options")
-- autocommands
require("core.autocmds")
-- plugins
require("core.lazy")
-- keymaps
require("core.keymaps")
--nvim-tree
require('nvim-tree').setup()
--bufferline
vim.opt.termguicolors = true
require("bufferline").setup{}

