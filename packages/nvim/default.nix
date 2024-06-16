{  pkgs, pkgsNvim, ... }:
{
  home.file.".config/nvim/settings.lua".source = ./init.lua;
  home.file.".config/nvim/cmp.lua".source = ./cmp.lua;

  home.packages = with pkgs; [ nil ripgrep fzf ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };
        
  programs.neovim = {
    enable = true;
    plugins = with pkgsNvim.vimPlugins; [ 
      # Idk
      vim-nix
      plenary-nvim

      # Aesthetic
      lualine-lsp-progress
      {
        plugin = lualine-nvim;
        config = ''
          lua << EOF
          require('lualine').setup({
            theme = 'powerline-dark',
            sections = {
              lualine_a = {'mode'},
              lualine_b = {'branch', 'diff', 'diagnostics'},
              lualine_c = {'filename'},
              lualine_x = {'lsp_progress', 'encoding'},
              lualine_y = {'filetype'},
              lualine_z = {'progress'}
            },
          })
          EOF
        '';
      }
      vim-gitgutter
      {
        plugin = catppuccin-nvim;
        config = ''
          lua << EOF
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
          EOF
          colorscheme catppuccin
        '';
      }
      {
        plugin = nvim-web-devicons;
        config = "lua require('nvim-web-devicons').setup()";
      }
      {
        plugin = indent-blankline-nvim;
        config = "lua require('ibl').setup()";
      }
      {
        plugin = nvim-scrollview;
        config = "lua require('scrollview').setup()";
      }

      # Navigation
      {
        plugin = oil-nvim;
        config = ''
          lua << EOF
          require('oil').setup({
            default_file_explorer = true,
            win_options = {
              wrap = true
            },
            skip_confirm_for_simple_edits = true,
            view_options = {
              show_hidden = true,
              is_always_hidden = function(name, _) return name == '..' or name == '.git' end,
            },
          })
          EOF
        '';
      }
      {
        plugin = telescope-nvim;
        config = "lua require('telescope').setup()";
      }
      {
        plugin = harpoon2;
        config = "lua require('harpoon').setup()";
      }
      {
        plugin = toggleterm-nvim;
        config = ''
          lua << EOF
          require('toggleterm').setup({
            direction = 'float',
          })
          EOF
        '';
      }

      # Buffer navigation
      vim-repeat
      {
        plugin = leap-nvim;
        config = "lua require('leap').create_default_mappings()";
      }

      # LSP
      {
        plugin = nvim-lspconfig;
        config = ''
          lua << EOF
          -- vim.cmd [[autocmd! ColorScheme * highlight NormalFloat guibg=#1f2335]]
          -- vim.cmd [[autocmd! ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]]

          local border = {
            {"╭", "FloatBorder"},
            {"─", "FloatBorder"},
            {"╮", "FloatBorder"},
            {"│", "FloatBorder"},
            {"╯", "FloatBorder"},
            {"─", "FloatBorder"},
            {"╰", "FloatBorder"},
            {"│", "FloatBorder"},
          }

          local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
          function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
            opts = opts or {}
            opts.border = opts.border or border
            return orig_util_open_floating_preview(contents, syntax, opts, ...)
          end

          require('lspconfig').nil_ls.setup({})
          EOF
        '';
      }
      {
        plugin = lsp_signature-nvim;
        config = "lua require('lsp_signature').setup()";
      }
      { 
        plugin = renamer-nvim;
        config = ''
          lua require('renamer').setup({ min_width = 20, padding = { left = 1, right = 1 } })
          hi link RenamerBorder FloatBorder
          hi link RenamerTitle FloatBorder
        '';
      } 
      lspkind-nvim
      rustaceanvim
      luasnip
      nvim-cmp cmp-buffer cmp-nvim-lsp cmp-path cmp-calc

      # Code actions
      {
        plugin = nvim-lightbulb;
        config = ''
          lua << EOF
          require('nvim-lightbulb').setup({
            autocmd = { enabled = true },
            sign = { enabled = false },
            virtual_text = {
              enabled = true,
              pos = "eol",
              hl = "",
            }
          })
          EOF
        '';
      }
      {
        plugin = actions-preview-nvim;
        config = ''
          lua << EOF
          require("actions-preview").setup {
            telescope = {
              sorting_strategy = "ascending",
              layout_strategy = "vertical",
              layout_config = {
                width = 0.8,
                height = 0.9,
                prompt_position = "top",
                preview_cutoff = 20,
                preview_height = function(_, _, max_lines)
                  return max_lines - 15
                end,
              },
            },
          }
          EOF
        '';
      }

      # Tools
      vim-commentary 
      vim-surround
      nvim-autopairs
      {
        plugin = vim-visual-multi;
        config = ''
          let g:VM_theme = 'nord'
          let g:VM_maps = {}
          let g:VM_maps['Find Under']         = ""
          let g:VM_maps['Find Subword Under'] = ""
        '';
      }
    ];
    extraConfig = ''
      luafile ~/.config/nvim/settings.lua
      luafile ~/.config/nvim/cmp.lua
    '';
  };
}
