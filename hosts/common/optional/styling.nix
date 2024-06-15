{pkgs, configLib, ...}: {
    environment.systemPackages = [
        pkgs.base16-schemes
    ];
    stylix = {
        enable = true;
        base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
        image = configLib.relativeToRoot "wallpapers/misty_mountains.jpg";

    # stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    };
}