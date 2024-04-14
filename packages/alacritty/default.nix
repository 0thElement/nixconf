{ pkgs, input, lib, ... }:
with lib;
let
  makeFont = style: { family = "Source Code Pro"; style = style; };
in
{
  programs.alacritty = {
    enable = true;
    settings = {
      env.TERM = "xterm-256color";

      window = {
        padding = {
          x = 6;
	  y = 6;
        };
	title = "Alacritty";
	class = {
	  instance = "Alacritty";
	  general = "Alacritty";
	};
      };

      scrolling.history = 5000;

      font = {
        normal = makeFont "Regular";
        bold = makeFont "Bold";
        italic = makeFont "Italic";
        bold_italic = makeFont "Bold Italic";
	size = 11;
	offset = {
	  x = 0;
	  y = 1;
	};
      };

      colors = {
        primary.foreground = "0xd9e0ee";
        primary.background = "0x292a37";
        normal.black = "0x303241";
        normal.red = "0xec6a88";
        normal.green = "0x3fdaa4";
        normal.yellow = "0xefb993";
        normal.blue = "0x3fc6de";
        normal.magenta = "0xb771dc";
        normal.cyan = "0x6be6e6";
        normal.white = "0xd9e0ee";
        bright.black ="0x393a4d";
        bright.red ="0xe95678";
        #bright.green ="0x29d398";
        bright.green ="0x65ebcc";
        bright.yellow ="0xefb993";
        bright.blue ="0x26bbd9";
        bright.magenta ="0xb072d1";
        bright.cyan ="0x59e3e3";
        bright.white ="0xd9e0ee";
        draw_bold_text_with_bright_colors = true;
      };

      shell = {
        program = "fish";
	args = [ "--login" ];
      };
    };
  };
}
