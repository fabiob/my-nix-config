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
    let
      defaultMonoFont = {
        name = "AdwaitaMono Nerd Font Regular";
        package = pkgs.nerd-fonts.adwaita-mono;
        size = 11;
      };
    in
    {
      home.packages = [ defaultMonoFont.package ];

      fonts.fontconfig.enable = true;

      dconf.settings = {
        "org/gnome/desktop/interface" = {
          monospace-font-name = "${defaultMonoFont.name} ${toString defaultMonoFont.size}";
        };
      };

      home.shell.enableShellIntegration = true;
      home.sessionPath = [
        "$HOME/.local/share/JetBrains/Toolbox/scripts"
      ];

      programs = {
        bash.enable = true;

        broot.enable = true;
        broot.enableBashIntegration = true;

        z-lua.enable = true;
        z-lua.enableBashIntegration = true;
        z-lua.options = [ "enhanced" "echo" ];

        direnv = {
          enable = true;
          enableBashIntegration = true; # see note on other shells below
          nix-direnv.enable = true;
        };

        starship.enable = true;
      };
      home.stateVersion = "25.05";
    };
}
