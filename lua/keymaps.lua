-- define common options
local opts = {
    noremap = true,      -- non-recursive
    silent = true,       -- do not show message
}

-----------------
-- Normal mode --
-----------------

-- Hint: see `:h vim.map.set()`
-- Better window navigation
vim.keymap.set('n', '<A-h>', '<C-w>h', opts)
vim.keymap.set('n', '<A-j>', '<C-w>j', opts)
vim.keymap.set('n', '<A-k>', '<C-w>k', opts)
vim.keymap.set('n', '<A-l>', '<C-w>l', opts)
vim.keymap.set('n', '<C-j>', '5j', opts)
vim.keymap.set('n', '<C-k>', '5k', opts)
vim.keymap.set('n', '<C-s>', ':w<CR>', opts)

vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>', opts)
-- bufferline tab switch
vim.keymap.set("n", "<C-h>", ":BufferLineCyclePrev<CR>", opt)
vim.keymap.set("n", "<C-l>", ":BufferLineCycleNext<CR>", opt)

-- Resize with arrows
-- delta: 2 lines
vim.keymap.set('n', '<C-Up>', ':resize -2<CR>', opts)
vim.keymap.set('n', '<C-Down>', ':resize +2<CR>', opts)
vim.keymap.set('n', '<C-Left>', ':vertical resize -2<CR>', opts)
vim.keymap.set('n', '<C-Right>', ':vertical resize +2<CR>', opts)

-----------------
-- Visual mode --
-----------------

-- Hint: start visual mode with the same area as the previous area and the same mode
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)
vim.keymap.set('v', '<C-j>', '5j', opts)
vim.keymap.set('v', '<C-k>', '5k', opts)

-----------------
-- Insert mode --
-----------------

-- Hint: start visual mode with the same area as the previous area and the same mode
vim.keymap.set('i', '<C-s>', '<Esc>:w<CR>a', opts)