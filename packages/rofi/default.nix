{ inputs, pkgs, lib, config, ... }:
with lib;
{
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
    theme = let inherit (config.lib.formats.rasi) mkLiteral; in {
      "*" = {
        bordercolor =                 mkLiteral "#b072d1";
        border-color =                mkLiteral "@bordercolor";
        foreground =                  mkLiteral "#d9e0ee";
        background =                  mkLiteral "#292a37";
        red =                         mkLiteral "#ec6a88";
        blue =                        mkLiteral "rgba ( 38, 139, 210, 100 % )";
        lightbg =                     mkLiteral "rgba ( 238, 232, 213, 100 % )";
        lightfg =                     mkLiteral "rgba ( 88, 104, 117, 100 % )";
        separatorcolor =              mkLiteral "rgba ( 195, 198, 200, 100 % )";
        background-color =            mkLiteral "rgba ( 0, 0, 0, 0 % )";

        normal-background =           mkLiteral "rgba (0, 0, 0, 0)";
        alternate-normal-background = mkLiteral "@normal-background";
        selected-normal-background =  mkLiteral "rgba ( 176, 114, 209, 60 % )";

        normal-foreground =           mkLiteral "@foreground";
        alternate-normal-foreground = mkLiteral "@foreground";
        selected-normal-foreground =  mkLiteral "@foreground";

        active-foreground =           mkLiteral "rgba ( 0, 188, 212, 100 % )";
        alternate-active-foreground = mkLiteral "@active-foreground";
        selected-active-foreground =  mkLiteral "@active-foreground";

        active-background =           mkLiteral "@normal-background";
        alternate-active-background = mkLiteral "@normal-background";
        selected-active-background =  mkLiteral "@selected-normal-background";

        urgent-foreground =           mkLiteral "@red";
        alternate-urgent-foreground = mkLiteral "@urgent-foreground";
        selected-urgent-foreground =  mkLiteral "@foreground";

        urgent-background =           mkLiteral "@normal-background";
        alternate-urgent-background = mkLiteral "@urgent-background";
        selected-urgent-background =  mkLiteral "@urgent-foreground";

        spacing =                     2;
      };
      "window" = {
        background-color = mkLiteral "@background";
        border =           4;
        padding =          6;
        border-radius =    8;
      };
      "mainbox" = {
        border =  0;
        padding = 0;
      };
      "message" = {
        border =       mkLiteral "1px dash 0px 0px ";
        border-color = mkLiteral "@separatorcolor";
        padding =      mkLiteral "1px ";
      };
      "textbox" = {
        text-color = mkLiteral "@foreground";
      };
      "listview" = {
        fixed-height = 0;
        border =       mkLiteral "2px dash 0px 0px ";
        border-color = mkLiteral "@separatorcolor";
        spacing =      mkLiteral "2px ";
        scrollbar =    true;
        padding =      mkLiteral "2px 0px 0px ";
      };
      "element" = {
        border =  0;
        padding = mkLiteral "1px ";
      };
      "element-text" = {
        background-color = mkLiteral "inherit";
        text-color =       mkLiteral "inherit";
      };
      "element normal.normal" = {
        background-color = mkLiteral "@normal-background";
        text-color =       mkLiteral "@normal-foreground";
      };
      "element.normal.urgent" = {
        background-color = mkLiteral "@urgent-background";
        text-color =       mkLiteral "@urgent-foreground";
      };
      "element.normal.active" = {
        background-color = mkLiteral "@active-background";
        text-color =       mkLiteral "@active-foreground";
      };
      "element.selected.normal" = {
        background-color = mkLiteral "@selected-normal-background";
        text-color =       mkLiteral "@selected-normal-foreground";
      };
      "element.selected.urgent" = {
        background-color = mkLiteral "@selected-urgent-background";
        text-color =       mkLiteral "@selected-urgent-foreground";
      };
      "element.selected.active" = {
        background-color = mkLiteral "@selected-active-background";
        text-color =       mkLiteral "@selected-active-foreground";
      };
      "element.alternate.normal" = {
        background-color = mkLiteral "@alternate-normal-background";
        text-color =       mkLiteral "@alternate-normal-foreground";
      };
      "element.alternate.urgent" = {
        background-color = mkLiteral "@alternate-urgent-background";
        text-color =       mkLiteral "@alternate-urgent-foreground";
      };
      "element.alternate.active" = {
        background-color = mkLiteral "@alternate-active-background";
        text-color =       mkLiteral "@alternate-active-foreground";
      };
      "scrollbar" = {
        width =        mkLiteral "4px ";
        border =       0;
        handle-width = mkLiteral "8px ";
        padding =      0;
      };
      "mode-switcher" = {
        border =       mkLiteral "2px dash 0px 0px ";
        border-color = mkLiteral "@separatorcolor";
      };
      "button.selected" = {
        background-color = mkLiteral "@selected-normal-background";
        text-color =       mkLiteral "@selected-normal-foreground";
      };
      "inputbar" = {
        spacing =    0;
        text-color = mkLiteral "@normal-foreground";
        padding =    mkLiteral "1px ";
      };
      "case-indicator" = {
        spacing =    0;
        text-color = mkLiteral "@normal-foreground";
      };
      "entry" = {
        spacing =    0;
        text-color = mkLiteral "@normal-foreground";
      };
      "prompt" = {
        spacing =    0;
        text-color = mkLiteral "@normal-foreground";
      };
      "inputbar" = {
        children = map mkLiteral [
          "prompt"
          "textbox-prompt-colon"
          "entry"
          "case-indicator"
        ];
      };
      "textbox-prompt-colon" = {
        expand =     false;
        str =        ":";
        margin =     mkLiteral "0px 0.3em 0em 0em ";
        text-color = mkLiteral "@normal-foreground";
      };
    };
  };
}
