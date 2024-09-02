{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    xremap-flake.url = "github:xremap/nix-flake";
    nixpkgsNvim.url = "github:nixos/nixpkgs/57d6973abba7ea108bac64ae7629e7431e0199b6";
    ags.url = "github:Aylur/ags";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
  };

  outputs = { self, nixpkgs, nixpkgsNvim, nixos-wsl, ... }@inputs:
  let
    system = "x86_64-linux";
    pkgsNvim = import nixpkgsNvim {
      inherit system;
      configu.allowUnfree = false;
    };
  in
  {
    nixosConfigurations.default = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit inputs;
        inherit pkgsNvim;
        nixConfigName = "default";
    };
      modules = [
        ./machines/laptop/configuration.nix
        inputs.home-manager.nixosModules.default
      ];
    };
    nixosConfigurations.wsl = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {
        inputs = {
          home-manager = inputs.home-manager;
        };
        inherit pkgsNvim;
        nixConfigName = "wsl";
      };
      modules = [
        nixos-wsl.nixosModules.wsl
        ./machines/wsl/configuration.nix
      ];
    };
  };
}
