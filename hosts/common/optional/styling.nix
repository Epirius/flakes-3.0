{pkgs, configLib, background-image, ...}: {
    environment.systemPackages = [
        pkgs.base16-schemes
    ];
    stylix = {
        enable = true;
        base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-macchiato.yaml";
        image = background-image;
    };
    
}