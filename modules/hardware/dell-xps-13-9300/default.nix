{ lib, pkgs, ... }: {
  imports = [
    <nixos-hardware/dell/xps/13-9300> # TODO: upstream...
    ./dell-smm-hwmon.nix
    ./thermald
  ];

  environment.systemPackages = [
    pkgs.libsmbios # For Dell BIOS/UEFI
  ];

  # Enable touchpad support
  services.xserver.libinput.enable = lib.mkDefault true;

  # Disbale i2c_hid touchpad, since it makes tons of IRQ/s...
  boot.blacklistedKernelModules = [ "i2c_hid" ];

  # Enable firmware update daemon.
  services.fwupd.enable = lib.mkDefault true;

  # Use only Intel driver for X11
  services.xserver.videoDrivers = lib.mkDefault [ "intel" ];

  # System specific tweaks...
  # https://wiki.archlinux.org/index.php/Dell_XPS_13_(9300)

  # Thermal management for laptops.
  services.tlp.enable = lib.mkDefault true;

  # WiFi drivers do not work on Linux < 5.7, this should be at least that.
  boot.kernelPackages = lib.mkDefault (pkgs.linuxPackagesFor pkgs.linux_latest);

  hardware.pulseaudio = {
    daemon.config = {
      avoid-resampling = lib.mkDefault true;
      #default-sample-format = lib.mkDefault "s16le";
      #default-sample-rate = lib.mkDefault "48000";
    };
  };
}
