{
  description = "Fk flake";
  # inspiered by https://github.com/EmergentMind/nix-config

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable"; # also see 'unstable-packages' overlay at 'overlays/default.nix"

    hardware.url = "github:nixos/nixos-hardware";
    
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    nixvim = {
      #url = "github:nix-community/nixvim/nixos-23.11";
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: 
  let
    inherit (self) outputs;
    inherit (nixpkgs) lib;
    configLib = import ./lib {inherit lib; };
    configVars = import ./vars { inherit inputs lib; };
    specialArgs = { inherit inputs outputs configLib nixpkgs; };
  in
  {
    # Costum modules to enable special functionality
    nixosModules = import ./modules/nixos;
    

    nixosConfigurations = {
      xps = nixpkgs.lib.nixosSystem {
        # specialArgs = {inherit inputs;};
        inherit specialArgs;
        modules = [
          home-manager.nixosModules.home-manager {
            home-manager.extraSpecialArgs = specialArgs;
          }
          ./hosts/xps
          # inputs.home-manager.nixosModules.default
        ];
      };
    };
  };
}
