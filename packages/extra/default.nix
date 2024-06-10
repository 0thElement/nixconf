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
    xwaylandvideobridge
  ];

  home.sessionPath = [ "/home/zeroth/.cargo/bin/" ];
  home.file."home/zeroth/.config/xdg-desktop-portal/hyprland-portals.conf".text = ''
    [preferred]
    default=hyprland;gtk
    org.free.impl.portal.FileChooser=kde
  '';

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };
}
