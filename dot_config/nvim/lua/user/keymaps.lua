-- <C>    Represents the control key
-- <A>    Represents the alt key.
-- <C-S>  Represents the control + shift key
--
vim.g.mapleader = " "                   -- Space is the leader key

local set = require("user.common").set
local cmd = vim.cmd

-- Actions
set('n', '<C-q>', cmd.quit, "Simple Quit")

-- Windows
set('n', '\\', cmd.vs, "VSplit current window")
set('n', '-', cmd.split, "HSplit current window")

set('n', '<C-k>', '<C-w>k')             -- Move window above
set('n', '<C-j>', '<C-w>j')             -- Move window below
set('n', '<C-h>', '<C-w>h')             -- Move window left
set('n', '<C-l>', '<C-w>l')             -- Move window right

-- Decrease current window height
set('n', '<leader><Up>', [[<cmd>horizontal resize +5<cr>]])
set('n', '<leader><Down>', [[<cmd>horizontal resize -5<cr>]])
set('n', '<leader><Right>', [[<cmd>vertical resize +5<cr>]])
set('n', '<leader><Left>', [[<cmd>vertical resize -5<cr>]])
-- Tabs
set('n', '<A-t>', cmd.tabnew, "Create new tab")
set('n', '<A-q>', cmd.tabclose, "Close tab")
set('n', '<A-h>', cmd.tabprevious, "Previous Tab")
set('n', '<A-l>', cmd.tabnext, "Next Tab")

-- Buffers
set('n', '<A-j>', cmd.bprevious)     -- Previous buffer
set('n', '<S-Tab>', cmd.bprevious)   -- Previous buffer
set('n', '<Tab>', cmd.bnext)         -- Next buffer
set('n', '<A-k>', cmd.bnext)         -- Next buffer
set('n', '<A-Del>', cmd.bdel)        -- Delete buffer
set('n', '<S-Down>', cmd.buffers)    -- List of buffers
set('n', '<S-Up>', ":buffer ")       -- Go to buffer

-- Utilities
set('i', '<C-Space>', '<C-x><C-o>')           -- Omnicomplete
set('i', '<C-c>', '<ESC>:wa<CR>', "Save all files")         -- Save all files (insert mode)
set('n', '<C-c>', '<ESC>:wa<CR>', "Save all files")         -- Save all files (normal mode)
set('n', '<leader>?', cmd.map)        -- Show the keymaps help
-- set('n', '<leader>f', ':find')            -- Find a file
set('n', '<leader>e', ':Neotree filesystem reveal left toggle<CR>', "Toggle Neotree")  -- Show the explorer
-- set('n', '<leader>e', '<F2>')
set('n', '<F3>', ':set list!<CR>', "Toggle list")        -- Toggle list
set('n', '<F4>', ':set hls!<CR>', "Toggle highlight search")         -- Toggle highlight search

local sub=':%s/<C-r><C-w>//g<Left><Left>'
set('n', '<leader>r', sub, "Replace current word");               -- Replace under the cursor


-- Visual Mode
set('v', '<leader>r', ':s/')              -- Replace
set('v', '<leader>y', '"+y')              -- Yank selection to the clipboard
set('v', '<leader>d', '"_d')              -- Delete section to void register
set('v', '<leader>p', '"_dP')             -- Delete section to void register and paste over it

-- Movements
set('n', 'J', 'mzJ`z', "Join lines keeping cursor in place")                    -- Join the lines keeping the cursor in place
set('n', '<C-u>', '<C-u>M', "Scroll half page up")               -- Scroll half page UP keeping the cursor in the middle
set('n', '<C-d>', '<C-d>M', "Scroll half page down")               -- Scroll half page DOWN keeping the cursor in the middle
set('n', 'N', 'Nzzzv', "Search backward")                    -- Search backward keeping the cursor in the middle
set('n', 'n', 'nzzzv', "Search forward")                    -- Search forward keeping the cursor in the middle


-- Location List
set('n', '<C-PageUP>', cmd.lprev)     -- Previous in navigation list
set('n', '<C-PageDOWN>', cmd.lnext)   -- Next in navigation list

-- My hacks
set('n', 'yy', 'Vyj^P')               -- Duplicate the current line

-- Disable arrow keys!
set('n', '<Up>', '<Nop>')
set('n', '<PageUp>', '<Nop>')
set('n', '<Left>', '<Nop>')
set('n', '<Right>', '<Nop>')
set('n', '<Down>', '<Nop>')
set('n', '<PageDown>', '<Nop>')

-- Reload and edit the VIM RC
set("n", "<leader>ns", ":source $MYVIMRC<CR>")

-- Terminal mode
set("t", "<Esc>", "<C-\\><C-n>")    -- terminal mode esc = normal mode
set("t", "<leader><Esc>", "<Esc>")     -- now map esc to ctrl+v esc

-- Easier navigation for long lines
set("n", "j", "gj")
set("n", "k", "gk")


set("n", "<leader>z", ":ZenMode<CR>")
