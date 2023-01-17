require('toggleterm').setup{
    open_mapping = [[<c-0>]],
    direction = 'vertical',
    size = function(term)
        if term.direction == 'horizontal' then
            return 15
        elseif term.direction == 'vertical' then
            return vim.o.columns * 0.3
        end
    end,
}
