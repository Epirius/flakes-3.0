{ pkgs, inputs, ... }: {
    programs.chromium = {
        enable = true;
        extensions = [
            { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # ublock origin
        ];
    };
}