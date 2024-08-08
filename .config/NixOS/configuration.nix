{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # ZSH Config
  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

  fonts.fontDir.enable = true;

  xdg.portal = {
        enable = true;
        extraPortals = [
         pkgs.xdg-desktop-portal
         pkgs.xdg-desktop-portal-gtk
     ];
    };

  # Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Pipewire Sound
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  
  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };

  hardware = {
   graphics.enable = true;
   nvidia.modesetting.enable = true;
  };

  # Thunar Setup
  programs.thunar.enable = true;
  programs.thunar.plugins = with pkgs.xfce; [
  thunar-archive-plugin
 ];
  services.gvfs.enable = true;
  programs.xfconf.enable = true;

  # Bluetooth Service
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  hardware.bluetooth.settings = {
	General = {
		Experimental = true;
	};
};
  hardware.bluetooth.powerOnBoot = true;

  # Nvidia
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
  services.xserver.videoDrivers = [ "nvidia" ];

  # Waybar
  programs.waybar = {
  enable = true;
  };

  networking.hostName = "Subha";
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    packages = [pkgs.terminus_font];
    font = "${pkgs.terminus_font}/share/consolefonts/ter-i22b.psf.gz";
    useXkbConfig = true;
  };

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
   };

  virtualisation.libvirtd.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.subha = {
    isNormalUser = true;
    description = "Subha";
    extraGroups = [ "networkmanager" "wheel" ];
    openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOwjaOhnlZT5bfobgF25haBvkcyGqEjAABp8mPZV1bIE" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [
    neovim
    wget
    curl
    git
    lazygit
    gh
    glab
    zsh
    home-manager
    killall
    gzip
    unzip
    gnumake
    clang
    brave
    rofi-wayland
    swww
    kitty
    dunst
    vlc
    gvfs
    xfce.thunar
    mtpfs
    fastfetch
    networkmanagerapplet
    fzf
    tmux
    grim
    slurp
    wl-clipboard
    zoxide
    python3
    cargo
    blueman
    brightnessctl
    spotify
    playerctl
    libreoffice
    pavucontrol
    gcc
    dconf
    jq
    bc
    usbutils
    v4l-utils
    btop
    yazi
    jellyfin-ffmpeg
    tree
    stow

    #Cursors
    bibata-cursors

    # Icon Themes
    kora-icon-theme

    # Themes
    orchis-theme
  ];

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # Add any missing dynamic libraries for unpackaged programs
    # here, NOT in environment.systemPackages
    lua-language-server
  ];

  # Fonts
  fonts.fontconfig.enable = true;
  fonts = {
  packages = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    openmoji-color
    noto-fonts
    font-awesome
    noto-fonts-cjk
    noto-fonts-cjk-sans
    noto-fonts-emoji
    fira
    fira-code
    fira-code-symbols
    intel-one-mono
    nerdfonts
   ];
  };

  security.polkit.enable = true;
  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = ["graphical-session.target"];
      wants = ["graphical-session.target"];
      after = ["graphical-session.target"];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
 };

  # Docker Set-up
  virtualisation.docker.enable = true;
  users.extraGroups.docker.members = [ "subha" ];
  virtualisation.docker.rootless = {
  enable = true;
  setSocketVariable = true;
 };

 # SSH Service & Firewall
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  services.openssh.enable = true;
  #networking.firewall.allowedTCPPorts = [ 22 ];
  #networking.firewall.enable = false;

  # VirtualBox
  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.enableExtensionPack = true;

  system.stateVersion = "24.05";

}
