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

-- Keybinds
local map = vim.api.nvim_set_keymap
local opts = { silent = true, noremap = true }

g.mapleader = ' '

-- Plugins
map("n", "-", "<CMD>Oil<CR>", opts)
map('n', '<C-n>', ':Telescope live_grep <CR>', opts)
map('n', '<C-f>', ':Telescope find_files <CR>', opts)

-- Buffers
map('n', '<C-h>', "<C-w>h", opts)
map('n', '<C-j>', "<C-w>j", opts)
map('n', '<C-k>', "<C-w>k", opts)
map('n', '<C-l>', "<C-w>l", opts)

-- Save
map('n', '<C-s>', ':w<cr>', opts)

-- Clear search
map('n', '<C-x>', '<CMD>:noh<CR>', opts)

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

-- Insert line
map('n', '<CR>', 'mzo<Esc>`z', opts)
map('n', '<C-CR>', 'i<CR><Esc>k$', opts)
map('n', 'J', 'mzJ`z', opts)

-- Go to beginning or end of line
map('n', 'H', '^', opts)
map('n', 'L', '$', opts)

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
o.shiftround = true
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

