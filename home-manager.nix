# Configuration related to the existing users and the home-manager configuration.

{ config, pkgs, ... }:
{
  imports = [ <home-manager/nixos> ];

  nix.settings.trusted-users = [ "root" "fabio" ];

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
      home.shell.enableShellIntegration = true;
      home.sessionPath = [
        "$HOME/.local/share/JetBrains/Toolbox/scripts"
      ];
      home.stateVersion = "25.05";
    };
}
