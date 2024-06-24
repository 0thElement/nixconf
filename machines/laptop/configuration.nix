{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../common.nix ];

  # Do not change this, future me
  config.system.stateVersion = "23.11";
}
