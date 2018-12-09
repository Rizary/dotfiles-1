{ stdenv
, htop
, chromium
, rofi
, file
, slack
, pavucontrol
, feh
, keepassxc
, xdotool
, oathToolkit
, imagemagick
, qemu
, gimp
, steam
, zathura
}:

stdenv.mkDerivation {
  name = "user-bin";

  propagatedUserEnvPkgs = [
    htop
    chromium
    rofi
    file
    slack
    pavucontrol
    feh
    keepassxc
    xdotool
    oathToolkit
    imagemagick
    qemu
    gimp
    steam
    zathura
  ];

  phases = [ "installPhase" "fixupPhase" ];

  installPhase = ''
    mkdir -p $out/{bin,share/apps}
    install -m755 -D ${./bin}/* $out/bin
    install -m755 -D ${./apps}/* $out/share/apps
  '';

}
