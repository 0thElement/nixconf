{ config, ... }:
let toml = wal: ''
[colors]
draw_bold_text_with_bright_colors = true

[colors.bright]
black = "${ if wal then "0x{color8.strip}" else "0x393a4d" }"
red = "${ if wal then "0x{color9.strip}" else "0xe95678" }"
green = "${ if wal then "0x{color10.strip}" else "0x65ebcc" }"
yellow = "${ if wal then "0x{color11.strip}" else "0xefb993" }"
blue = "${ if wal then "0x{color12.strip}" else "0x26bbd9" }"
magenta = "${ if wal then "0x{color13.strip}" else "0xb072d1" }"
cyan = "${ if wal then "0x{color14.strip}" else "0x59e3e3" }"
white = "${ if wal then "0x{color15.strip}" else "0xd9e0ee" }"

[colors.normal]
black = "${ if wal then "0x{color0.strip}" else "0x303241" }"
red = "${ if wal then "0x{color1.strip}" else "0xec6a88" }"
green = "${ if wal then "0x{color2.strip}" else "0x3fdaa4" }"
yellow = "${ if wal then "0x{color3.strip}" else "0xefb993" }"
blue = "${ if wal then "0x{color4.strip}" else "0x3fc6de" }"
magenta = "${ if wal then "0x{color5.strip}" else "0xb771dc" }"
cyan = "${ if wal then "0x{color6.strip}" else "0x6be6e6" }"
white = "${ if wal then "0x{color7.strip}" else "0xd9e0ee" }"

[colors.primary]
background = "${ if wal then "0x{color0.strip}" else "0x292a37" }"
foreground = "${ if wal then "0x{color15.strip}" else "0xd9e0ee" }"

[env]
TERM = "xterm-256color"

[font]
size = 11

[font.bold]
family = "Source Code Pro"
style = "Bold"

[font.bold_italic]
family = "Source Code Pro"
style = "Bold Italic"

[font.italic]
family = "Source Code Pro"
style = "Italic"

[font.normal]
family = "Source Code Pro"
style = "Regular"

[font.offset]
x = 0
y = 1

[scrolling]
history = 5000

[shell]
args = ["--login"]
program = "fish"

[window]
title = "Alacritty"

[window.class]
general = "Alacritty"
instance = "Alacritty"

[window.padding]
x = 6
y = 6
'';
in {
  programs.alacritty = {
    enable = true;
  };

  home.file = if config.wal.enable then {
    ".config/wpg/templates/alacritty.toml.base".text = toml true;
    ".config/alacritty/alacritty.toml".source =
      config.lib.file.mkOutOfStoreSymlink
      "/home/zeroth/.config/wpg/templates/alacritty.toml";
  }
  else {
    ".config/alacritty/alacritty.toml".text = toml false;
  };
}
