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
map('n', '<C-n>', 'mP<CMD>Telescope live_grep <CR>', opts)
map('n', '<C-f>', 'mP<CMD>Telescope find_files <CR>', opts)
map('n', '<C-n>', 'mP<CMD>Telescope live_grep <CR>', opts)
map('n', '<c-m>', 'mP<CMD>Trouble diagnostics open focus=1<CR>', opts)

-- Terminal
map('n', '<C-\\>', '<CMD>FloatermToggle<CR>', opts)
map('t', '<C-\\>', '<CMD>FloatermToggle<CR>', opts)
map('t', '<C-]>', '<CMD>FloatermNext<CR>', opts)
map('t', '<C-[>', '<CMD>FloatermPrev<CR>', opts)
map('t', '<C-S-[>', '<CMD>FloatermKill<CR><CMD>silent FloatermShow<CR>', opts)
map('t', "<C-S-]>", '<CMD>FloatermNew<CR>', opts)

-- Save
map('n', '<C-s>', '<CMD>silent lua vim.lsp.buf.format()<CR>:w<cr>', opts)

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

-- Tab
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts) 

-- Harpoon
local harpoon = require('harpoon')
vim.keymap.set("n", "=", function() harpoon:list():add() end)

for n = 1, 9 do
    vim.keymap.set("n", ""..n..n, "mP<cmd>lua require('harpoon'):list():select("..n..")<cr>")
end

local border = {
  {"╭", "FloatBorder"},
  {"─", "FloatBorder"},
  {"╮", "FloatBorder"},
  {"│", "FloatBorder"},
  {"╯", "FloatBorder"},
  {"─", "FloatBorder"},
  {"╰", "FloatBorder"},
  {"│", "FloatBorder"},
}
vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list(), {
    border = border,
    title = {{" Harpoon ", "FloatBorder"}},
    title_pos = "center",
}) end)

vim.api.nvim_set_keymap('n', '<F2>', '<cmd>lua require("renamer").rename()<cr>', opts)

-- Commenting
map('n', '<C-/>', ':Commentary<CR>', opts)
map('v', '<C-/>', ":'<,'>Commentary<CR>", opts)

-- Others
require('nvim-autopairs').setup()
vim.keymap.set({'v', 'n'}, '<C-.>', require("actions-preview").code_actions)
vim.keymap.set('n','gD','mP<cmd>lua vim.lsp.buf.declaration()<CR>')
vim.keymap.set('n','gd','mP<cmd>lua vim.lsp.buf.definition()<CR>')
vim.keymap.set('n','gt','mP<cmd>lua vim.lsp.buf.type_definition()<CR>')
vim.keymap.set('n','gr',"mP<cmd>lua require('telescope.builtin').lsp_references()<CR>")
vim.keymap.set('n','L','<cmd>lua vim.diagnostic.open_float()<CR>')
vim.keymap.set('n','S','<cmd>lua vim.lsp.buf.signature_help()<CR>')
vim.keymap.del('n','<c-W>d')
vim.keymap.set('n','K', vim.lsp.buf.hover)
vim.keymap.set('n','[d','mP<cmd>lua vim.diagnostic.goto_next()<cr>')
vim.keymap.set('n',']d','mP<cmd>lua vim.diagnostic.goto_prev()<cr>')

-- Go back
vim.keymap.set('n', '<Backspace>', "'P", opts);

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

