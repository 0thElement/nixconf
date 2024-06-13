{ pkgs, ... } :
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs;
  };

  home.packages = with pkgs; [
    # CLI
    killall
    # Media
    vlc
    ffmpeg
    imv
    rhythmbox
    # Tools
    blender
    obs-studio
    hyprpicker
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
