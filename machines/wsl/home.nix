{ ... }:
{
  home.username = "zeroth";
  home.homeDirectory = "/home/zeroth";
  home.stateVersion = "24.05";

  imports = [
    ./../../packages/wsl.nix
  ];

  home.sessionPath = [
    "/home/zeroth/.cargo/bin"
  ];

  programs.home-manager.enable = true;
}
