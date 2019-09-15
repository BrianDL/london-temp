# london-temp

## Getting LondonTemp:

```` 
git clone https://github.com/BrianDL/london-temp 
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

after 
````
$ LondonTemp
````
the service will be listening at http://localhost:8081.
