{ pkgs, lib, config, ... } :
with lib;
{
  home.packages = with pkgs; [
    vscode
    discord
    killall
  ];
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };
}
