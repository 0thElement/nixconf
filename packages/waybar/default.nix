{ pkgs, ...}:
{
  home.packages = [
    pkgs.brightnessctl
    pkgs.pulseaudio
  ];

  programs.waybar = {
    enable = true;
    systemd.enable = true;
    style = ''
    @define-color white      #d9e0ee;
    @define-color black      #292a37;
    @define-color text       #d9e0ee;
    @define-color lightgray  #686868;
    @define-color darkgray   #393a4d;
    @define-color red        #ec6a88;
    @define-color purp       rgba(176, 114, 209,0.6);

    @define-color black-transparent-1 rgba(41, 42, 55, 0.1);
    @define-color black-transparent-2 rgba(41, 42, 55, 0.2);
    @define-color black-transparent-3 rgba(41, 42, 55, 0.3);
    @define-color black-transparent-4 rgba(41, 42, 55, 0.4);
    @define-color black-transparent-5 rgba(41, 42, 55, 0.5);
    @define-color black-transparent-6 rgba(41, 42, 55, 0.6);
    @define-color black-transparent-7 rgba(41, 42, 55, 0.7);
    @define-color black-transparent-8 rgba(41, 42, 55, 0.8);
    @define-color black-transparent-9 rgba(41, 42, 56, 0.9);
    @define-color black-solid         rgba(41, 42, 55, 1.0);

    * {
      font-family: Source Code Pro, Material Design Icons Desktop;
      font-size: 14px;
    }

    window#waybar {
      background-color: rgba(0,0,0,0);
      color: @text;
      border-radius: 8px;
    }

    tooltip {
      background: @black-solid;
      border: 1px solid @darkgray;
      border-radius: 8px;
    }

    tooltip label {
      color: @text;
    }

    #workspaces {
      /* border: 1px solid #10171b; */
      /* border-radius: 20px; */
      /* margin-top: 0; */
      /* margin-bottom: 0; */
      margin-top: 10px;
      margin-left: 1px;
      margin-right: 1px;
    }

    #workspaces button {
      background-color: @transparent;
      color: @text;
      margin-bottom: 6px;
      padding-top: 2px;
      padding-bottom: 2px;
      border-radius: 8px;
      transition: all 0.3s ease;
    }

    #workspaces button:hover {
      background-color: @black-transparent-6;
      box-shadow: inherit;
      text-shadow: inherit;
      color: @white;
      transition: all 0.3s ease;
    }

    #workspaces button.focused,
    #workspaces button.active {
      background-color: @purp;
      color: @white;
      transition: all 0.3s ease;
      animation: colored-gradient 10s ease infinite;
    }

    /* #workspaces button.focused:hover,
    #workspaces button.active:hover {
      background-color: @white;
      transition: all 1s ease;
    } */

    #workspaces button.urgent {
      background-color: @red;
      color: @black;
      transition: all 0.3s ease;
    }

    #taskbar {
      border-radius: 8px;
      margin-top: 4px;
      margin-bottom: 4px;
      margin-left: 1px;
      margin-right: 1px;
    }

    #taskbar button {
      color: @text;
      padding: 1px 8px;
      margin-left: 1px;
      margin-right: 1px;
    }

    #taskbar button:hover {
      background: transparent;
      border: 1px solid @darkgray;
      border-radius: 8px;
      transition: all 0.3s ease;
      animation: colored-gradient 10s ease infinite;
    }

    /* #taskbar button.maximized {} */

    /* #taskbar button.minimized {} */

    #taskbar button.active {
      border: 1px solid @darkgray;
      border-radius: 8px;
      transition: all 0.3s ease;
      animation: colored-gradient 10s ease infinite;
    }

    /* -------------------------------------------------------------------------------- */

    #custom-launcher,
    /* #window, */
    #submap,
    #mode,
    #tray,
    #cpu,
    #memory,
    #backlight,
    #pulseaudio.audio,
    #pulseaudio.microphone,
    #network.wlo1,
    #network.eno1,
    #bluetooth,
    #battery,
    #clock,
    #custom-powermenu,
    #custom-notification {
      background-color: transparent;
      color: @text;
      padding: 1px 8px;
      margin-top: 8px;
      margin-bottom: 8px;
      margin-left: 0;
      margin-right: 0;
      border-radius: 20px;
      transition: all 0.3s ease;
    }

    #submap {
      border: 0;
    }

    /* -------------------------------------------------------------------------------- */

    /* #custom-launcher {
      background-color: @darkgray;
      color: @black;
    } */

    /* #custom-launcher:hover {
      color: @white;
    } */

    /* #custom-powermenu {
      background-color: @red;
      color: @black;
    }

    #custom-powermenu:hover {
      color: @white;
    } */

    /* -------------------------------------------------------------------------------- */

    /* If workspaces is the leftmost module, omit left margin */
    .modules-left > widget:first-child > #workspaces button,
    .modules-left > widget:first-child > #taskbar button,
    .modules-left > widget:first-child > #custom-launcher,
    .modules-left > widget:first-child > #window,
    .modules-left > widget:first-child > #tray,
    .modules-left > widget:first-child > #cpu,
    .modules-left > widget:first-child > #memory,
    .modules-left > widget:first-child > #backlight,
    .modules-left > widget:first-child > #pulseaudio.audio,
    .modules-left > widget:first-child > #pulseaudio.microphone,
    .modules-left > widget:first-child > #network.wlo1,
    .modules-left > widget:first-child > #network.eno1,
    .modules-left > widget:first-child > #bluetooth,
    .modules-left > widget:first-child > #battery,
    .modules-left > widget:first-child > #clock,
    .modules-left > widget:first-child > #custom-powermenu,
    .modules-left > widget:first-child > #custom-notification {
      margin-top: 0;
    }

    .modules-right > widget:last-child > #workspaces button,
    .modules-right > widget:last-child > #taskbar button,
    .modules-right > widget:last-child > #custom-launcher,
    .modules-right > widget:last-child > #window,
    .modules-right > widget:last-child > #tray,
    .modules-right > widget:last-child > #cpu,
    .modules-right > widget:last-child > #memory,
    .modules-right > widget:last-child > #backlight,
    .modules-right > widget:last-child > #pulseaudio.audio,
    .modules-right > widget:last-child > #pulseaudio.microphone,
    .modules-right > widget:last-child > #network.wlo1,
    .modules-right > widget:last-child > #network.eno1,
    .modules-right > widget:last-child > #bluetooth,
    .modules-right > widget:last-child > #battery,
    .modules-right > widget:last-child > #clock,
    .modules-right > widget:last-child > #custom-powermenu,
    .modules-right > widget:last-child > #custom-notification {
      margin-bottom: 10px;
    }

    .modules-left {
      background-color: transparent;
      margin-left: 8px;
      margin-right: 2px;
      margin-top: 3px;
      margin-bottom: 10px;
      padding-top: 7px;
      padding-bottom: 7px;
      border-radius: 8px;
    }

    /* -------------------------------------------------------------------------------- */

    #tray {
      background-color: transparent;
      padding: 1px 8px;
    }

    #tray > .passive {
      -gtk-icon-effect: dim;
    }
    #tray > .needs-attention {
      -gtk-icon-effect: highlight;
      background-color: @red;
    }
    '';

    settings = [{
      layer = "top";
      position = "left";
      width = 16;
      margin-top = 10;
      margin-bottom = 10;
      margin-left = 5;
      margin-right = 0;
      spacing = 0;
      gtk-layer-shell = true;
      modules-left = [
        "pulseaudio#audio"
        "network#wlo1"
        "network#eno1"
        "bluetooth"
        "tray"
        "hyprland/workspaces"
      ];
      clock = {
        interval = 1;
        tooltip = true;
        tooltip-format = "{calendar}";
        calendar = {
          mode = "year";
          mode-mon-col = 3;
          format = {
            today = "<span color='#0dbc79'>{}</span>";
          };
        };
      };
      "hyprland/workspaces" = {
        format = "{icon}";
        format-icons = {
          "1" = "1";
          "2" = "2";
          "3" = "3";
          "4" = "4";
          "5" = "5";
          "6" = "6";
          "7" = "7";
          "8" = "8";
          "9" = "9";
          "default" = "1";
        };
        on-click = "activate";
      };
      modules-right = [
        "cpu"
        "memory"
        "battery"
        "clock"
      ];
      tray = {
        icon-size = 14;
        spacing = 8;
      };
      cpu = {
        format = "󰻠 {usage}";
        on-click = "";
        tooltip = false;
      };
      memory = {
        format = "󰍛 {percentage}";
        on-click = "";
        tooltip = false;
      };
      "pulseaudio#audio" = {
        format = "{icon}";
        format-bluetooth = "󰂯\n{icon}";
        format-bluetooth-muted = "󰂯\n󰖁";
        format-muted = "󰖁";
        format-icons = {
          headphone = "󰋋";
          hands-free = "󰋋";
          headset = "󰋋";
          phone = "";
          portable = "";
          car = "";
          default = [
            "󰕿"
            "󰖀"
            "󰕾"
          ];
        };
        on-click = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
        on-scroll-up = "pactl set-sink-volume @DEFAULT_SINK@ +1%";
        on-scroll-down = "pactl set-sink-volume @DEFAULT_SINK@ -1%";
        tooltip = true;
        tooltip-format = "{icon} {desc} {volume}%";
      };
      "network#wlo1" = {
        interval = 1;
        interface = "wlo1";
        format-icons = [
          "󰤯"
          "󰤟"
          "󰤢"
          "󰤥"
          "󰤨"
        ];
        format-wifi = "{icon}";
        format-disconnected = "";
        # "format-alt": "{icon} {essid} | 󱑽 {signalStrength}% {signaldBm} dBm {frequency} MHz";
        on-click = "nm-connection-editor";
        tooltip = true;
        tooltip-format = "󰢮 {ifname}\n󰩟 {ipaddr}/{cidr}\n{icon} {essid}\n󱑽 {signalStrength}% {signaldBm} dBm {frequency} MHz\n󰞒 {bandwidthDownBytes}\n󰞕 {bandwidthUpBytes}";
      };
      "network#eno1" = {
        interval = 1;
        interface = "eno1";
        format-icons = [
          "󰈀"
        ];
        format-ethernet = "{icon}";
        # "format-disconnected": "{icon}";
        format-disconnected = "";
        # "format-alt": "{icon} | 󰢮 {ifname} | 󰩟 {ipaddr}/{cidr}";
        on-click = "";
        tooltip = true;
        tooltip-format = "󰢮 {ifname}\n󰩟 {ipaddr}/{cidr}\n󰞒 {bandwidthDownBytes}\n󰞕 {bandwidthUpBytes}";
      };
      bluetooth = {
        format-disabled = "";
        format-off = "";
        format-on = "󰂯";
        format-connected = "󰂯";
        format-connected-battery = "󰂯";
        tooltip-format-connected = "{device_alias} 󰂄{device_battery_percentage}%";
        on-click = "blueman-manager";
        tooltip = true;
      };
      battery = {
        states = {
          warning = 30;
          critical = 1;
        };
        format = "{icon} {capacity}";
        format-charging = "󰂄 {capacity}";
        format-plugged = "󱘖 {capacity}";
        format-icons = [
          "󰁺"
          "󰁻"
          "󰁼"
          "󰁽"
          "󰁾"
          "󰁿"
          "󰂀"
          "󰂁"
          "󰂂"
          "󰁹"
        ];
        on-click = "";
        tooltip = false;
      };
    }];
  };
}
