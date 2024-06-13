{ pkgs, ...}:
{
  home.packages = with pkgs; [
    gnome.nautilus
  ];

  gtk = {
    enable = true;
    font.name = "Noto Sans";
    font.package = pkgs.noto-fonts;
    # theme.name = "adw-gtk3-dark";
    # theme.package = pkgs.adw-gtk3;
    theme.name = "Dracula";
    theme.package = pkgs.dracula-theme;
    iconTheme.name = "Papirus-Dark-Maia";
    iconTheme.package = pkgs.papirus-maia-icon-theme;
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
      gtk-key-theme-name    = "Default";
      gtk-icon-theme-name   = "Papirus-Dark-Maia";
      gtk-cursor-theme-name = "Catppuccin-Macchiato-Dark-Cursors";
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      gtk-key-theme = "Default";
      cursor-theme = "Catppuccin-Macchiato-Dark-Cursors";
    };
  };

  xdg.systemDirs.data = [
    "${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}"
    "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}"
  ];

  home.pointerCursor = {
    gtk.enable = true;
    name = "Catppuccin-Macchiato-Dark-Cursors";
    package = pkgs.catppuccin-cursors.macchiatoDark;
    size = 16;
  };
}
