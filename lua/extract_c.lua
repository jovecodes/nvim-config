local M = {}

local function get_c_file()
    local header = vim.api.nvim_buf_get_name(0)
    local cfile = header:gsub("%.h$", ".c")

    if vim.fn.filereadable(cfile) == 0 then
        vim.notify("No corresponding .c file: " .. cfile, vim.log.levels.ERROR)
        return nil
    end

    return cfile
end

-- find nearest { above cursor
local function find_body_start(lines, row)
    -- Start at cursor row and scan downward for the first "{"
    for i = row, #lines do
        local line = lines[i]
        -- skip lines that are empty or comments
        if not line:match("^%s*//") and not line:match("^%s*$") then
            -- check for "{" not inside a comment
            local brace_pos = line:find("{")
            if brace_pos then
                return i
            end
        end
    end
    return nil -- no body found
end

-- find matching }
local function find_body_end(lines, start_row)
    local depth = 0

    for i = start_row, #lines do
        for c in lines[i]:gmatch("[{}]") do
            if c == "{" then
                depth = depth + 1
            else
                depth = depth - 1
                if depth == 0 then
                    return i
                end
            end
        end
    end
end

-- find beginning of function signature
local function find_signature_start(lines, body_row)
    local row = body_row

    while row > 1 do
        if lines[row]:find("%)") then
            break
        end
        row = row - 1
    end

    while row > 1 do
        if lines[row - 1]:match("^%s*$") then
            break
        end

        if lines[row - 1]:find(";") then
            break
        end

        if lines[row - 1]:find("}") then
            break
        end

        row = row - 1
    end

    return row
end

local function extract_function()
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    local row = vim.api.nvim_win_get_cursor(0)[1]

    local body_start = find_body_start(lines, row)
    if not body_start then 
        vim.notify("THERE", vim.log.levels.ERROR)
        return nil
    end

    local body_end = find_body_end(lines, body_start)
    if not body_end then 
        vim.notify("HERE", vim.log.levels.ERROR)
        return nil 
    end

    local sig_start = find_signature_start(lines, body_start)

    local func_lines = {}
    for i = sig_start, body_end do
        table.insert(func_lines, lines[i])
    end

    return {
        start_row = sig_start,
        end_row = body_end,
        lines = func_lines,
    }
end

local function trim_end(s)
  -- The pattern '%s+$' matches one or more whitespace characters (%s+)
  -- at the end of the string ($).
  return string.gsub(s, '%s+$', '')
end

local function make_prototype(lines)
    local proto = {}

    for _, l in ipairs(lines) do
        local cleaned = l:gsub("{.*", "")
        table.insert(proto, cleaned)

        if l:find("{") then
            break
        end
    end

    proto[#proto] = trim_end(proto[#proto]) .. ";"

    return proto
end

function M.extract()
    local func = extract_function()

    if not func then
        vim.notify("Could not find function", vim.log.levels.ERROR)
        return
    end

    local cfile = get_c_file()
    if not cfile then return end

    local proto = make_prototype(func.lines)

    -- replace header function with prototype
    vim.api.nvim_buf_set_lines(
        0,
        func.start_row - 1,
        func.end_row,
        false,
        proto
    )

    -- append implementation to .c
    local impl = vim.fn.readfile(cfile)

    table.insert(impl, "")
    for _, l in ipairs(func.lines) do
        table.insert(impl, l)
    end

    vim.fn.writefile(impl, cfile)

    vim.notify("Extracted implementation to " .. cfile)
end

return M
