local M = {}

function M.run_cpp()
	local file = vim.fn.expand("%:p")
	local file_no_ext = vim.fn.expand("%:p:r")
	local output
	local compile_cmd
	local run_cmd
	local os_name = vim.loop.os_uname().sysname

	if os_name:match("Windows") then
		output = file_no_ext .. ".exe"
		compile_cmd = string.format('g++ "%s" -o "%s"', file, output)
		run_cmd = string.format('"%s"', output)
	else
		output = file_no_ext .. ".out"
		compile_cmd = string.format('g++ "%s" -o "%s"', file, output)
		run_cmd = string.format('"%s"', output)
	end

	vim.cmd("w")
	vim.cmd("split | terminal")
	local term_cmd = string.format("%s && %s\n", compile_cmd, run_cmd)
	vim.api.nvim_chan_send(vim.b.terminal_job_id, term_cmd)
end

function M.setup()
	local wk = require("which-key")
	wk.add({
		{ "<leader>r", M.run_cpp, desc = "Run current C++ file", mode = "n" },
	})
end

return M
