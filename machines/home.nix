{ ... }:
{
  home.username = "zeroth";
  home.homeDirectory = "/home/zeroth";
  home.stateVersion = "23.11"; # Do not change this, future me!

  imports = [
    ./../packages
  ];

  wal.enable = true;

  programs.home-manager.enable = true;
}
