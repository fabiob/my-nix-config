{
  description = "flake for fabio-nixos";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager }@inputs:
  let
    inherit (self) outputs;
  in
  {
    nixosConfigurations = {
      fabio-nixos = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs outputs; };
        modules = [ ./fabio-nixos/configuration.nix ];
      };
    };
  };
}
