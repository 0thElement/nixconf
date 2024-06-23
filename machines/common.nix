{ pkgs, pkgsNvim, inputs, ... }:
{
  imports = [
    inputs.home-manager.nixosModules.default
    inputs.xremap-flake.nixosModules.default
  ];

  # NixOS settings
  nix = {
    settings.auto-optimise-store = true;
    settings.experimental-features = [ "nix-command" "flakes" ]; gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  # Boot settings
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Timezone, locale & input
  time.timeZone = "Asia/Bangkok";
  i18n.defaultLocale = "ja_JP.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ja_JP.UTF-8";
    LC_IDENTIFICATION = "ja_JP.UTF-8";
    LC_MEASUREMENT = "ja_JP.UTF-8";
    LC_MONETARY = "ja_JP.UTF-8";
    LC_NAME = "ja_JP.UTF-8";
    LC_NUMERIC = "ja_JP.UTF-8";
    LC_PAPER = "ja_JP.UTF-8";
    LC_TELEPHONE = "ja_JP.UTF-8";
    LC_TIME = "ja_JP.UTF-8";
  };
  i18n.inputMethod.enabled = "fcitx5";
  i18n.inputMethod.fcitx5.addons = with pkgs; [ fcitx5-mozc fcitx5-unikey ];

  # Services
  services.xserver = {
    enable = true;
    xkb.layout = "us";
  };
  # Bluetooth
  services.blueman.enable = true; 
  # Flatpak for unity
  services.flatpak.enable = true;
  # Battery status
  services.upower.enable = true;
  # USB
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  environment.sessionVariables = {
    WLR_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
    NIXOS_CONFIG = "/home/zeroth/nixconf/";
  };

  disabledModules = [ "services/programs/man.nix" ];
  documentation.man.enable = false;

  # Shell
  programs.fish.enable = true;

  # User & home
  users.users.zeroth = {
    isNormalUser = true;
    description = "0thElement";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    shell = pkgs.fish;
    uid = 1000;
    packages = [];
  };

  services.getty.autologinUser = "zeroth";

  home-manager = {
    extraSpecialArgs = { inherit inputs pkgsNvim; };
    users = {
      "zeroth" = import ./home.nix;
    };
  };
  virtualisation.docker.enable = true;

  # Packages
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    vim
    wget
    docker-compose
    steam-run
    at-spi2-core
  ];

  programs.nix-ld.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  # Fonts
  fonts = {
    packages = with pkgs; [
      source-code-pro
      noto-fonts
      noto-fonts-cjk
      twitter-color-emoji
      font-awesome
      powerline-fonts
      (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
    ];
    fontconfig = {
      hinting.autohint = true;
    };
  };

  # Desktop
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
    ];
  };

  sound.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Hardware
  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General.Experimental = true;
      };
    };
    opengl.enable = true;
    nvidia.modesetting.enable = true;
  };

  services.xremap = {
    withWlroots = true;
    userName = "zeroth";
    yamlConfig = ''
      modmap:
        - name: CapsLock to RightCtrl/Esc
          remap:
            CapsLock:
              held: Ctrl_R
              alone: Esc
              alone_timeout: 500
    '';
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
}
