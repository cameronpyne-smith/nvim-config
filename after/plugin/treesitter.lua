-- nvim-treesitter (main branch) only installs parsers and provides indentexpr.
-- Highlighting is nvim's own (:h treesitter-highlight) and is started per buffer below.
require("nvim-treesitter").install({
	"lua",
	"vim",
	"vimdoc",
	"query",
	"markdown",
	"markdown_inline",
	"javascript",
	"typescript",
	"c_sharp",
	"html",
	"rust",
	"toml",
	"python",
	"svelte",
	"go",
	"gomod",
	"gosum",
	"gowork",
})

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("treesitter-start", { clear = true }),
	callback = function(args)
		-- Skip large files, where treesitter highlighting gets slow.
		local max_filesize = 100 * 1024 -- 100 KB
		local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(args.buf))
		if ok and stats and stats.size > max_filesize then
			return
		end

		-- Only start when a parser for this filetype is installed.
		local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
		if not lang or not vim.treesitter.language.add(lang) then
			return
		end

		vim.treesitter.start(args.buf, lang)
		vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})

vim.filetype.add({
	extension = {
		razor = "razor", -- Map .razor files to the razor filetype
	},
})

-- Register Razor files to use both c_sharp and html parsers
vim.treesitter.language.register("html", "razor")
vim.treesitter.language.register("c_sharp", "razor")
