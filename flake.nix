{
  description = "flake for fabio-nixos";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    solaar.url = "github:Svenum/Solaar-Flake/main";
    solaar.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      solaar,
    }@inputs:
    let
      inherit (self) outputs;
    in
    {
      nixosConfigurations = {
        fabio-nixos = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [
            solaar.nixosModules.default
            ./fabio-nixos/configuration.nix
          ];
        };
        tania-nixos = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [
            solaar.nixosModules.default
            ./tania-nixos/configuration.nix
          ];
        };
        lg-gram-i7 = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [
            solaar.nixosModules.default
            ./lg-gram-i7/configuration.nix
          ];
        };
      };
    };
}
