-- <C>    Represents the control key
-- <A>    Represents the alt key.
-- <C-S>  Represents the control + shift key
local set = vim.keymap.set

vim.g.mapleader = " "                   -- Space is the leader key

-- Actions
set('n', '<C-q>', vim.cmd.quit)        -- Simple quit

-- Windows
set('n', '<leader>\\', vim.cmd.vs)      -- Vertical split
set('n', '<leader>-', vim.cmd.split)    -- Horizontal split

set('n', '<C-k>', '<C-w>k')             -- Move window above
set('n', '<C-j>', '<C-w>j')             -- Move window below
set('n', '<C-h>', '<C-w>h')             -- Move window left
set('n', '<C-l>', '<C-w>l')             -- Move window right

-- Decrease current window height
set('n', '<C-S-Up>', [[<cmd>horizontal resize +5<cr>]])
set('n', '<C-S-Down>', [[<cmd>horizontal resize -5<cr>]])
set('n', '<C-S-Left>', [[<cmd>vertical resize +5<cr>]])
set('n', '<C-S-Right>', [[<cmd>vertical resize -5<cr>]])

-- Tabs
set('n', '<C-t>', vim.cmd.tabnew)         -- New tab
set('n', '<C-w>', vim.cmd.tabclose)       -- Close tab
set('n', '<C-p>', vim.cmd.tabprevious)    -- Previous tab
set('n', '<C-n>', vim.cmd.tabnext)        -- Next tab

-- Buffers
set('n', '<S-Left>', vim.cmd.bprevious)   -- Previous buffer
set('n', '<S-Right>', vim.cmd.bnext)      -- Next buffer
set('n', '<S-Del>', vim.cmd.bdel)         -- Delete buffer
set('n', '<S-Down>', vim.cmd.buffers)     -- List of buffers
set('n', '<S-Up>', ":buffer ")            -- Go to buffer

-- Utilities
-- set('i', '<Tab>', '<C-x><C-o>')           -- Omnicomplete
set('i', '<C-c>', '<ESC>:wa<CR>')         -- Save all files (insert mode)
set('n', '<C-c>', '<ESC>:wa<CR>')         -- Save all files (normal mode)
set('n', '<leader>?', vim.cmd.map)        -- Show the keymaps help
set('n', '<leader>f', ':find')            -- Find a file
set('n', '<leader>e', ':Lex 18<CR>')      -- Show the explorer
set('n', '<F3>', ':set list!<CR>')        -- Toggle list
set('n', '<F4>', ':set hls!<CR>')         -- Toggle highlight search

local sub=':%s/<C-r><C-w>//g<Left><Left>'
set('n', '<leader>r', sub);               -- Replace under the cursor


-- Visual Mode
set('v', '<leader>r', ':s/')              -- Replace
set('v', '<leader>y', '"+y')              -- Yank selection to the clipboard
set('v', '<leader>d', '"_d')              -- Delete section to void register
set('v', '<leader>p', '"_dP')             -- Delete section to void register and paste over it

-- Movements
set('n', 'J', 'mzJ`z')                    -- Join the lines keeping the cursor in place
set('n', '<C-u>', '<C-u>M')               -- Scroll half page UP keeping the cursor in the middle
set('n', '<C-d>', '<C-d>M')               -- Scroll half page DOWN keeping the cursor in the middle
set('n', 'N', 'Nzzzv')                    -- Search backward keeping the cursor in the middle
set('n', 'n', 'nzzzv')                    -- Search forward keeping the cursor in the middle


-- Location List
set('n', '<C-PageUP>', vim.cmd.lprev)     -- Previous in navigation list
set('n', '<C-PageDOWN>', vim.cmd.lnext    -- Next in navigation list

-- My hacks
set('n', 'yy', 'Vyo<ESC>P')             -- Duplicate the current line

-- Disable arrow keys!
set('n', '<Up>', '<Nop>')
set('n', '<PageUp>', '<Nop>')
set('n', '<Left>', '<Nop>')
set('n', '<Right>', '<Nop>')
set('n', '<Down>', '<Nop>')
set('n', '<PageDown>', '<Nop>')
