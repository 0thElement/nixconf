{ pkgs, ... }:
{
  home.packages = with pkgs; [
    hyprland
    grim
    slurp
    swappy
    wl-clipboard
    brightnessctl
    pulseaudio
  ];

  home.sessionVariables = {
    LAST_WALLPAPER_PATH = "/home/zeroth/.local/state/lastwallpaper";
  };

  home.file.".config/hypr/hyprland.conf".source = ./hyprland.conf;
}
