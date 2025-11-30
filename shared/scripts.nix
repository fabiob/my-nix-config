{ config, pkgs, ... }:

let
  do-nixos-upgrade = pkgs.writeShellApplication {
    name = "do-nixos-upgrade";
    runtimeInputs = [
      pkgs.nix-output-monitor
      pkgs.nixos-rebuild-ng
    ];
    text = ''
      set -exo pipefail
      cd /etc/nixos
      nix flake update
      ${pkgs.nixos-rebuild-ng}/bin/nixos-rebuild-ng switch --flake ".#$(hostname)" -v --log-format internal-json |& ${pkgs.nix-output-monitor}/bin/nom --json
    '';
  };
in
{
  environment.systemPackages = [
    do-nixos-upgrade
  ];
}
