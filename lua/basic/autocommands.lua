-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Commenting set connstring for gc
vim.api.nvim_create_autocmd("FileType", {
    pattern = "json",
    command = "setlocal commentstring=//\\ %s",
})

-- vim.api.nvim_create_autocmd("FileType", {
--     pattern = "python",
--     command = "setlocal commentstring=#\\ %s",
-- })
-- vim.api.nvim_create_autocmd("FileType", {
--     pattern = "c,cpp",
--     command = "setlocal commentstring=//\\ %s",
-- })
-- vim.api.nvim_create_autocmd("FileType", {
--     pattern = "html",
--     command = "setlocal commentstring=<!--\\ %s\\ -->",
-- })
