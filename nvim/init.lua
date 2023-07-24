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

--cursos related
vim.cmd [[
  let &t_ti = "\e[1 q"
  let &t_SI = "\e[5 q"
  let &t_EI = "\e[1 q"
  let &t_te = "\e[0 q"
]]
