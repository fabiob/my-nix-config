{ config, pkgs, ... }:
{
  # Enable Logitech udev rules
  hardware.logitech.wireless.enable = true;

  services.solaar = {
    enable = true;
    window = "hide";
  };
}
