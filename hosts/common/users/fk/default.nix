{ pkgs, config, lib, configVars, configLib, inputs, ...}: 
let 
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
  fullUserConfig = lib.optionalAttrs (!configVars.isMiniamal)
    {
      users.users.${configVars.username} = {
        packages = [ pkgs.home-manager ];
      };

      home-manager.users.${configVars.username} = import (configLib.relativeToRoot "home/${configVars.username}/${config.networking.hostName}.nix");
    };
in
{
  config = lib.recursiveUpdate fullUserConfig
  {
    # Define a user account. Don't forget to set a password with ‘passwd’.
    # users.mutableUsers = true;
    users.users.fk = {
      isNormalUser = true;
      description = "Felix";
      extraGroups = [ 
          "wheel" 
      ] ++ ifTheyExist [
          "networkmanager" 
          "audio"
          "video"
          "docker"
          "git"
      ];
      hashedPassword = "$y$j9T$.MRwT6Xn6Ero8.XavKxX..$fDymN.WLA8PGkJuFdjRm87D2kjooIwFoQe/JqUEyBmC";
      shell = pkgs.zsh;
    };

    programs = {
      git.enable = true;
      zsh.enable = true;
    };
    environment.systemPackages = [
      pkgs.just
      pkgs.rsync
    ];
  };
}