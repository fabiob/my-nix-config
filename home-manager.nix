# Configuration related to the existing users and the home-manager configuration.

{ config, pkgs, ... }:
{
  imports = [ <home-manager/nixos> ];

  users.users.fabio = {
    isNormalUser = true;
    description = "Fábio Batista";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
    packages = with pkgs; [
    ];
  };

  home-manager.useGlobalPkgs = true;
  home-manager.users.fabio =
    { pkgs, ... }:
    {
      programs.bash.enable = true;
      home.stateVersion = "25.05";
    };
}
