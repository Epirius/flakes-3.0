{ pkgs, inputs, ... }: {
  programs.firefox = {
    enable = true;
    profiles.fk = {
      extensions = with inputs.firefox-addons.packages."${pkgs.system}"; [
        # use ```nix flake show "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons"``` to search for extensions
        facebook-container
        proton-pass
        pushbullet
        reddit-comment-collapser
        reddit-enhancement-suite
        sponsorblock
        ublock-origin
        videospeed
      ];

      bookmarks = [
        {
          name = "YT";
          tags = [ "videos" ];
          keyword = "videos";
          url = "https://www.youtube.com/";
        }
      ];


      search.engines = {
        "Nix Packages" = {
          urls = [{

            template = "https://search.nixos.org/packages";
            params = [
              { name = "type"; value = "packages"; }
              { name = "query"; value = "{searchTerms}"; }
            ];
          }];
          definedAliases = ["n"];
        };

        "Home manager" = {
          urls = [{

            template = "https://home-manager-options.extranix.com/?query={searchTerms}&release=master";
            params = [
              { name = "query"; value = "{searchTerms}"; }
            ];
          }];
          definedAliases = ["h"];
        };

        "Twitch" = {
          urls = [{
            template = "https://www.twitch.tv/{searchTerms}";
          }];
          definedAliases = ["t"];
        };

        "Reddit" = {
          urls = [{
            template = "https://www.reddit.com/r/{searchTerms}";
          }];
          definedAliases = ["r"];
        };

        "Youtube" = {
          urls = [{
            template = "https://www.youtube.com/results?search_query={searchTerms}";
          }];
          definedAliases = ["y"];
        };
      };

      search.force = true;

    };
  };
}