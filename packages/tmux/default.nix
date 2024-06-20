{ pkgs, ... } : 
{
  programs.tmux = {
    enable = true;
    clock24 = true;
    keyMode = "vi";
    mouse = true;
    baseIndex = 1;
    escapeTime = 0;
    prefix = "C-a";
    plugins = with pkgs; [
      tmuxPlugins.yank
      {
        plugin = tmuxPlugins.catppuccin;
        extraConfig = ''
          set -g @catppuccin_status_background "#292a37"
          set -g @catppuccin_window_status_icon_enable "yes"
          set -g @catppuccin_window_default_fill "all"
          set -g @catppuccin_window_default_color "#292a37"
          set -g @catppuccin_window_default_background "#{thm_fg}"
          set -g @catppuccin_window_current_fill "all"
          set -g @catppuccin_window_current_color "#{thm_blue}"
          set -g @catppuccin_status_modules_right "directory user host session"
          set -g @catppuccin_window_middle_separator " "
          set -g @catppuccin_window_left_separator "█"
          set -g @catppuccin_window_right_separator "█"
          set -g @catppuccin_status_left_separator "█"
        '';
      }
    ];
    extraConfig = ''
      set-option -sa terminal-overrides ",xterm*:Tc"
      set -g renumber-windows on
      set-option -g status-position top
    '';
  };
}
