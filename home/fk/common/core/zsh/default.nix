{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    #autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    dotDir = ".config/zsh";


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
      share = true;
    };

    plugins = [
      {
        name = "powerlevel10k-config";
        src = ./p10k;
        file = "p10k.zsh";
      }
      {
        name = "zsh-powerlevel10k";
        src = "${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/";
        file = "powerlevel10k.zsh-theme";
      }
    ];

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "python" "rust" "sudo" ];
    };

    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-autosuggestions"; } 
        { name = "MichaelAquilina/zsh-you-should-use"; }
        { name = "agkozak/zsh-z"; }
      ];
    };

    initExtraFirst = ''
    # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
    # Initialization code that may require console input (password prompts, [y/n]
    # confirmations, etc.) must go above this block; everything else may go below.
    if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
      source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
    fi
    '';

    initExtra = ''
    # Add ctrl backspace to delete word
    bindkey '^H' backward-kill-word
    '';


  };
}