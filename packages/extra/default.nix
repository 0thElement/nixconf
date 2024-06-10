{ pkgs, lib, config, ... } :
with lib;
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs;
  };

  home.packages = with pkgs; [
    # CLI
    killall
    # Media
    vlc ffmpeg
    # Tools
    blender
    obs-studio
    imv
    rhythmbox
    # Dev
    dotnet-sdk
    jdk
    rustup nodejs
    # Misc
    vesktop
  ];

  home.sessionPath = [ "/home/zeroth/.cargo/bin/" ];

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };
}
