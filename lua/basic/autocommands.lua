-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- NOTE: YANK HIGHLIGHT
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- NOTE: COMMENTING
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

-- NOTE: RUN ON SAVE
vim.g.enable_run_on_save = false

if vim.g.enable_run_on_save then
	vim.api.nvim_create_autocmd("BufWritePost", {
		pattern = "*.js",
		command = "!node %",
	})
end

-- TODO: Find better way for project specific configurations
-- TODO: Find better way to exit the buffer
if vim.g.enable_run_on_save then
	vim.api.nvim_create_autocmd("BufWritePost", {
		pattern = "C:/code/Remundo.Ui/src/**/*",
		callback = function()
			vim.cmd(
				[[botright split | terminal dotnet run --project C:/code/Remundo.Ui/src/Server/Remundo.Ui.Server.csproj --configuration Debug]]
			)
			vim.cmd("resize 10")
		end,
	})
end

-- NOTE: RUN TESTS ON SAVE
vim.g.enable_run_tests_on_save = true

if vim.g.enable_run_tests_on_save then
	vim.api.nvim_create_autocmd("BufWritePost", {
		pattern = "**/*Tests.cs",
		callback = function()
			-- Get the current file's directory
			local file_path = vim.fn.expand("<afile>:p:h")
			-- Find the .csproj file in the same directory
			local csproj_file = vim.fn.glob(file_path .. "/*.Tests.csproj")
			if csproj_file ~= "" then
				vim.cmd([[botright split | terminal dotnet test ]] .. csproj_file .. " -v minimal")
				vim.cmd("resize 10")
				-- Enter insert mode to scroll to the bottom automatically
				vim.cmd("normal! G")
				vim.cmd("startinsert")
			else
				print("No .Tests.csproj file found in the directory: " .. file_path)
			end
		end,
	})
end

--NOTE: RUN CYPRESS TESTS ON SAVE

-- vim.api.nvim_create_autocmd("BufWritePost", {
--     pattern = "*.feature",
--     callback = function()
--             local file = vim.fn.expand("%:p") -- Get full file path
--             local escaped_file = vim.fn.shellescape(file) -- Properly escape the file path
--
--             -- Run Cypress directly inside the terminal and keep it open
--             local cmd = "cmd /k npx cypress run --headed --no-exit --spec " .. escaped_file
--
--             -- Open a horizontal split and run the command inside a new terminal
--             vim.cmd("split") -- Open horizontal split
--             vim.cmd("resize 10") -- Set terminal height
--             vim.cmd("terminal " .. cmd) -- Run Cypress in terminal
--             vim.cmd("startinsert") -- Enter insert mode so it interacts properly
--     end,
-- })

--NOTE: Duplicate File
vim.keymap.set("n", "<leader>du", function()
       local filepath = vim.fn.expand("%:p") -- full path
       local dir = vim.fn.expand("%:p:h") -- directory
       local filename = vim.fn.expand("%:t:r") -- name without ext
       local ext = vim.fn.expand("%:e") -- extension

       local default = filename .. "_copy." .. ext

       -- Prompt user for a new name (in same directory)
       vim.ui.input({ prompt = "Duplicate as: ", default = default }, function(input)
               if not input or input == "" then
                       print("Cancelled")
                       return
               end

               local newpath = dir .. "/" .. input

               -- Perform the copy
               vim.fn.system({ "cp", filepath, newpath })

               -- Open duplicated file
               vim.cmd("edit " .. newpath)

               print("Duplicated → " .. input)
       end)
end, { desc = "Duplicate file" })
