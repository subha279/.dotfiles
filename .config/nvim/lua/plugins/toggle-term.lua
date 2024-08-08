return {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = function()
        local term = require('toggleterm')
        term.setup({
            size = 50,
            shade_terminals = true,
            hide_numbers = true,
            direction = 'float',
            close_on_exit = true,
            auto_scroll = false,
            shell = vim.o.shell,
            float_opts = {
                border = 'curved',
                width = 130,
                height = 30,
            },
        })
        vim.keymap.set('n', '<C-t>', ':ToggleTerm<CR>', {})
    end,
}
