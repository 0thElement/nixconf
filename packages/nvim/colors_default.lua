require('catppuccin').setup {
    flavour = "frappe",
    color_overrides = {
        frappe = {
        base = "#292a37",
        mantle = "#292a37",
        crust = "#292a37",
        }
    }
}

vim.cmd([[colorscheme catppuccin]])
