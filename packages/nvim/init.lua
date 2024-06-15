vim.loader.enable()

local o = vim.opt
local g = vim.g

-- Autocmds
vim.cmd [[
augroup CursorLine au!
    au VimEnter * setlocal cursorline
    au WinEnter * setlocal cursorline
    au BufWinEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline
augroup END

autocmd FileType nix setlocal shiftwidth=2
]]

-- KEYBINDS --
local map = vim.api.nvim_set_keymap
local opts = { silent = true, noremap = true }
g.mapleader = ' '

-- Navigation
map("n", "-", "<CMD>Oil --float<CR>", opts)
map('n', '<C-n>', '<CMD>Telescope live_grep <CR>', opts)
map('n', '<C-f>', '<CMD>Telescope find_files <CR>', opts)
map('n', '<C-\\>', '<CMD>ToggleTerm<CR>', opts)

-- Buffers
map('n', '<C-h>', "<C-w>h", opts)
map('n', '<C-j>', "<C-w>j", opts)
map('n', '<C-k>', "<C-w>k", opts)
map('n', '<C-l>', "<C-w>l", opts)

-- Save
map('n', '<C-s>', ':w<cr>', opts)

-- Clear search
map('n', '<C-X>', '<CMD>:noh<CR>', opts)

-- Undo breakpoints in insert mode
undobreaks = {
	';',
	',', 
	'.', 
	'!', 
	'?',
	'<CR>',
}
for _, c in ipairs(undobreaks) do
	map('i', c, c..'<c-g>u', opts)
end

-- Keep cursor centered
map('n', 'n', 'nzzzv', opts)
map('n', 'N', 'Nzzzv', opts)
map('n', 'j', 'jzz', opts)
map('n', 'k', 'kzz', opts)
map('n', 'G', 'Gzz', opts)

-- Insert line
map('n', '<CR>', 'mzo<Esc>`z', opts)
map('n', '<C-CR>', 'i<CR><Esc>k$', opts)
map('n', 'J', 'mzJ`z', opts)

-- Go to beginning or end of line
map('n', 'H', '^', opts)
map('n', 'L', '$', opts)

-- Tab
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts) 

-- Harpoon
local harpoon = require('harpoon')
vim.keymap.set("n", "=", function() harpoon:list():add() end)

vim.keymap.set("n", "<C-1>", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<C-2>", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<C-3>", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<C-4>", function() harpoon:list():select(4) end)
vim.keymap.set("n", "<C-5>", function() harpoon:list():select(5) end)
vim.keymap.set("n", "<C-6>", function() harpoon:list():select(6) end)
vim.keymap.set("n", "<C-7>", function() harpoon:list():select(7) end)
vim.keymap.set("n", "<C-8>", function() harpoon:list():select(8) end)
vim.keymap.set("n", "<C-9>", function() harpoon:list():select(9) end)

vim.keymap.set("n", "[[", function() harpoon:list():prev({ui_nav_wrap = true}) end)
vim.keymap.set("n", "]]", function() harpoon:list():next({ui_nav_wrap = true}) end)

vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.api.nvim_set_keymap('n', '<F2>', '<cmd>lua require("renamer").rename()<cr>', opts)

-- Commenting
map('n', '<C-/>', ':Commentary<CR>', opts)
map('v', '<C-/>', ":'<,'>Commentary<CR>", opts)

-- Others
require('nvim-autopairs').setup()
vim.keymap.set({'v', 'n'}, '<C-.>', require("actions-preview").code_actions)
vim.keymap.set('n','gD','<cmd>lua vim.lsp.buf.declaration()<CR>')
vim.keymap.set('n','gd','<cmd>lua vim.lsp.buf.definition()<CR>')

-- OPTIONS --
-- Performance
o.lazyredraw = true;
o.shell = "fish"
o.shadafile = "NONE"

-- Colors
o.termguicolors = true

-- Undo files
o.undofile = true

-- Indentation
o.smartindent = true
o.tabstop = 4
o.shiftwidth = 4
o.shiftround = true;
o.expandtab = true
o.scrolloff = 3

-- Set clipboard to use system clipboard
o.clipboard = "unnamedplus"

-- Use mouse
o.mouse = "a"

-- Nicer UI settings
o.cursorline = true
o.relativenumber = true
o.number = true

-- Get rid of annoying viminfo file
o.viminfo = ""
o.viminfofile = "NONE"

-- Miscellaneous quality of life
o.ignorecase = true
o.ttimeoutlen = 5
o.hidden = true
o.shortmess = "atI"
o.wrap = false
o.backup = false
o.writebackup = false
o.errorbells = false
o.swapfile = false
o.showmode = false
o.laststatus = 3
o.pumheight = 6
o.splitright = true
o.splitbelow = true
o.completeopt = "menuone,noselect"

