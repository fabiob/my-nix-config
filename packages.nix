# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  # Install firefox.
  programs.firefox.enable = true;

  # Sets vim as the default editor for all users
  environment.sessionVariables.EDITOR = "vim";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Generic user tools
    google-chrome
    jetbrains-toolbox
    megasync
    solaar
    morewaita-icon-theme
    vesktop

    # DevOps CLI
    awscli2
    (azure-cli.withExtensions [ azure-cli.extensions.aks-preview ])
    eks-node-viewer
    helmfile
    k9s
    kubectl
    kubernetes-helm
    opentofu

    # Development CLI
    devenv
    direnv
    docker-buildx
    fnm # Fast Node Manager
    git
    gnumake
    rbenv
    sops
    uv
    vim
    yq-go

    # Other CLI
    age
    dust
    ripgrep
    eza
    psmisc
    gnupg
    nss_latest
  ];

  # Docker
  virtualisation.docker = {
    enable = false;

    rootless = {
      enable = true;
      setSocketVariable = true;
      daemon.settings = {
        dns = [ "1.1.1.1" "8.8.8.8" ];
        registry-mirrors = [ "https://mirror.gcr.io" ];
      };
    };
  };

  # 1Password
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "fabio" ];
  };

  programs.direnv.enable = true;

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
