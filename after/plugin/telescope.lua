local builtin = require('telescope.builtin')
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')

-- Windows: entry paths use backslashes; vim's :edit eats the separator before
-- special chars ((app), [id]). Rewrite to / on the entry, then run telescope's
-- own action unchanged.
local function fix_then(orig)
	return function(prompt_bufnr)
		local entry = action_state.get_selected_entry()
		if entry then
			if entry.path then entry.path = entry.path:gsub('\\', '/') end
			if entry.filename then entry.filename = entry.filename:gsub('\\', '/') end
		end
		return orig(prompt_bufnr)
	end
end

require('telescope').setup({
	defaults = {
		mappings = {
			i = {
				['<CR>']  = fix_then(actions.select_default),
				['<C-x>'] = fix_then(actions.select_horizontal),
				['<C-v>'] = fix_then(actions.select_vertical),
				['<C-t>'] = fix_then(actions.select_tab),
			},
			n = {
				['<CR>']  = fix_then(actions.select_default),
				['<C-x>'] = fix_then(actions.select_horizontal),
				['<C-v>'] = fix_then(actions.select_vertical),
				['<C-t>'] = fix_then(actions.select_tab),
			},
		},
	},
})

vim.keymap.set('n', '<leader>ff', function()
	builtin.find_files({ follow = true, no_ignore = true, hidden = true })
end, { desc = 'Telescope find all files' })
vim.keymap.set('n', '<leader>fg', builtin.git_files, { desc = 'Telescope find git files' })
vim.keymap.set('n', '<leader>fl', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fs', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)
