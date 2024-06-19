{ pkgs, ... }: {
  programs.git = {
    enable = true;
    userName = "Felix Kaasa";
    userEmail = "mrKaasa@protonmail.com";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };
}