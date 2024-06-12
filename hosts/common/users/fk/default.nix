{ pkgs, config,  ...}: 
let 
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
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
    zsh.enable = true;
    git.enable = true;
  };
  environment.systemPackages = [
    pkgs.just
    pkgs.rsync
  ];
}