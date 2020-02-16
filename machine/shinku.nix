# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
{
  imports =
    [ # Include custom generic configurations.
      ../common.nix
      ../role/desktop.nix
      ../user/jpas.nix
      ../user/kbell.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub = {
    enable = true;
    version = 2;
    device = "/dev/sda";
    extraEntries = ''
      menuentry "Windows 7" {
        chainloader (hd0,msdos1)+1
      }
      menuentry "Windows Recovery Environment" {
        chainloader (hd0,msdos3)+1
      }
    '';
  };

  networking.hostName = "shinku.jpas.xyz"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  networking.interfaces.enp2s0.useDHCP = true;
  # networking.interfaces.wlp4s0.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
    
  # Enable the KDE Desktop Environment.
  services.xserver = {
    desktopManager.plasma5.enable = true;
  };
}
