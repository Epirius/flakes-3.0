{ pkgs, ... }: {
  programs.vscode = {
    enable = true;
    enableExtensionUpdateCheck = true;
    extensions = with pkgs.vscode-extensions; [
      # see: https://search.nixos.org/packages?channel=23.05&from=0&size=50&sort=relevance&type=packages&query=vscode-extensions
      esbenp.prettier-vscode
      dbaeumer.vscode-eslint
      bradlc.vscode-tailwindcss
      rust-lang.rust-analyzer
      asvetliakov.vscode-neovim
      tomoki1207.pdf
      bbenoist.nix
    ];
    userSettings = {
      "[nix]"."editor.tabSize" = 2;
      "workbench.sideBar.location" = "right";
      # https://github.com/danth/stylix/issues/155
    };
  };
}