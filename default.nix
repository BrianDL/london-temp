{ mkDerivation, aeson, base, bytestring, http-conduit, lens
, lens-aeson, servant-server, stdenv, warp
}:
mkDerivation {
  pname = "LondonTemp";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [
    aeson base bytestring http-conduit lens lens-aeson servant-server
    warp
  ];
  homepage = "https://github.com/BrianDL/london-temp";
  description = "Shows London's current temperature";
  license = stdenv.lib.licenses.gpl2;
}
