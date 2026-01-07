{ config, pkgs, ... }:

{
  # Install Chromium
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
  ];

  # 1Password
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "tania" ];
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
}
