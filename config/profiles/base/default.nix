{ ... }:

{
  imports = [
    <home-manager/nixos>
    ../../../modules

    ../../modules/data/session-vars

    ../../modules/devices/tmp

    ../../modules/nix/nixpkgs

    ../../modules/security/process-information-hiding
    ../../modules/security/secure
    ../../modules/security/sshd
    ../../modules/security/sudo
    ../../modules/security/umask

    ../../modules/ui/bash
    ../../modules/ui/dvp
    ../../modules/ui/fzf
    ../../modules/ui/greeting
    ../../modules/ui/readline
    ../../modules/ui/termite
    ../../modules/ui/terminfo
    ../../modules/ui/zsh
  ];
}
