{ pkgs, lib, config, ... }:

{
  home-manager.users.${config.primaryUserName} = homeManager: {
    home.packages = lib.mkForce [

      # FIXME: This is done under the hood in home-manager to set
      # sessionVariables.  We do still want this in the environment, even if we
      # want to clear out the other automatically added stuff.  Ideally there
      # should be a simpler way to clear the environment except this file.
      (pkgs.writeTextFile {
        name = "hm-session-vars.sh";
        destination = "/etc/profile.d/hm-session-vars.sh";
        text = ''
          # Only source this once.
          if [ -n "$__HM_SESS_VARS_SOURCED" ]; then return; fi
          export __HM_SESS_VARS_SOURCED=1
          ${homeManager.config.lib.shell.exportAll homeManager.config.home.sessionVariables}
        '';
      })

    ];
  };
}