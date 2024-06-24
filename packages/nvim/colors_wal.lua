require('catppuccin').setup {{
    flavour = "frappe",
    color_overrides = {{
        frappe = {{
        base = "{color0}",
        mantle = "{color0}",
        crust = "{color0}",
        }}
    }}
}}

vim.cmd([[colorscheme catppuccin]])
