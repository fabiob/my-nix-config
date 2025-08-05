# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  # Install Firefox and Chromium
  programs.firefox.enable = true;
  programs.chromium.enable = true;

  # Enables the Gnome Keyring
  programs.seahorse.enable = true;

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
    libreoffice-fresh # Comprehensive, professional-quality productivity suite, a variant of openoffice.org
    hunspell # Spell checker
    hunspellDicts.pt_BR # Hunspell dictionary for Portuguese (Brazil) from LibreOffice
    hunspellDicts.en_US # Hunspell dictionary for English (United States) from Wordlist

    # DevOps CLI
    awscli2 # Unified tool to manage your AWS services
    (azure-cli.withExtensions [ azure-cli.extensions.aks-preview ]) # Next generation multi-platform command line experience for Azure
    cloudlens # K9s like CLI for AWS and GCP
    eks-node-viewer # Tool to visualize dynamic node usage within a cluster
    helmfile # Declarative spec for deploying Helm charts
    k9s # Kubernetes CLI To Manage Your Clusters In Style
    kubectl # Kubernetes CLI
    kubernetes-helm # Package manager for kubernetes
    opentofu # Tool for building, changing, and versioning infrastructure

    # Development CLI
    bat # Cat(1) clone with syntax highlighting and Git integration
    devenv # Fast, Declarative, Reproducible, and Composable Developer Environments
    difftastic # Syntax-aware diff
    docker-buildx # Docker CLI plugin for extended build capabilities with BuildKit
    git # Distributed version control system
    gnumake # Tool to control the generation of non-source files from sources
    jq # Lightweight and flexible command-line JSON processor
    nixfmt-rfc-style # Official formatter for Nix code
    sops # Simple and flexible tool for managing secrets
    uv # Extremely fast Python package installer and resolver, written in Rust
    vim # Most popular clone of the VI editor
    yq-go # Portable command-line YAML processor

    # Other CLI
    age # Modern encryption tool with small explicit keys
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

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
}
