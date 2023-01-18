local tt = require('toggleterm')
tt.setup{
    open_mapping = [[<c-0>]],
    direction = 'vertical',
    size = function(term)
        if term.direction == 'horizontal' then
            return 15
        elseif term.direction == 'vertical' then
            return vim.o.columns * 0.3
        end
    end,
    persist_mode = false,
    start_in_insert = true,
}

local terms = require('toggleterm.terminal')
local last_idx = 0
local MAX_TERMS = 10

local function inc_mod(a, b)
    return (a + b) % MAX_TERMS
end

local function dec_mod(a, b)
    return (a - b) % MAX_TERMS
end


local function get_next_term(callback, index_op)
    local ts = terms.get_all()
    for i = 1, MAX_TERMS do
        local index = index_op(last_idx, i)
        local term = ts[index]
        if term then
            last_idx = index
            callback(term)
            break
        end
    end
end

local function values(t)
  local i = 0
  return function() i = i + 1; return t[i] end
end

local function open_one(term)
    for t in values(terms.get_all()) do
        if t:is_open() and t.id ~= term.id then
            t:toggle()
        end
    end
    if not term:is_open() then
        term:toggle()
    end
end

local function switch_forward()
    get_next_term(open_one, inc_mod)
end

local function switch_backward()
    get_next_term(open_one, dec_mod)
end

vim.keymap.set({ 'n',}, '<c-=>', switch_forward)
vim.keymap.set({ 't',}, '<c-=>', function()
    vim.cmd('stopinsert')
    vim.defer_fn(switch_forward, 50)
end)

vim.keymap.set({ 'n',}, '<c-_>', switch_backward)
vim.keymap.set({ 't',}, '<c-_>', function()
    vim.cmd('stopinsert')
    vim.defer_fn(switch_backward, 50)
end)
