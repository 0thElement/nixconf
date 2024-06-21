{ pkgs, ... }:
{
  home.packages = with pkgs; [
    hyprland
    hyprpaper
    grim
    slurp
    swappy
    wl-clipboard
    brightnessctl
    pulseaudio
  ];

  home.file.".config/hypr/hyprland.conf".source = ./hyprland.conf;
  home.file.".config/hypr/hyprpaper.conf".source = ./hyprpaper.conf;
}
