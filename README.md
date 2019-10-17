### This repository has moved to https://gitlab.com/BridLeiva/london-temp

# london-temp

## Getting LondonTemp

```` 
$ git clone https://github.com/BrianDL/london-temp
...

$ cd london-temp
````

## Installing (with nix)

````
nix-env -i LondonTemp -f release.nix
````

or simply compiling it:

````
nix-build release.nix
````

## Running it

To start the web server just call
````
$ LondonTemp
````
the service will be listening at http://localhost:8081.

## Deploying with NixOps

Testing NixOps deployment in a local virtual machine:
````
$ nixops create ./nixops/ltemp-logical.nix ./nixops/ltemp-vbox.nix -d ltemp
...

$ nixops deploy -d ltemp
````

and the service will be listening at http://[IP of the VM]:8081
