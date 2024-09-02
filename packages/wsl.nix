{ lib, ... }:
{
  imports = [
    ./fish #Shell
    ./nvim
    ./git
    ./tmux 
  ];

  # some config tries to read from this
  options.wal = { enable = lib.mkEnableOption "wal"; };
}
