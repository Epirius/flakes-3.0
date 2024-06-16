{pkgs, configLib, background-image, ...}: {
    environment.systemPackages = [
        pkgs.base16-schemes
    ];
    stylix = {
        enable = true;
        base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
        image = background-image;
    };
    
}