local toggle = require("trouble").toggle

vim.keymap.set("n", "<leader>xx", function() toggle() end)
vim.keymap.set("n", "<leader>xw", function() toggle("workspace_diagnostics") end)
vim.keymap.set("n", "<leader>xd", function() toggle("document_diagnostics") end)
vim.keymap.set("n", "<leader>xq", function() toggle("quickfix") end)
vim.keymap.set("n", "<leader>xl", function() toggle("loclist") end)
vim.keymap.set("n", "gR", function() toggle("lsp_references") end)
