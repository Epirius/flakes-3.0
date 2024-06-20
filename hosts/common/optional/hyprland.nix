{ pkgs, inputs, ... }:
{
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages."${pkgs.system}".hyprland;
    portalPackage = pkgs.xdg-desktop-portal-hyprland;
    xwayland.enable = true;
  };


  environment = {
    sessionVariables = {
      # If your cursor becomes invisible
      WLR_NO_HARDWARE_CURSORS = "1";

      # Hint electron apps to use wayland
      # NIXOS_OZONE_WL = "1";
    };
    systemPackages = [
      pkgs.networkmanagerapplet
      pkgs.swww
    ];
    # systemPackages = [
    #   pkgs.waybar
    #   (pkgs.waybar.overrideAttrs (oldAttrs: {
    #     mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
    #   }))

    #   pkgs.dunst
    # ];
  };
}