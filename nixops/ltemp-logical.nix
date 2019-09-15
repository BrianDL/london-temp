{
  network.description = "LT Web Server";

  webserver =
    { config, pkgs, ... }: let
      LondonTemp = pkgs.haskellPackages.callPackage ../default.nix { };
    in
    { networking.hostName = "ltWebServer";

      networking.firewall.allowedTCPPorts = [ 22 8081 ];
      environment.systemPackages = [ LondonTemp ];

      systemd.services.LondonTemp =
        { description = "LondonTemp Webserver";
          wantedBy = [ "multi-user.target" ];
          after = [ "network.target" ];
          serviceConfig =
            { ExecStart = "${LondonTemp}/bin/LondonTemp";
            };
        };
    };
}