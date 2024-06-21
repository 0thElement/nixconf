{ inputs, pkgs, ... }:
{
  imports = [ inputs.ags.homeManagerModules.default ];

  programs.ags = {
    enable = true;

    # additional packages to add to gjs's runtime
    extraPackages = with pkgs; [
      gtksourceview
      webkitgtk
      accountsservice
    ];
  };

  home.file."/home/zeroth/.config/ags/config.js".source = ./config.js;
  home.file."/home/zeroth/.config/ags/style.css".source = ./style.css;
  home.file."/home/zeroth/.config/ags/cpu.sh".source = ./cpu.sh;
  home.file."/home/zeroth/.config/ags/mem.sh".source = ./mem.sh;
}
