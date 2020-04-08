{ config, ... }: {
  imports = [ ../hardware-configuration.nix ./base-packages.nix ];

  # Boot faster!
  boot.loader.timeout = 1;

  # Set your time zone.
  time.timeZone = "America/Regina";

  # Select internationalisation properties.
  i18n = { defaultLocale = "en_CA.UTF-8"; };

  console = {
    useXkbConfig = true;

    font = "Lat2-Terminus16";
    colors = [
      # gruvbox dark
      "282828"
      "cc241d"
      "98971a"
      "d79921"
      "458588"
      "b16286"
      "689d6a"
      "a89984"
      "928374"
      "fb4934"
      "b8bb26"
      "fabd2f"
      "83a598"
      "d3869b"
      "8ec07c"
      "ebdbb2"
    ];
  };

  services.xserver = {
    # Does not enable xserver, but make sure the keymap is in sync
    layout = "us";
    xkbOptions = "caps:swapescape";
  };

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Disble mutation of users.
  users.mutableUsers = false;

  # Prevent lockout...
  users.users.root.hashedPassword =
    "$6$nSxJ1J4lJ5w$PoC7DaVweDBiorbQfiWmnOkWAnRsHL2sYgP5LN2sAZr2EETZZAKWnYtEJ/9VRtLHGaISxEgz7qglme205lQ0y/";

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "unstable"; # Did you read the comment?

  # We like to live really dangerously!
  system.autoUpgrade.enable = true;

  nix = {
    optimise.automatic = true;
    gc.automatic = true;
    gc.options = "--delete-older-than 7d";
  };
}