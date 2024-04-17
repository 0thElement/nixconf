{ pkgs, lib, config, ... } :
with lib;
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs;
  };

  home.packages = with pkgs; [
    discord
    killall
    feh
    vlc
    ffmpeg
    blender
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };
}
