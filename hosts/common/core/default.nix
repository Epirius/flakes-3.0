{ inputs, outputs, config, pkgs, configLib, ... }: {
  imports = (configLib.scanPaths ./.)
    ++ [ inputs.home-manager.nixosModules.home-manager ]
    ++ (builtins.attrValues outputs.nixosModules);

  home-manager.extraSpecialArgs = { inherit inputs outputs; };

  time.timeZone = "Europe/Oslo";
  i18n.defaultLocale = "en_US.UTF-8";


  nixpkgs.config.allowUnfree = true;

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "nb_NO.UTF-8";
    LC_IDENTIFICATION = "nb_NO.UTF-8";
    LC_MEASUREMENT = "nb_NO.UTF-8";
    LC_MONETARY = "nb_NO.UTF-8";
    LC_NAME = "nb_NO.UTF-8";
    LC_NUMERIC = "nb_NO.UTF-8";
    LC_PAPER = "nb_NO.UTF-8";
    LC_TELEPHONE = "nb_NO.UTF-8";
    LC_TIME = "nb_NO.UTF-8";
  };

  security.polkit.enable = true;

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
  environment.systemPackages = with pkgs; [
    age-plugin-yubikey
    age

    blueman
    just
    rsync
    bat
    neofetch
    firefox
    ripgrep
    tldr
    vscode
    wofi
    wireplumber # dont know if i need this, i added it when i ment to add pavucontrol
    pavucontrol
  ];

  services = {
    pcscd.enable = true;
  };

}
