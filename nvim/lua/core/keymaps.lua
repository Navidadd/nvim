-- keymaps

local api = vim.api
-- delete previous word in insert mode
--vim.keymap.set("i", "<C-BS>", "<C-W>")
-- unindent in insert mode
--vim.keymap.set("i", "<S-Tab>", "<C-d>")

-- change directory
--vim.keymap.set('n', "<leader>cd", function()
--  vim.cmd(':cd ' .. vim.fn.expand("%:p:h"))
--  print(vim.fn.getcwd())
--end
--)

-- vanilla buffer switcher
-- vim.keymap.set('n', '<leader>b', ':set nomore <Bar> echo "Open buffers:" <Bar> :buffers <Bar> :set more <CR>:b<Space>')


-- TODO: write this in lua
-- find and replace on current selection
-- snippet written by Bryan Kennedy and Peter Butkovic
-- https://stackoverflow.com/a/6171215/14111707
vim.cmd [[
" Escape special characters in a string for exact matching.
" This is useful to copying strings from the file to the search tool
" Based on this - http://peterodding.com/code/vim/profile/autoload/xolox/escape.vim
function! EscapeString (string)
  let string=a:string
  " Escape regex characters
  let string = escape(string, '^$.*\/~[]')
  " Escape the line endings
  let string = substitute(string, '\n', '\\n', 'g')
  return string
endfunction

" Get the current visual block for search and replaces
" This function passed the visual block through a string escape function
" Based on this - https://stackoverflow.com/questions/676600/vim-replace-selected-text/677918#677918
function! GetVisual() range
  " Save the current register and clipboard
  let reg_save = getreg('"')
  let regtype_save = getregtype('"')
  let cb_save = &clipboard
  set clipboard&

  " Put the current visual selection in the " register
  normal! ""gvy
  let selection = getreg('"')

  " Put the saved registers and clipboards back
  call setreg('"', reg_save, regtype_save)
  let &clipboard = cb_save

  "Escape any special characters in the selection
  let escaped_selection = EscapeString(selection)

  return escaped_selection
endfunction

" Start the find and replace command across the entire file
vnoremap <C-r> <Esc>:%s/<c-r>=GetVisual()<cr>//g<left><left>
]]



-- Agregar keybinding para abrir o cerrar NvimTree con Ctrl+E
vim.keymap.set("n", "<C-e>", ":NvimTreeToggle<CR>", { silent = true })

-- switch tabs quickly
vim.keymap.set("n", "<leader>1", "1gt<CR>")
vim.keymap.set("n", '<leader>2', "2gt<CR>")
vim.keymap.set("n", "<leader>3", "3gt<CR>")
vim.keymap.set("n", '<leader>4', "4gt<CR>")
vim.keymap.set("n", "<leader>5", "5gt<CR>")
vim.keymap.set("n", "<leader>6", "6gt<CR>")
vim.keymap.set("n", "<leader>7", "7gt<CR>")
vim.keymap.set("n", "<leader>8", "8gt<CR>")
vim.keymap.set("n", "<leader>9", "9gt<CR>")

-- open a tab
--vim.keymap.set("n", "<leader>t", ":tabnew<CR>")
-- close a tab
--vim.keymap.set("n", "<leader>x", ":tabclose<CR>")

-- Resize splits with ctrl + arrows
--vim.keymap.set("n", "<C-Up>", ":resize +2<CR>")
--vim.keymap.set("n", "<C-Down>", ":resize -2<CR>")
--vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>")
--vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>")

-- easier copying and pasteing into clipboard
--vim.keymap.set({ "n", "v" }, "<leader>y", '"+y')
--vim.keymap.set({ "n", "v" }, "<leader>d", '"+d')
--vim.keymap.set({ "n", "v" }, "<leader>p", '"+p')
--vim.keymap.set({ 'n', 'v' }, '<leader>P', '"+P')

-- don't lose selection when shifting text
vim.keymap.set("x", "<", "<gv")
vim.keymap.set("x", ">", ">gv")

-- BUFFERS RELATED
  vim.api.nvim_set_keymap("i", "<C-b>", ":BufferLineCycleNext<CR>", { noremap = true, silent = true }) -- next buffer insert
  vim.api.nvim_set_keymap("n", "<C-b>", ":BufferLineCycleNext<CR>", { noremap = true, silent = true }) -- next buffer normal
  --vim.api.nvim_set_keymap("i", "<C-b>l", ":buffers<CR>", { noremap = true, silent = true }) -- list buffers 

  -- create a new buffer
  --vim.keymap.set("", "<C-b>n", ":enew<CR>")
  -- delete a buffer
  --vim.keymap.set("i", "<C-b>d", ":BufferLinePickClose<CR>")
  --vim.keymap.set("n", "<C-b>d", ":BufferLinePickClose<CR>")

  -- Directories


-- Definir función para crear carpeta con path absoluto
local function CreateFolderWithAbsolutePath()
    -- Copiar el path absoluto al portapapeles usando la tecla gy
    api.nvim_command([[normal! gy]])

    -- Pedir al usuario el nombre de la carpeta
    local folder_name = api.nvim_call_function("input", {"Enter folder name: "})

    -- Obtener el contenido del portapapeles (que es el path absoluto copiado previamente)
    local clipboard_content = api.nvim_call_function("getreg", {"+"})

    -- Concatenar el nombre de la carpeta al path absoluto
    local folder_path = clipboard_content .. "/" .. folder_name

    -- Crear la carpeta usando el comando mkdir
    api.nvim_call_function("mkdir", {folder_path, "p"})

    -- Imprimir mensaje de éxito
    print("Folder '" .. folder_name .. "' created at '" .. folder_path .. "'")
end

-- Mapear <leader>d a la función personalizada
vim.keymap.set("n", "<leader>d", CreateFolderWithAbsolutePath, {noremap = true, silent = true})
