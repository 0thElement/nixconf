{ inputs, pkgs, lib, config, ... }:
with lib;
{
  home.packages = with pkgs; [
    wofi wl-clipboard hyprland hyprpaper grimblast
  ];

  home.file.".config/hypr/hyprland.conf".source = ./hyprland.conf;
  home.file.".config/hypr/hyprpaper.conf".source = ./hyprpaper.conf;
  home.file.".config/wofi.css".source = ./wofi.css;
}
