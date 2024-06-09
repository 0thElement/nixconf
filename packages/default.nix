
{ inputs, pkgs, config, ... }:

{
  imports = [
    ./alacritty
    ./hyprland
    ./waybar
    ./dunst
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
