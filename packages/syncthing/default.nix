{ pkgs, lib, input, ... }:
{
  home.packages = [ pkgs.syncthingtray-minimal ];
  services.syncthing = {
    enable = true;
    tray = {
      enable = true;
    };
  };
}
