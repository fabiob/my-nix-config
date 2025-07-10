# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).


{ config, pkgs, ... }:

{
  imports = [ <home-manager/nixos> ];


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.fabio = {
    isNormalUser = true;
    description = "Fábio Batista";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  home-manager.useGlobalPkgs = true;
  home-manager.users.fabio = { pkgs, ... }: {
    programs.bash.enable = true;
    home.stateVersion = "25.05";
  };
}
