-- File Explorer
vim.keymap.set("n", "<leader>jj", "<cmd>Oil<CR>")

-- Open error in new buffer, twice to go to buffer to copy error
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, { noremap = true, silent = true, buffer = bufnr })

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Switch to the next buffer
vim.keymap.set("n", "<leader>kk", ":bnext<CR>", { noremap = true, silent = true })

-- Switch to the previous buffer
vim.keymap.set("n", "<leader>kj", ":bprev<CR>", { noremap = true, silent = true })

-- Toggle between the last two buffers
vim.keymap.set("n", "<leader>kq", ":b#<CR>", { noremap = true, silent = true })

-- TODO: Doesn't work very well
-- Close the terminal buffer, ensuring the main window is unaffected
vim.keymap.set("n", "<leader>kd", function()
	-- Switch to the previous buffer before closing the terminal
	vim.cmd("bprevious")
	vim.cmd("bd!")
end, { noremap = true, silent = true })

vim.keymap.set("n", "<leader>sh", vim.lsp.buf.signature_help, { desc = "Signature Help" })

-- TODO: Add remaps from plugins init.lua for telescope
-- TODO: Add quicksort Ctrl+Q forward backward commands :cnext and :cprev - maybe Ctrl+J and Ctrl+K, (It's already Ctrl+q, and Ctrl+j/k moves between the buffers)
