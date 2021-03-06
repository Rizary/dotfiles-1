{ pkgs, config, ... }:

let
  stripOverrides = pkgs.callPackage ../../../../lib/stripOverrides.nix {};
  colors = config.primary-user.home-manager.colorTheme;
in

{
  primary-user.home-manager.programs.waybar = {
    enable = true;
    layer = "top";
    position = "bottom";

    styles = {
      common = {
        border = "none";
        border-radius = "0";
        min-height = "35px";
        padding = "0 20px";
        margin = "4px 10px 0 10px";
      };
      frame = {
        border-top = "3px solid ${colors.selection}";
      };
      pre."@keyframes blink" = {
        to = {
          background-color = colors.white;
          color = colors.urgent;
        };
      };
    };

    modules = {
      left = map stripOverrides [
        (pkgs.callPackage ./modules/sway/workspaces.nix { inherit colors; })
        (pkgs.callPackage ./modules/sway/mode.nix { inherit colors; })
        (pkgs.callPackage ./modules/sway/window.nix {})
      ];

      right = map stripOverrides [
        (pkgs.callPackage ./modules/email/gmail.nix { inherit config colors; })
        (pkgs.callPackage ./modules/email/netflix.nix { inherit config colors; })
        (pkgs.callPackage ./modules/email/prussin-net.nix { inherit config colors; })
        (pkgs.callPackage ./modules/mount/secure.nix {})
        (pkgs.callPackage ./modules/mount/boot.nix {})
        (pkgs.callPackage ./modules/vpn.nix { inherit colors; })
        (pkgs.callPackage ./modules/bluetooth.nix { inherit config colors; })
        (pkgs.callPackage ./modules/wifi.nix { inherit colors; })
        (pkgs.callPackage ./modules/eth.nix { inherit colors; })
        (pkgs.callPackage ./modules/audio.nix { inherit colors; })
        (pkgs.callPackage ./modules/mic.nix { inherit colors; })
        (pkgs.callPackage ./modules/battery.nix { inherit colors; })
        (pkgs.callPackage ./modules/clock.nix {})
        (pkgs.callPackage ./modules/tray.nix {})
      ];
    };
  };
}
