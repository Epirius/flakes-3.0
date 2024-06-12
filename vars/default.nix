{ inputs, lib }: {
    username = "fk";
    networking = import ./networking.nix {inherit lib; };
    isMiniamal = false;
}