local opt = vim.opt
local cwd = vim.fn.getcwd()
local current_path = ""..cwd..", "..cwd.."/**"

opt.shortmess = "I"		  -- Remove splashscreen
opt.number = true		    -- Show line numbers
opt.cursorline = true		-- Show cursor line
opt.wrap = false		    -- Do not wrap text

-- Autocomplete
-- show menu even with only one entry, do not select nor insert, show a preview
opt.completeopt = "menuone,noselect,noinsert,preview"
opt.complete = "."		-- Only use current buffer for autocomplete
opt.pumheight = 10		-- Height of the pop up window

-- Indentation
opt.smartindent = true		-- Check the code to determine the auto indent
opt.autoindent = true		  -- Adjust indent while typing
opt.tabstop = 2			      -- Show tab as 2 spaces
opt.shiftwidth = 2		    -- Indent of 2 spaces
opt.expandtab = true		  -- Use spaces instead of tabs

opt.undofile = true       -- Persistent history files
opt.splitright = true     -- Split the window on the right of the current one
opt.hlsearch = true       -- Highlights the search
opt.incsearch = true      -- Update search while typing
opt.exrc = true           -- Enable .nvim.lua configuration on the folder
opt.mouse = ""            -- Disable mouse
opt.path = current_path   -- Path to the current working dir
