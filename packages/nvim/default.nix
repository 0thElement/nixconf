{  pkgs, ... }:
{
  home.file.".config/nvim/settings.lua".source = ./init.lua;
  home.file.".config/nvim/cmp.lua".source = ./cmp.lua;

  home.packages = with pkgs; [ nil ripgrep fzf ];
        
  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [ 
      # Idk
      vim-nix
      plenary-nvim

      # Aesthetic
      vim-airline
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
                mantle = "#3f4054",
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

      # Navigation
      { plugin = oil-nvim;
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
        config = "lua require('lspconfig').nil_ls.setup({})";
      }
      {
        plugin = rustaceanvim;
      }
      {
        plugin = lsp_signature-nvim;
        config = "lua require('lsp_signature').setup()";
      }
      { 
        plugin = renamer-nvim;
        config = "lua require('renamer').setup({})";
      } 
      luasnip nvim-cmp cmp-buffer cmp-nvim-lsp cmp-path

      # Code actions
      {
        plugin = nvim-lightbulb;
        config = "lua require('nvim-lightbulb').setup({autocmd={enabled=true}})";
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
