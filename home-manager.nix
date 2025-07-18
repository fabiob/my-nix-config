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

        direnv = {
          enable = true;
          enableBashIntegration = true; # see note on other shells below
          nix-direnv.enable = true;
        };

        starship.enable = true;
        starship.settings = builtins.fromTOML ''
          format = """
          [](color_orange)\
          $os\
          $username\
          [](bg:color_yellow fg:color_orange)\
          $directory\
          [](fg:color_yellow bg:color_aqua)\
          $git_branch\
          $git_status\
          [](fg:color_aqua bg:color_blue)\
          $c\
          $cpp\
          $rust\
          $golang\
          $nodejs\
          $php\
          $java\
          $kotlin\
          $haskell\
          $python\
          [](fg:color_blue bg:color_bg3)\
          $docker_context\
          $conda\
          $pixi\
          [](fg:color_bg3 bg:color_bg1)\
          $time\
          [ ](fg:color_bg1)\
          $line_break$character """

          palette = 'gruvbox_dark'

          [palettes.gruvbox_dark]
          color_fg0 = '#fbf1c7'
          color_bg1 = '#3c3836'
          color_bg3 = '#665c54'
          color_kube = '#e6eff7'
          color_bgkube = '#326ce5'
          color_blue = '#458588'
          color_aqua = '#689d6a'
          color_green = '#98971a'
          color_orange = '#d65d0e'
          color_purple = '#b16286'
          color_red = '#cc241d'
          color_yellow = '#d79921'

          [os]
          disabled = false
          style = "bg:color_orange fg:color_fg0"

          [os.symbols]
          Windows = "󰍲"
          Ubuntu = "󰕈"
          SUSE = ""
          Raspbian = "󰐿"
          Mint = "󰣭"
          Macos = "󰀵"
          Manjaro = ""
          Linux = "󰌽"
          Gentoo = "󰣨"
          Fedora = "󰣛"
          Alpine = ""
          Amazon = ""
          Android = ""
          Arch = "󰣇"
          Artix = "󰣇"
          EndeavourOS = ""
          CentOS = ""
          Debian = "󰣚"
          Redhat = "󱄛"
          RedHatEnterprise = "󱄛"
          Pop = ""

          [username]
          show_always = true
          style_user = "bg:color_orange fg:color_fg0"
          style_root = "bg:color_orange fg:color_fg0"
          format = '[ $user ]($style)'

          [directory]
          style = "fg:color_fg0 bg:color_yellow"
          format = "[ $path ]($style)"
          truncation_length = 3
          truncation_symbol = "…/"

          [directory.substitutions]
          "Documents" = "󰈙 "
          "Downloads" = " "
          "Music" = "󰝚 "
          "Pictures" = " "
          "Developer" = "󰲋 "

          [git_branch]
          symbol = ""
          style = "bg:color_aqua"
          format = '[[ $symbol $branch ](fg:color_fg0 bg:color_aqua)]($style)'

          [git_status]
          style = "bg:color_aqua"
          format = '[[($all_status$ahead_behind )](fg:color_fg0 bg:color_aqua)]($style)'
          ahead = '⇡''${count}'
          diverged = '⇕⇡''${ahead_count}⇣''${behind_count}'
          behind = '⇣''${count}'
          conflicted = '🏳'
          up_to_date = '✓'
          untracked = '🤷'
          stashed = '📦'
          modified = '📝'
          #staged = '[++\($count\)](green)'
          staged = '+$count '
          renamed = '👅'
          deleted = '🗑'

          [nodejs]
          symbol = ""
          style = "bg:color_blue"
          format = '[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)'

          [c]
          symbol = " "
          style = "bg:color_blue"
          format = '[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)'

          [cpp]
          symbol = " "
          style = "bg:color_blue"
          format = '[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)'

          [rust]
          symbol = ""
          style = "bg:color_blue"
          format = '[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)'

          [golang]
          symbol = ""
          style = "bg:color_blue"
          format = '[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)'

          [php]
          symbol = ""
          style = "bg:color_blue"
          format = '[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)'

          [java]
          symbol = ""
          style = "bg:color_blue"
          format = '[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)'

          [kotlin]
          symbol = ""
          style = "bg:color_blue"
          format = '[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)'

          [haskell]
          symbol = ""
          style = "bg:color_blue"
          format = '[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)'

          [python]
          symbol = ""
          style = "bg:color_blue"
          format = '[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)'

          [docker_context]
          symbol = ""
          style = "bg:color_bg3"
          format = '[[ $symbol( $context) ](fg:#83a598 bg:color_bg3)]($style)'

          [conda]
          style = "bg:color_bg3"
          format = '[[ $symbol( $environment) ](fg:#83a598 bg:color_bg3)]($style)'

          [pixi]
          style = "bg:color_bg3"
          format = '[[ $symbol( $version)( $environment) ](fg:color_fg0 bg:color_bg3)]($style)'

          [time]
          disabled = false
          time_format = "%R"
          style = "bg:color_bg1"
          format = '[[   $time ](fg:color_fg0 bg:color_bg1)]($style)'

          [line_break]
          disabled = false

          [character]
          disabled = false
          success_symbol = '[](bold fg:color_green)'
          error_symbol = '[](bold fg:color_red)'
          vimcmd_symbol = '[](bold fg:color_green)'
          vimcmd_replace_one_symbol = '[](bold fg:color_purple)'
          vimcmd_replace_symbol = '[](bold fg:color_purple)'
          vimcmd_visual_symbol = '[](bold fg:color_yellow)'
        '';
      };
      home.stateVersion = "25.05";
    };
}
