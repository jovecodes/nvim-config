--------------------------------------------------------
-------------------- Toggle Terminal -------------------
--------------------------------------------------------

--
-- Why the fuck are people's plugins so bloated.
-- This is all the functionality of toggleterm I used a single small snippet of code.
--

local shell = "$SHELL"
local on_create_shell = ""

local window_handle = -1
local buffer_handle = -1

local function write_line(ln) 
    if (ln) then 
        local chan = vim.b.terminal_job_id 
        vim.api.nvim_chan_send(chan, ln .. "\n")
    end
end

local function toggle_term(cmd)
    local is_open = not vim.api.nvim_win_is_valid(window_handle)

    if not is_open then
        vim.api.nvim_set_current_win(window_handle)
        vim.cmd(":close")
    elseif buffer_handle ~= nil and vim.api.nvim_buf_is_valid(buffer_handle) then
        vim.api.nvim_command('botright split')
        vim.cmd(":b " .. buffer_handle)
        write_line(cmd)
        window_handle = vim.api.nvim_tabpage_get_win(0)
    else
        vim.api.nvim_command('botright split new')
        buffer_handle = vim.api.nvim_win_get_buf(0)

        vim.api.nvim_buf_set_name(buffer_handle, "Terminal")
        vim.api.nvim_call_function("termopen", {shell})
        if on_create_shell ~= '' then 
            write_line(on_enter_shell) 
        end

        write_line(cmd)
        window_handle = vim.api.nvim_tabpage_get_win(0)
    end

    if is_open then 
        vim.cmd(":startinsert") 

        -- Keep the terminal window from interfering with Ctrl-6 window switching
        vim.api.nvim_win_set_config(window_handle, {focusable = false})
    end
end

--------------------------------------------------------
--------------------- Compile Mode ---------------------
--------------------------------------------------------

local function isempty(s)
  return s == nil or s == ''
end

local stored_cmd = "./build.jov.sh"

local function compile(param) 
    local cmd = param.args

    if isempty(cmd) then 
        cmd = stored_cmd
    else
        stored_cmd = cmd
    end

    if buffer_handle ~= -1 then
        vim.api.nvim_buf_delete(buffer_handle, { force = true })
    end

    toggle_term(cmd)
end

vim.api.nvim_create_user_command('C', compile, {
  nargs = '*',
  complete = function(_, cmdline)
      local cmd = cmdline:gsub("C%s+", "")
      local results = vim.fn.getcompletion(("!%s"):format(cmd), "cmdline")
      return results
  end,
})

local error_regex_table = {
    basic = {
        regex = "^([^:]+):(%d+):(%d+): (.+): (.+)",
        filename = 1,
        row = 2,
        col = 3,
        type = 4,
        message = 5,
    },
    basic_no_col = {
        regex = "^([^:]+):(%d+)(.+)",
        filename = 1,
        row = 2,
        message = 3,
    },
}

local function match_list_position(input, pattern, matcher)
    local captures = { string.match(input, pattern) }

    if #captures == 0 then
        return nil
    end

    local result = {
        locations = {}, -- To store start/end positions of captures
        values = {},    -- To store the captured values
    }

    local latest_index = 1
    for i, capture in ipairs(captures) do
        if capture ~= "" then
            local start, finish = string.find(input, capture, latest_index, true)
            assert(start and finish)
            latest_index = finish + 1

            -- Add capture locations and values to result
            result.locations[i] = { start = start, finish = finish }
            result.values[i] = capture
        end
    end

    return result
end

local error_table = {} -- Holds all the error's locations so when we press enter we can go there.
local current_error_index = 0 -- Keeps track of the current error in the table

-- Create a namespace for highlights
local error_ns_id = vim.api.nvim_create_namespace("error_highlight")
vim.api.nvim_set_hl(0, "ErrorFile", { fg = "#c23535", bold = true })
vim.api.nvim_set_hl(0, "ErrorLine", { fg = "#b3b521", bold = true })
vim.api.nvim_set_hl(0, "ErrorColumn", { fg = "#6a9fb5", bold = true })

