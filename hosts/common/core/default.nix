{ inputs, outputs, config, pkgs, configLib, ... }: {
  imports = (configLib.scanPaths ./.)
    ++ [ inputs.home-manager.nixosModules.home-manager ]
    ++ (builtins.attrValues outputs.nixosModules);

  home-manager.extraSpecialArgs = { inherit inputs outputs; };

  time.timeZone = "Europe/Oslo";
  i18n.defaultLocale = "en_US.UTF-8";

  
  nixpkgs.config.allowUnfree = true;
  



  nix = {
    settings.experimental-features = ["nix-command" "flakes"];
    settings.auto-optimise-store = true;
    gc = {
      automatic = true;
      dates = "monthly";
      options = "--delete-older-than 14d";
    };
  };

  # Package for using yubikeys for my age private key
  environment.systemPackages = [
    pkgs.age-plugin-yubikey
    pkgs.age
  ];
  services.pcscd.enable = true;
  
}