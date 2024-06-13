{  pkgs, ... }:
{
  home.file.".config/nvim/settings.lua".source = ./init.lua;

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
          colorscheme catppuccin
          lua << EOF
          require('catppuccin').setup {
            color_overides = {
              all = {
                base = "#292a37"
              }
            }
          }
          EOF
        '';
      }
      {
        plugin = nvim-web-devicons;
        config = "lua require('nvim-web-devicons').setup()";
      }
      {
        plugin = oil-nvim;
        config = "lua require('oil').setup()";
      }

      # LSP
      {
        plugin = nvim-lspconfig;
        config = "lua require('lspconfig').nil_ls.setup({})";
      }
      {
        plugin = lsp_signature-nvim;
        config = "lua require('lsp_signature').setup()";
      }
      {
        plugin = nvim-cmp;
        config = "lua require('cmp').setup()";
      }
      {
        plugin = rustaceanvim;
      }

      # Tools
      vim-commentary
      vim-surround
      {
        plugin = autoclose-nvim;
        config = "lua require('autoclose').setup()";
      }
      {
        plugin = telescope-nvim;
        config = "lua require('telescope').setup()";
      }
      {
        plugin = indent-blankline-nvim;
        config = "lua require('ibl').setup()";
      }
    ];
    extraConfig = ''
      luafile ~/.config/nvim/settings.lua
    '';
  };
}
