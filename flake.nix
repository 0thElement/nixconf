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
  };

  outputs = { self, nixpkgs, nixpkgsNvim, ... }@inputs:
  let system = "x86_64-linux"; in
  {
    nixosConfigurations.default = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit inputs;
        pkgsNvim = import nixpkgsNvim {
          inherit system;
          config.allowUnfree = true;
        };
      };
      modules = [
        ./machines/laptop/configuration.nix
        inputs.home-manager.nixosModules.default
      ];
    };
  };
}