local function parse(buffer)
    error_table = {}

    -- Clear any previous highlights to avoid overlap
    vim.api.nvim_buf_clear_namespace(buffer, error_ns_id, 0, -1)

    local text = vim.api.nvim_buf_get_lines(buffer, 0, -1, false)
    for term_line_number, line in ipairs(text) do
        for _, matcher in pairs(error_regex_table) do
            local result = match_list_position(line, matcher.regex, matcher)
            if result ~= nil then
                local values = result.values

                table.insert(error_table, {
                    filename = values[matcher.filename],
                    row = tonumber(values[matcher.row]) or 1,
                    col = tonumber(values[matcher.col]) or 1,
                    type = values[matcher.type],
                    message = values[matcher.message],
                    line = line, -- Full line for context
                })

                local end_hl = #values[matcher.filename]
                vim.api.nvim_buf_add_highlight(buffer, error_ns_id, "ErrorFile", term_line_number - 1, 0, end_hl)
                end_hl = end_hl + 1
                
                local start_hl = end_hl
                end_hl = end_hl + #values[matcher.row]
                vim.api.nvim_buf_add_highlight(buffer, error_ns_id, "ErrorLine", term_line_number - 1, start_hl, end_hl)
                end_hl = end_hl + 1
                
                if values[matcher.col] then 
                    local start_hl = end_hl
                    end_hl = end_hl + #values[matcher.col]
                    vim.api.nvim_buf_add_highlight(buffer, error_ns_id, "ErrorColumn", term_line_number - 1, start_hl, end_hl)
                end
            end
        end
    end
end

vim.api.nvim_create_autocmd({ "BufReadPost", "TextChanged" }, {
  callback = function(args)
    local current_buffer = vim.api.nvim_get_current_buf()
    if current_buffer == buffer_handle then 
        parse(buffer_handle)
    end
  end,
})

function navigate_to_error()
    local current_line = vim.api.nvim_get_current_line()

    for _, error_entry in ipairs(error_table) do
        if error_entry.line == current_line then
            vim.api.nvim_command('wincmd p') -- go back to main window
            vim.cmd("edit " .. error_entry.filename) -- Open the file
            vim.api.nvim_win_set_cursor(0, { error_entry.row, error_entry.col - 1 }) -- Set cursor
            return
        end
    end

    print("No error found on this line.")
end

local function go_to_next_error()
    if #error_table == 0 then
        print("No errors found.")
        return
    end

    -- Move to the next error index, wrap around if necessary
    current_error_index = (current_error_index % #error_table) + 1

    local error_entry = error_table[current_error_index]

    if vim.api.nvim_tabpage_get_win(0) == window_handle then
        vim.api.nvim_command('wincmd p') -- go back to main window
    end

    vim.cmd("edit " .. error_entry.filename) -- Open the file
    vim.api.nvim_win_set_cursor(0, { error_entry.row, error_entry.col - 1 }) -- Set cursor
end

vim.api.nvim_create_autocmd("TermEnter", {
    callback = function()
        vim.api.nvim_buf_set_keymap(0, "n", "<CR>", ":lua navigate_to_error()<CR>", { noremap = true, silent = true })
        vim.cmd(":setlocal nonumber norelativenumber")
    end,
})

--------------------------------------------------------
----------------------- Mappings -----------------------
--------------------------------------------------------

vim.api.nvim_set_keymap('n', '<leader>r', '<CMD>C<CR>', { noremap = true, silent = true })

vim.api.nvim_create_user_command('T', function() toggle_term() end, {})
vim.api.nvim_set_keymap('n', '<C-t>', '<Cmd>T<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('t', '<C-t>', '<Cmd>T<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', { noremap = true, silent = true })

vim.api.nvim_create_user_command("NextError", go_to_next_error, {})
vim.api.nvim_set_keymap('n', '<leader>n', '<CMD>NextError<CR>', { noremap = true, silent = true })
