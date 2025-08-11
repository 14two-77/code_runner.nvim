local file = "file"
local file_no_ext ="file_no_ext"
local output
local compile_cmd
local run_cmd

output = file_no_ext .. ".exe"
local compile_cmd = string.format('g++ \"%s\" -o \"%s\"', file, output)
local run_cmd = string.format('"%s"', output)

local term_cmd = string.format("%s && %s\n", compile_cmd, run_cmd)
print(term_cmd)
