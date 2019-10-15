{ pkgs, config, ... }:

{
  nixpkgs.overlays = [
    (self: super: {
      launcher = super.callPackage ./launcher.nix {
        inherit config;
        emacs = config.programs.emacs.finalPackage;
      };
    })
  ];
}
