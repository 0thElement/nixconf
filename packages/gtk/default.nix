{ pkgs, ...}:
{
  home.packages = with pkgs; [
    xfce.thunar
    nwg-look
  ];

  xdg.mime.enable = false;
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "inode/directory" = ["org.gnome.Nautilus.desktop"];
      "image/png" = ["imv.desktop"];
      "image/jpeg" = ["imv.desktop"];
    };
  };

  gtk = {
    enable = true;
    font.name = "Noto Sans";
    font.package = pkgs.noto-fonts;
    iconTheme.name = "Papirus-Dark-Maia";
    iconTheme.package = pkgs.papirus-maia-icon-theme;
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
      gtk-key-theme-name    = "Default";
      gtk-icon-theme-name   = "Papirus-Dark-Maia";
      gtk-cursor-theme-name = "Capitaine Cursors - White";
    };
  };

  home.file.".icons/default".source = "${pkgs.capitaine-cursors}/share/icons/capitaine-cursors-white";
  home.sessionVariables = {
    XCURSOR_SIZE = 16;
    XCURSOR_THEME = "Capitaine Cursors - White";
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      gtk-key-theme = "Default";
      cursor-theme = "Capitaine Cursors - White";
    };
  };

  xdg.systemDirs.data = [
    "${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}"
    "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}"
  ];

  qt = {
    enable = true;
    platformTheme.name = "gtk";
  };
}
