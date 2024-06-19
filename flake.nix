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

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    
    nixvim = {
      #url = "github:nix-community/nixvim/nixos-23.11";
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: 
  let
    inherit (self) outputs;
    inherit (nixpkgs) lib;
    forAllSystems = nixpkgs.lib.genAtters [
      "x86_64-linux"
    ];
    configLib = import ./lib {inherit lib; };
    configVars = import ./vars { inherit inputs lib; };
    
    background-image = builtins.fetchurl {
        url = "https://github.com/Epirius/wallpapers/blob/main/wallpapers/murky_peaks.jpg?raw=true";
        sha256 = "Rnqa1k8onl2b+xyWJ0Yp/yWzQKFuhr8aSydHYeqJi3Q=";
    };
    specialArgs = { inherit inputs outputs configLib configVars nixpkgs background-image; };
  in
  {
    # Costum modules to enable special functionality
    nixosModules = import ./modules/nixos;
    homeManagerModules = import ./modules/home-manager;

    overlays = import ./overlays { inherit inputs outputs; };

    
    # formatter
    formatter = forAllSystems
      (system:
        nixpkgs.legacyPackages.${system}.nixpkgs-fmt
      );
    
    devShells = forAllSystems
      (system:
        let pkgs = nixpkgs.legacyPackages.${system};
        in import ./pkgs { inherit pkgs; } 
      );
    
    nixosConfigurations = {
      xps = nixpkgs.lib.nixosSystem {
        # specialArgs = {inherit inputs;};
        inherit specialArgs;
        modules = [
          home-manager.nixosModules.home-manager {
            home-manager.extraSpecialArgs = specialArgs;
            home-manager.backupFileExtension = "hm-backup";

          }
          ./hosts/xps
          # inputs.home-manager.nixosModules.default
          inputs.stylix.nixosModules.stylix
        ];
      };
    };
  };
}
