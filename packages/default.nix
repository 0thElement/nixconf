
{ inputs, pkgs, config, ... }:

{
  imports = [
    ./alacritty
    ./hyprland
    ./waybar
    ./dunst
    ./gtk
    ./fish
    ./nvim
    ./git
    ./firefox
    ./syncthing
    ./extra
  ];
}
