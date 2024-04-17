
{ config, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
  ];

  nix = {
    settings.auto-optimise-store = true;
    settings.experimental-features = [ "nix-command" "flakes" ];
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  time.timeZone = "Asia/Bangkok";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "vi_VN";
    LC_IDENTIFICATION = "vi_VN";
    LC_MEASUREMENT = "vi_VN";
    LC_MONETARY = "vi_VN";
    LC_NAME = "vi_VN";
    LC_NUMERIC = "vi_VN";
    LC_PAPER = "vi_VN";
    LC_TELEPHONE = "vi_VN";
    LC_TIME = "vi_VN";
  };
  i18n.inputMethod.enabled = "fcitx5";
  i18n.inputMethod.fcitx5.addons = with pkgs; [ fcitx5-mozc fcitx5-unikey ];

  services.xserver = {
    enable = true;
    xkb.layout = "us";
  };

  services.blueman.enable = true;
  services.flatpak.enable = true;

  environment.sessionVariables = {
    WLR_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
    NIXOS_CONFIG = "/etc/nixos/configuration.nix";
    NIXOS_CONFIG_DIR = "/etc/nixos/";
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

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

  programs.fish.enable = true;
  users.users.zeroth = {
    isNormalUser = true;
    description = "0thElement";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    shell = pkgs.fish;
    uid = 1000;
    packages = with pkgs; [];
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "zeroth" = import ./home.nix;
    };
  };

  services.getty.autologinUser = "zeroth";
  nixpkgs.config.allowUnfree = true;
  virtualisation.docker.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    neovim
    wget
    docker-compose
    steam-run
  ];

  fonts = {
    packages = with pkgs; [
      source-code-pro
      noto-fonts
      noto-fonts-cjk
      twitter-color-emoji
      font-awesome
      (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
    ];
    fontconfig = {
      hinting.autohint = true;
    };
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
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

  # Do not change this, future me
  system.stateVersion = "23.11";

}
