{ pkgs, lib, config, ... } :
with lib;
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs;
  };

  home.pointerCursor = {
    gtk.enable = true;
    name = "Catppuccin-Macchiato-Dark-Cursors";
    package = pkgs.catppuccin-cursors.macchiatoDark;
    size = 16;
  };

  home.packages = with pkgs; [
    # CLI
    killall
    # Media
    feh vlc ffmpeg
    # Tools
    blender
    obs-studio
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
