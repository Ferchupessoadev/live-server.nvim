local M = {
	path = nil,
}

function M.get()
	local cwd = vim.fn.getcwd()
	local path = vim.fn.fnamemodify(cwd, ":~:.")
	path = vim.fn.fnamemodify(cwd, ":~:.").sub(path, 2)

	M.path = path
	return path
end

return M
