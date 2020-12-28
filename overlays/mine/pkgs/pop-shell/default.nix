{ stdenv
, fetchFromGitHub
, glib
, nodePackages
}:

stdenv.mkDerivation rec {
  pname = "gnome-shell-extension-pop-shell";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "shell";
    rev = version;
    sha256 = "0nws28w40xpwhgdpcifzys1md4h6a7q5k3wcn2a77z5m26g69zw2";
  };

  makeFlags = [ "DESTDIR=$(out)" ];
  buildInputs = [ glib nodePackages.typescript ];

  postInstall = ''
    mv $out/usr/* $out
    rmdir $out/usr
  '';

  meta = with stdenv.lib; {
    description = "A tiling extension for the GNOME Shell";
    longDescription = ''
      A keyboard-driven layer for GNOME Shell which allows for quick and
      sensible navigation and management of windows. The core feature of Pop
      Shell is the addition of advanced tiling window management.
    '';
    license = licenses.gpl3;
    maintainers = with maintainers; [ synthetica ];
    homepage = src.homepage;
  };
}
