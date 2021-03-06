{ config, options, pkgs, ... }: {
  imports = [ ../hardware-configuration.nix ../modules/nixos ];

  # Essential packages.
  environment.systemPackages = with pkgs; [
    curl
    kitty.terminfo
    manpages
    neovim
    tmux
    wget
    sshfs
  ];

  # Boot faster!
  boot.loader.timeout = 1;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.supportedFilesystems = [ "ntfs" "sshfs" ];

  # XXX: 2020-01-20 turning on causes failed boots.
  boot.tmpOnTmpfs = false;

  # Set your time zone.
  time.timeZone = "America/Regina";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";

  console = {
    useXkbConfig = true;
    colors = config.hole.colors.gruvbox.dark-no-hash.console;
  };

  services.xserver = {
    # Does not enable xserver, but make sure the keymap is in sync
    layout = "us";
  };

  networking.networkmanager.wifi.backend = "iwd";

  services.upower.enable = config.powerManagement.enable;

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    passwordAuthentication = false;
  };

  services.tailscale.enable = true;

  users = {
    # Disble mutation of users.
    mutableUsers = false;

    # Read root's hashed password from file to prevent lockout
    users.root.hashedPassword = (import ../secrets/passwords.nix).root;
  };

  # We like to live really dangerously!
  system.autoUpgrade.enable = false;

  nixpkgs = {
    config = { allowUnfree = true; };
    overlays = [ (import ../overlays/mine) ];
  };

  nix = {
    optimise.automatic = true;
    gc.automatic = true;
    gc.options = "--delete-older-than 7d";

    nixPath = options.nix.nixPath.default
      ++ [ "nixpkgs-overlays=/etc/nixos/overlays/compat" ];
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "unstable"; # Did you read the comment?
}
