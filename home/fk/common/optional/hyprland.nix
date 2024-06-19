{pkgs, lib, background-image, ...}:
let 
  inherit (pkgs) polkit_gnome callPackage;
  super = "SUPER";
  mainMod = "SUPER";
  laptopMonitor = "desc:Sharp Corporation 0x1547";
in
{
  home.packages = with pkgs; [
    hyprpaper
  ];

  services = {
    hyprpaper = {
      enable = true;
      settings = {
        preload = [ "${background-image}" ];
        wallpaper = [ ",${background-image}" ];
        splash = false;
      };
    };

    dunst.enable = true;

    hypridle = {
      enable = true;
      settings = {
        general = {
          after_sleep_cmd = "hyprctl dispatch dpms on";
          ignore_dbus_inhibit = false;
          lock_cmd = "hyprlock";
        };

        listener = [
          {
            timeout = 300;
            on-timeout = "hyprlock";
          }
          {
            timeout = 310;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on";
          }
        ];
      };
    };
  };

  programs = {
    hyprlock = {
      enable = true;
      settings = {
        general = {
          disable_loading_bar = true;
          grace = 2;
          hide_cursor = true;
          no_fade_in = false;
        };

        background = [
          {
            path = "screenshot";
            blur_passes = 3;
            blur_size = 8;
          }
        ];

        input-field = [
          {
            size = "200, 50";
            position = "0, -80";
            monitor = "";
            dots_center = true;
            fade_on_empty = false;
            font_color = "rgb(202, 211, 245)";
            inner_color = "rgb(91, 96, 120)";
            outer_color = "rgb(24, 25, 38)";
            outline_thickness = 5;
            placeholder_text = "Password...";
            shadow_passes = 2;
          }
        ];
      };
    };
  };

  


  wayland.windowManager.hyprland = {
    enable = true;
    systemd = {
      enable = true;
      variables = ["--all"];
    };

    settings = {
      monitor = [
        # Main xps
        "${laptopMonitor},1920x1200@60,0x0,1"
        # Home BENQ
        "desc:BNQ BenQ XL2420T 85C00146SL0,3840x2160,0x-1080,1"
        # LG Home
        "desc:LG Electronics 27GL850 005NTSUF1078,preferred,0x-1440,1.5"
        # Wildcard
        ",preferred,auto,1,mirror, ${laptopMonitor}"
      ];

      input = {
        kb_layout = "us,no";
        kb_options = "caps:escape";
        follow_mouse = 1;
        accel_profile = "flat";
        sensitivity = 0;

        touchpad = {
          natural_scroll = true;
          scroll_factor = 0.5;
        };
      };

      device = [
        {
          name = "glorious-model-o";
          sensitivity = 0.4;
          accel_profile = "flat";
        }
      ];

      general = {
        gaps_in = 5;
        gaps_out = 20;
        border_size = 2;
        no_border_on_floating = true;
        layout = "dwindle";
      };

      decoration = {
        rounding = 10;
        drop_shadow = true;
        shadow_range = 4;
        shadow_render_power = 3;
        
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
        };
      };

      animations = {
        enabled = true;

        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
        "windows, 1, 7, myBezier"
        "windowsOut, 1, 7, default, popin 80%"
        "border, 1, 10, default"
        "borderangle, 1, 8, default"
        "fade, 1, 7, default"
        "workspaces, 1, 6, default"
        ];

      };

      exec-once = [
        "nm-applet --indicator & disown"
      ];
      

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master = {
        new_is_master = true;
      };

      gestures = {
        workspace_swipe = true;
        workspace_swipe_fingers = 3;
      };

      misc = {
        disable_hyprland_logo = true;
      };


      ######## WINDOW RULES #########
      windowrule = [
        "float, file_progress"
        "float, confirm"
        "float, dialog"
        "float, download"
        "float, notification"
        "float, error"
        "float, splash"
        "float, confirmreset"
        "float, title:Open File"
        "float, title:branchdialog"
        "float, Lxappearance"
        "float, Rofi"
        "animation none,Rofi"
        "float,viewnior"
        "float,feh"
        "float, pavucontrol-qt"
        "float, pavucontrol"
        "float, file-roller"
        "fullscreen, wlogout"
        "float, title:wlogout"
        "fullscreen, title:wlogout"
        "idleinhibit focus, mpv"
        "float, title:^(Media viewer)$"
        "float, title:^(Volume Control)$"
        "float, title:^(Picture-in-Picture)$"
        "size 800 600, title:^(Volume Control)$"
        "move 75 44%, title:^(Volume Control)$"
        "float, kcalc"
        "size 400 400, kcalc"
      ];

      windowrulev2 = [
        "opacity 0.0 override 0.0 override,class:^(xwaylandvideobridge)$"
        "noanim,class:^(xwaylandvideobridge)$"
        "noinitialfocus,class:^(xwaylandvideobridge)$"
        "maxsize 1 1,class:^(xwaylandvideobridge)$"
        "noblur,class:^(xwaylandvideobridge)$"
      ];


      ######## BINDS #########
      bind = [

        # Norwegian letters
        "${super}, Semicolon, exec, wtype -P oslash"
        "${super}, Apostrophe, exec, wtype -P ae"
        "${super}, Bracketleft, exec, wtype -P aring"

        "${super}+shift, Semicolon, exec, wtype Ø"
        "${super}+shift, Apostrophe, exec, wtype Æ"
        "${super}+shift, Bracketleft, exec, wtype Å"


        "${mainMod}, Backslash, exec, kitty"
        "${mainMod}, B, exec, firefox"
        # "${mainMod}, N, exec, ~/.dotfiles/scripts/random-bg.sh"
        "${mainMod} SHIFT, B, exec, google-chrome-stable"
        "${mainMod}, X, killactive, "
        "${mainMod} SHIFT, Q, exit, "
        "${mainMod}, E, exec, dolphin"
        "${mainMod}, V, togglefloating, "
        "${mainMod}, Return, exec, wofi --show drun"
        "${mainMod}, bracketright, exec, wofi-calc"
        "${mainMod}, P, pseudo," # dwindle
        "${mainMod}, J, togglesplit," # dwindle
        "${mainMod} SHIFT, L, exec, hyprctl switchxkblayout at-translated-set-2-keyboard next"
        "${mainMod}, PERIOD, exec, hyprlock"

        # Multimedia
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPrev, exec, playerctl previous"

        # Screenshot
        ", Print, exec, hyprshot -m region --clipboard-only"

        # Backlight
        ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
        ", XF86MonBrightnessUp, exec, brightnessctl set +5%"

        # Move focus with mainMod + arrow keys
        "${mainMod}, left, movefocus, l"
        "${mainMod}, right, movefocus, r"
        "${mainMod}, up, movefocus, u"
        "${mainMod}, down, movefocus, d"

        # Switch workspaces with mainMod + [0-9]
        "${mainMod}, 1, workspace, 1"
        "${mainMod}, 2, workspace, 2"
        "${mainMod}, 3, workspace, 3"
        "${mainMod}, 4, workspace, 4"
        "${mainMod}, 5, workspace, 5"
        "${mainMod}, 6, workspace, 6"
        "${mainMod}, 7, workspace, 7"
        "${mainMod}, 8, workspace, 8"
        "${mainMod}, 9, workspace, 9"
        "${mainMod}, 0, workspace, 10"

        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        "${mainMod} SHIFT, 1, movetoworkspace, 1"
        "${mainMod} SHIFT, 2, movetoworkspace, 2"
        "${mainMod} SHIFT, 3, movetoworkspace, 3"
        "${mainMod} SHIFT, 4, movetoworkspace, 4"
        "${mainMod} SHIFT, 5, movetoworkspace, 5"
        "${mainMod} SHIFT, 6, movetoworkspace, 6"
        "${mainMod} SHIFT, 7, movetoworkspace, 7"
        "${mainMod} SHIFT, 8, movetoworkspace, 8"
        "${mainMod} SHIFT, 9, movetoworkspace, 9"
        "${mainMod} SHIFT, 0, movetoworkspace, 10"

        # Scroll through existing workspaces with mainMod + scroll
        "${mainMod}, mouse_down, workspace, e+1"
        "${mainMod}, mouse_up, workspace, e-1"

        # Resize windows
        "${super} CTRL, left, resizeactive, -20 0"
        "${super} CTRL, right, resizeactive, 20 0"
        "${super} CTRL, up, resizeactive, 0 -20"
        "${super} CTRL, down, resizeactive, 0 20"

        # Move windows
        "${super} SHIFT, left, movewindow, l"
        "${super} SHIFT, right, movewindow, r"
        "${super} SHIFT, up, movewindow, u"
        "${super} SHIFT, down, movewindow, d"
      ];

      bindr = [
        # Toggle waybar
        "${super}, Q, exec, pkill waybar || waybar"
      ];

      bindl = [
        # Multimedia
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_SINK@ toggle"
        ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_SOURCE@ toggle"

        # Laptop lid close
        # "switch:Lid Switch,exec,hypridle"
        # "switch:on:Lid Switch,exec,hyprctl keyword monitor \"${laptopMonitor}, disable\""
        # "switch:off:Lid Switch,exec,hyprctl keyword monitor \"${laptopMonitor}, 1920x1200@60,0x0,1\""
      ];


      binde = [
        # Multimedia
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_SINK@ 5%-"
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_SINK@ 5%+"
      ];

      bindm = [
        # Move/resize windows with mainMod + LMB/RMB and dragging
        "${mainMod}, mouse:272, movewindow"
        "${mainMod}, mouse:273, resizewindow"
      ];
    };
  };
}