{ pkgs, lib, config, ... }:
let colors = wal: ''
* {{
    background: ${if wal then "{color0}" else "#292a37"};
    bordercolor: ${if wal then "{active}" else "#b072d1"};
    foreground: ${if wal then "{color15}" else "#d9e0ee"};
    active: ${if wal then "{active}" else "rgba(0, 188, 212, 100%)"};
    accent: ${if wal then "{active}" else "rgba(176, 114, 209, 60%)"};
    selected: ${if wal then "rgba({active.rgb},0.2)" else "rgba(176, 114, 209, 0.2)"};

    background-color: rgba (0, 0, 0, 0%);
    red: #ec6a88;

    border-color: @bordercolor;

    active-background: @normal-background;
    active-foreground: @active;
    normal-background: rgba (0, 0, 0, 0);
    normal-foreground: @foreground;
    urgent-background: @normal-background;
    urgent-foreground: @red;

    alternate-active-background: @normal-background;
    alternate-active-foreground: @active-foreground;
    alternate-normal-background: @normal-background;
    alternate-normal-foreground: @foreground;
    alternate-urgent-background: @urgent-background;
    alternate-urgent-foreground: @urgent-foreground;

    selected-active-background: @selected-normal-background;
    selected-active-foreground: @active-foreground;
    selected-normal-background: @selected;
    selected-normal-foreground: @foreground;
    selected-urgent-background: @urgent-foreground;
    selected-urgent-foreground: @foreground;
}}
'';
in {
  nixpkgs.overlays = [(final: prev: {
    rofi-calc = prev.rofi-calc.override { rofi-unwrapped = prev.rofi-wayland-unwrapped; };
  })];
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    plugins = [ pkgs.rofi-calc ];
    font = "Source Code Pro 14";
    cycle = true;
    location = "center";
    yoffset = 100;
    theme = "custom";
  };

  home.file = lib.mkMerge [
    (if config.wal.enable then {
      ".config/wpg/templates/rofi.rasi.base".text = colors true;
      ".local/share/rofi/themes/colors.rasi".source =
        config.lib.file.mkOutOfStoreSymlink
        "/home/zeroth/.config/wpg/templates/rofi.rasi";
    } else {
      ".local/share/rofi/themes/colors.rasi".text = colors false;
    })
    {
      ".local/share/rofi/themes/custom.rasi".source = ./theme.rasi;
    }
  ];
}
