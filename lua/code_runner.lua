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

    local Terminal = require("toggleterm.terminal").Terminal
    if not M._cpp_term then
        M._cpp_term = Terminal:new({
            direction = "horizontal",
            close_on_exit = false
        })
    end

    M._cpp_term:open()

    local term_cmd = string.format("%s && %s\n", compile_cmd, run_cmd)
    M._cpp_term:send('export PATH="/mingw64/bin:$PATH"')
    M._cpp_term:send(term_cmd)
end

function M.setup()
    local wk = require("which-key")
    wk.add({{
        "<leader>r",
        M.run_cpp,
        desc = "Run current C++ file",
        mode = "n"
    }})
end

return M
