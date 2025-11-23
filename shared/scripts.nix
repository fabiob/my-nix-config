{ config, pkgs, ... }:

let
  nix-upgrade = pkgs.writeShellApplication {
    name = "nix-upgrade";
    runtimeInputs = [
      pkgs.nix-output-monitor
      pkgs.nixos-rebuild-ng
    ];
    text = ''
      set -eo pipefail
      cd /etc/nixos
      nix flake update
      ${pkgs.nixos-rebuild-ng}/bin/nixos-rebuild-ng switch --flake ".#$1" -v --log-format internal-json |& ${pkgs.nix-output-monitor}/bin/nom --json
    '';
  };
in
{
  environment.systemPackages = [
    nix-upgrade
  ];
}
