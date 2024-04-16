{ pkgs, lib, input, ... }:
{
  services.syncthing = {
    enable = true;
  };
}
