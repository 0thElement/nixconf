{ pkgs, pkgsNvim, nixConfigName, inputs, ... }:
{
  imports = [
    inputs.home-manager.nixosModules.default
  ];

  wsl = {
    enable = true;
    wslConf = {
      automount.root = "/mnt";
      interop.appendWindowsPath = false;
      network.generateHosts = false;
      user.default = "zeroth";
    };
    defaultUser = "zeroth";
    startMenuLaunchers = true;
  };

  # NixOS settings
  nix.settings = {
    auto-optimise-store = true;
    experimental-features = [ "nix-command" "flakes" ];
  };
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  networking.hostName = "zeroth";

  # Shell
  programs.fish.enable = true;
  environment.pathsToLink = ["/share/fish"];
  environment.shells = [ pkgs.fish ];
  environment.enableAllTerminfo = true;
  security.sudo.wheelNeedsPassword = false;

  disabledModules = [ "services/programs/man.nix" ];
  documentation.man.enable = false;

  environment.sessionVariables = {
    NIXOS_CONFIG = "/home/zeroth/nixconf/";
  };

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

  # User & home
  users.users.zeroth = {
    isNormalUser = true;
    description = "0thElement";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.fish;
    uid = 1000;
    packages = [];
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs pkgsNvim nixConfigName; };
    users = {
      "zeroth" = import ./home.nix;
    };
  };

  # Packages
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    vim
    wget
  ];

  system.stateVersion = "24.05";
}
