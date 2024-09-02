{ ... }:
{
  home.username = "zeroth";
  home.homeDirectory = "/home/zeroth";
  home.stateVersion = "23.11"; # Do not change this, future me!

  imports = [
    ./../packages
  ];

  wal.enable = true;

  home.sessionPath = [
    "/home/zeroth/.cargo/bin"
  ];

  programs.home-manager.enable = true;
}
