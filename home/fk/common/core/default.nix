{ config, lib, pkgs, outputs, configLib, ...}:
{
  imports = (configLib.scanPaths ./.)
    ++ (builtins.attrValues outputs.homeManagerModules);
  

  home = {
    username = lib.mkDefault "fk";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    stateVersion = lib.mkDefault "24.05";
    sessionPath = [
      "$HOME/.local.bin"
    ];
    sessionVariables = {
      SHELL = "zsh";
      TERM = "kitty";
      TERMINAL = "kitty";
      EDITOR = "nvim";
    };
  };

  home.packages = builtins.attrValues {
    inherit (pkgs)

    # Packages that don't have costum configs go here
    brightnessctl
    coreutils
    eza
    fd
    findutils
    fzf
    ripgrep
    tree
    unzip
    zip
    wget;
  };

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = (_: true);
    };
  };

  programs = {
    gh.enable = true;
    home-manager.enable = true;
    kitty = {
      enable = true;
      settings = {
        scrollback_lines = 5000;
        enable_audio_bell = false;
        background_opacity = lib.mkForce "0.7";
      };
    };
    ssh = {
      enable = true;
      addKeysToAgent = "yes";

      matchBlocks = {
        "git" = {
          host = "github.com";
          user = "git";
          identityFile = [
            "~/.ssh/id_ed25519"
          ];
        };
      };
    };
  };

  services = {
    gnome-keyring.enable = true;
    ssh-agent.enable = true;
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}