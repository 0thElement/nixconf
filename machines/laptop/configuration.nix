{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../common.nix ];

  # Do not change this, future me
  system.stateVersion = "23.11";
}
