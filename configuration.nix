# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };
  
  # lightdm
  services.displayManager.defaultSession = "none+i3";
  services.xserver = {
    enable = true;
    displayManager.lightdm.enable = true;
    windowManager.i3.enable = true;
    windowManager.i3.configFile = ./i3/i3status.conf;
  }; 

  # Enabling pipewire 
  # rkit options but recommended
  #hardware.pulseaudio.enable = false; 
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # if you want use jack apps uncomment this
    # jack.enable = true;
  };
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  # Enabling flatpak
  # xdg portal needs to be enabled to use flatpak 
  /*services.flatpak.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  xdg.portal.config = { common = { default = [ "gtk" ]; }; };
  xdg.portal.enable = true;
  */
  
  # Steam
  programs.steam.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dealuhguurl = {
    isNormalUser = true;
    description = "dealuhguurl";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    alsa-utils 
    i3
    i3status
    i3lock
    dmenu
    gcc 
    neovim
    brave
    git
    neofetch
    lua-language-server
    unzip
    clang-tools
    feh
    nodejs_22
    curl
    kitty
    keepassxc
    steam
    python3
    flameshot
    texlivePackages.fontawesome5
    nerdfonts
    linuxKernel.packages.linux_zen.nvidia_x11
    mpv
    discord
    xfce.thunar
    pipewire
    wireplumber
    blueman
    bluez-alsa
    pasystray
    networkmanagerapplet
    flatpak
    fuse
    xdg-desktop-portal-gtk
    lightdm-gtk-greeter
    lxappearance
    pciutils
    lshw
  ];

  # Enable & Load NVIDIA DRIVERS
  hardware.opengl.enable = true; 
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    # ModeSetting is required 
    modesetting.enable = true;

    # Nvidia PowerManagement: Enable if experiencing crashes or graphic errors after sleep
    powerManagement.enable = true;

    # FineGrained power management: turns off GPU when not in use 
    powerManagement.finegrained = false;

    # open source NVIDIA opensource kernel module
    open = false;

    # Access settings
    nvidiaSettings = true;

    # Optional
    package = config.boot.kernelPackages.nvidiaPackages.production;

  };

  # Fonts
  fonts.packages = with pkgs; [
    nerdfonts
    texlivePackages.fontawesome5
  ];
	
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}