{ pkgs, input, lib, ...}:
{
  home.packages = with pkgs; [
    gnome.nautilus
  ];
  gtk = {
    enable = true;
    theme.package = pkgs.adw-gtk3;
    theme.name = "adw-gtk3-dark";
  };
}
