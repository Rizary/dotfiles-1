{ ... }:

{
  imports = [
    ./hardware.nix
    ../../profiles/laptop
  ];

  primaryUserName = "cprussin";
  networking.hostName = "lyra";
  services.mingetty.greetingLine = builtins.readFile ./greeting;
}
