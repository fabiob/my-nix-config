# Configuration related to the existing users and the home-manager configuration.

{ config, pkgs, ... }:
{
  imports = [ <home-manager/nixos> ];

  nix.settings.trusted-users = [
    "root"
    "marcel"
  ];

  users.users.marcel = {
    isNormalUser = true;
    description = "Marcel Nielsen";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
    packages = with pkgs; [
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGO49ie+2Uy4jBeO7VzRoQp58LeSyg5lvtKiQRPXBbre fabio@fabio-nixos"
    ];
  };

  home-manager.useGlobalPkgs = true;
  home-manager.users.marcel =
    { pkgs, ... }:
    let
      defaultMonoFont = {
        name = "AdwaitaMono Nerd Font Regular";
        package = pkgs.nerd-fonts.adwaita-mono;
        size = 11;
      };
      flameshot-gui = pkgs.writeShellScriptBin "flameshot-gui" "${pkgs.flameshot}/bin/flameshot gui";
    in
    {
      home.packages = [ defaultMonoFont.package ];

      # Changes the default font
      fonts.fontconfig.enable = true;
      dconf.settings = {
        "org/gnome/desktop/interface" = {
          monospace-font-name = "${defaultMonoFont.name} ${toString defaultMonoFont.size}";
        };
      };

      # Adds flameshot as the default PtrScr keybinding
      dconf.settings = {
        # Disables the default screenshot interface
        "org/gnome/shell/keybindings" = {
          show-screenshot-ui = [ ];
        };
        # Sets the new keybindings
        "org/gnome/settings-daemon/plugins/media-keys" = {
          custom-keybindings = [
            "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
          ];
        };
        # Defines the new shortcut
        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
          binding = "Print";
          command = "${flameshot-gui}/bin/flameshot-gui";
          name = "Flameshot";
        };
      };

      home.shell.enableShellIntegration = true;
      home.sessionPath = [
        "$HOME/.local/share/JetBrains/Toolbox/scripts"
      ];

      # Autostart some programs
      xdg.autostart = {
        enable = true;
        entries = [
          "${pkgs.jetbrains-toolbox}/share/applications/jetbrains-toolbox.desktop"
          "${pkgs._1password-gui}/share/applications/1password.desktop"
        ];
      };

      programs = {
        bash.enable = true;

        broot.enable = true;
        broot.enableBashIntegration = true;

        fzf.enable = true;
        fzf.enableBashIntegration = true;

        mcfly.enable = true;
        mcfly.fzf.enable = true;
        mcfly.enableBashIntegration = true;

        z-lua.enable = true;
        z-lua.enableBashIntegration = true;
        z-lua.options = [
          "enhanced"
          "echo"
        ];

        direnv = {
          enable = true;
          enableBashIntegration = true; # see note on other shells below
          nix-direnv.enable = true;
        };

        starship.enable = true;

        kitty.enable = true;
      };

      home.file."idea.properties".text =
        "idea.filewatcher.executable.path = ${pkgs.fsnotifier}/bin/fsnotifier";

      home.stateVersion = "25.05";
    };
}
