require('catppuccin').setup {
    flavour = "frappe",
    color_overrides = {
        frappe = {
            base = "#181818",
            mantle = "#181818",
            crust = "#181818",
        }
    }
}

vim.cmd([[colorscheme catppuccin]])
