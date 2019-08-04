{ pkgs, config, ... }:

{
  home.file.".xmonad/lib" = {
    source = ./lib;
    recursive = true;
    onChange = config.home.file.".xmonad/xmonad.hs".onChange;
  };

  xsession = {
    enable = true;

    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      config = pkgs.writeText "xmonad.hs" ''
        import qualified Paths as Paths
        import qualified WindowManager as WindowManager

        main :: IO ()
        main = WindowManager.start Paths.Paths
          { Paths.xmobar = "${pkgs.haskellPackages.xmobar}/bin/xmobar"
          , Paths.xsetroot = "${pkgs.xorg.xsetroot}/bin/xsetroot"
          , Paths.launch = "${pkgs.launcher}/bin/launch"
          , Paths.xclip = "${pkgs.xclip}/bin/xclip"
          , Paths.lockScreen = "${pkgs.lock-screen}/bin/lock-screen"
          , Paths.backlight = "${pkgs.backlight}/bin/backlight"
          , Paths.volume = "${pkgs.volume}/bin/volume"
          , Paths.rofiPass = "${pkgs.rofi-pass}/bin/rofi-pass"
          , Paths.terminal = "${config.terminal}"
          }
      '';
    };
  };
}
