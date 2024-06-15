{ ... }:
{
  home.username = "zeroth";
  home.homeDirectory = "/home/zeroth";
  home.stateVersion = "23.11"; # Do not change this, future me!

  imports = [
    ./../packages
  ];

  programs.home-manager.enable = true;
}
