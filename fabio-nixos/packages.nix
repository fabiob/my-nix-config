# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  # Install Chromium
  programs.chromium.enable = true;

  # Enables the Gnome Keyring
  programs.seahorse.enable = true;

  # Enables the GPaste clipboard manager
  programs.gpaste.enable = true;

  # Sets vim as the default editor for all users
  environment.sessionVariables.EDITOR = "vim";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Generic GUI tools
    flameshot # Powerful yet simple to use screenshot software
    google-chrome # Freeware web browser developed by Google
    jetbrains-toolbox # Jetbrains Toolbox
    megasync # Easy automated syncing between your computers and your MEGA Cloud Drive
    solaar # Linux devices manager for the Logitech Unifying Receiver
    morewaita-icon-theme # Adwaita style extra icons theme for Gnome Shell
    vesktop # Alternate client for Discord with Vencord built-in
    slack # Desktop client for Slack
    typora # Markdown editor, a markdown reader
    radiotray-ng # Internet radio player for linux
    gimp3-with-plugins # GNU Image Manipulation Program
    mission-center # Monitor your CPU, Memory, Disk, Network and GPU usage

    # LibreOffice and OnlyOffice
    onlyoffice-desktopeditors
    libreoffice-fresh # Comprehensive, professional-quality productivity suite, a variant of openoffice.org
    hunspell # Spell checker
    hunspellDicts.pt_BR # Hunspell dictionary for Portuguese (Brazil) from LibreOffice
    hunspellDicts.en_US # Hunspell dictionary for English (United States) from Wordlist
    hyphen # Text hyphenation library
    hyphenDicts.en_US

    # Development CLI
    bat # Cat(1) clone with syntax highlighting and Git integration
    devenv # Fast, Declarative, Reproducible, and Composable Developer Environments
    difftastic # Syntax-aware diff
    docker-buildx # Docker CLI plugin for extended build capabilities with BuildKit
    git # Distributed version control system
    gnumake # Tool to control the generation of non-source files from sources
    jq # Lightweight and flexible command-line JSON processor
    nixfmt-rfc-style # Official formatter for Nix code
    vim # Most popular clone of the VI editor
    yq-go # Portable command-line YAML processor

    # Other CLI
    age # Modern encryption tool with small explicit keys
    duf # Disk Usage/Free Utility
    dust # du + rust = dust. Like du but more intuitive
    ripgrep # Utility that combines the usability of The Silver Searcher with the raw speed of grep
    eza # Modern, maintained replacement for ls
    psmisc # Set of small useful utilities that use the proc filesystem (such as fuser, killall and pstree)
    gnupg # Modern release of the GNU Privacy Guard, a GPL OpenPGP implementation
    comma # Runs programs without installing them
    broot # Interactive tree view, a fuzzy search, a balanced BFS descent and customizable commands
  ];

  # 1Password
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "fabio" ];
  };

  programs.gnupg.agent.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  #services.nix-serve = {
  #  enable = true;
  #  openFirewall = true;
  #  secretKeyFile = "/misc/nix-serve/cache-priv-key.pem";
  #};

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
}
