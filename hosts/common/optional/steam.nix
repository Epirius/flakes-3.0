{ pkgs, ... }: {
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true; # fix any scaling issues
  };
  programs.gamemode.enable = true; # improve performance

  environment.systemPackages = with pkgs; [
    mangohud # program for fps overlay
    protonup # proton improvements
    #bottles # Wine  frontend for running windows apps
  ];

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATH = "/home/user/.steam/root/compatibilitytools.d"; # run ```protonup```
  };


  # in steam launch options add ```gamemoderun %command% mangohud %command% gamescope %command%```
  
  
}