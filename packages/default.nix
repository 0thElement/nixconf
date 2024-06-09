
{ inputs, pkgs, config, ... }:

{
  imports = [
    ./alacritty
    ./hyprland
    ./waybar
    ./gtk
    ./fish
    ./rofi
    ./nvim
    ./git
    ./firefox
    ./syncthing
    ./extra
  ];
}
