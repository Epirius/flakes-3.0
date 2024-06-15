{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;


    shellAliases = {
      l = "exa -la";
      ls = "exa";
      find = "fd";
      vim = "nvim";
      ".." = "cd ..";
      reload = "source ~/.zshrc";
      c = "clear";
      cg = "cargo";
      edit = "lapce"; # TODO add program
      color = "hyprpicker -a"; # TODO add program
      picker = "hyprpicker -a"; # TODO add program
      image = "feh"; # TODO add program
      "code ," = "code .";
      switch = "sudo nixos-rebuild switch --flake ~/nixos/.#xps";
    };

    history = {
      size = 10000;
      # path = "${config.xdg.dataHome}/zsh/history";
    };

    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-autosuggestions"; } 
        { name = "MichaelAquilina/zsh-you-should-use"; }
        { name = "agkozak/zsh-z"; }
      ];
      
    };
  };
}