{ pkgs, config, lib,... }:
{
  home.packages = with pkgs; [
    swww
    hyprland
    grim
    slurp
    swappy
    wl-clipboard
    brightnessctl
    pulseaudio
  ];

  home.sessionVariables = {
    LAST_WALLPAPER_PATH = "/home/zeroth/.local/state/lastwallpaper";
  };

  home.file =
    let wal = config.wal.enable; in 
    lib.mkMerge [
      {
        ".config/hypr/hyprland.conf".source = ./hyprland.conf;
        ".config/hypr/keybinds.conf".source = ./keybinds.conf;
        ".config/hypr/rules.conf".source = ./rules.conf;
        ".config/hypr/setup.conf".source = ./setup.conf;
        ".config/hypr/startup.conf".source = ./startup.conf;
      }
      (if wal then {
        ".config/wpg/templates/hyprland.conf.base".source = ./colors_wal.conf;
        ".config/hypr/colors.conf".source = config.lib.file.mkOutOfStoreSymlink "/home/zeroth/.config/wpg/templates/hyprland.conf";
      }
      else {
        ".config/hypr/colors.conf".source = ./colors_default.conf;
      })
  ];
}
