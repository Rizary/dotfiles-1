{ pkgs, lib, config, ... }:

let
  cfg = config.autologin-graphical-session;
in

{
  options.autologin-graphical-session = {
    enable = lib.mkEnableOption "Autologin graphical session";

    user = lib.mkOption {
      type = lib.types.str;
    };

    sessionScript = lib.mkOption {
      type = lib.types.path;
    };
  };

  config = lib.mkIf cfg.enable {
    systemd = {
      defaultUnit = "graphical.target";

      services.autologin-graphical-session = {
        enable = true;
        description = "Autologin graphical session";
        wantedBy = [ "graphical.target" ];
        aliases = [ "display-manager.service" ];
        after = [
          "systemd-user-sessions.service"
          "getty@tty7.service"
          "plymouth-quit-wait.service"
        ];
        conflicts = [
          "getty@tty7.service"
          "plymouth-quit.service"
        ];

        environment.XDG_RUNTIME_DIR = "/run/user/${toString config.users.users.${cfg.user}.uid}";

        serviceConfig = {
          WorkingDirectory = config.users.users.${cfg.user}.home;
          ExecStartPre = "${pkgs.kbd}/bin/chvt 7";
          ExecStart = pkgs.writeShellScript "start-autologin-graphical-session" ''
            . /etc/set-environment
            ${cfg.sessionScript}
          '';

          PAMName = "login";
          User = cfg.user;

          UtmpIdentifier = "tty7";
          TTYPath = "/dev/tty7";
          TTYReset = "yes";
          TTYHangup = "yes";
          TTYVTDisallocate = "yes";

          SyslogIdentifier = "autologin-graphical-session";
          StandardInput = "tty";
          StandardError = "journal";
          StandardOutput = "journal";

          Restart = "always";
          RestartSec = "2";
          Nice = "-5";
        };
      };
    };
  };
}
