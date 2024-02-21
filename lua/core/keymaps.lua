-- keymaps

local api = vim.api

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

-- Mapear Ctrl+C para copiar texto seleccionado al portapapeles en modo visual e insert
  vim.api.nvim_set_keymap('v', '<C-c>', '"+y', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('i', '<C-c>', '<Esc>"+ybi', { noremap = true, silent = true })

  -- Mapear Ctrl+V para pegar desde el portapapeles en modo visual e insert
  vim.api.nvim_set_keymap('v', '<C-v>', '"+p', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('i', '<C-v>', '<C-r>+', { noremap = true, silent = true })

  -- Mapear Ctrl+X para cortar texto seleccionado al portapapeles en modo visual e insert
  vim.api.nvim_set_keymap('v', '<C-x>', '"+x', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('i', '<C-x>', '<Esc>"+ybd', { noremap = true, silent = true })


--intento de navegacion optimizada
  -- Mover el cursor hacia la derecha al final de la palabra
  -- cuando se presiona CTRL + Flecha hacia la derecha
  vim.api.nvim_set_keymap('i', '<C-Right>', '<Esc>ea', { noremap = true, silent = true })

  -- Mover el cursor hacia la izquierda al inicio de la palabra
  -- cuando se presiona CTRL + Flecha hacia la izquierda
  vim.api.nvim_set_keymap('i', '<C-Left>', '<Esc>bi', { noremap = true, silent = true })

  -- Configurar las combinaciones de teclas para el modo insert
  --vim.api.nvim_set_keymap('i', '<C-S-Right>', '<C-O>w', { noremap = true })
  --vim.api.nvim_set_keymap('i', '<C-S-Left>', '<C-O>b', { noremap = true })
  vim.api.nvim_set_keymap('i', '<C-S-Right>', '<Esc>vea', { noremap = true })
  vim.api.nvim_set_keymap('i', '<C-S-Left>', '<Esc>vbe', { noremap = true })

-- Agregar keybinding para abrir NvimTree con Ctrl+E
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

-- don't lose selection when shifting text
  --vim.keymap.set("x", "<", "<gv")
  --vim.keymap.set("x", ">", ">gv")

-- BUFFERS RELATED KEYMAPS
  vim.api.nvim_set_keymap("i", "<C-b>", ":BufferLineCycleNext<CR>", { noremap = true, silent = true }) -- next buffer insert
  vim.api.nvim_set_keymap("n", "<C-b>", ":BufferLineCycleNext<CR>", { noremap = true, silent = true }) -- next buffer normal

  -- Directories
  function create_directory()
    -- Obtener el path absoluto de la carpeta actual en NvimTree
    local target_path = require'nvim-tree.lib'.get_node_at_cursor().absolute_path

    -- Pedir al usuario que ingrese el nombre del directorio
    local new_directory_name = vim.fn.input("Enter directory name: ")
    if new_directory_name == "" then
        print("Directory name cannot be empty.")
        return
    end

    -- Concatenar el path absoluto con el nombre del directorio
    local new_directory_path = target_path .. "/" .. new_directory_name

    -- Ejecutar el comando para crear el directorio
    vim.cmd("Mkdir " .. new_directory_path)

    -- Actualizar la vista de NvimTree
    vim.cmd("NvimTreeRefresh")
end

-- Asignar la función al keymap
vim.api.nvim_set_keymap("n", "<leader>cd", ":lua create_directory()<CR>", { noremap = true, silent = true }) -- nvimtree space+cd creates directory

