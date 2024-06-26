{ pkgs, ... } :
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs;
  };

  home.packages = with pkgs; [
    # Media
    vlc
    ffmpeg
    imv
    rhythmbox
    # Tools
    blender
    obs-studio
    btop
    # Dev
    dotnet-sdk
    # Misc
    vesktop
    xwaylandvideobridge
  ];

  services.syncthing = {
    enable = true;
  };

  home.file.".config/xdg-desktop-portal/hyprland-portals.conf".text = ''
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
