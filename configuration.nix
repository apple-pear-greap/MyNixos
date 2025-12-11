{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  nix.settings = {
    substituters = [
      "https://mirror.sjtu.edu.cn/nix-channels/store"
      "https://mirrors.ustc.edu.cn/nix-channels/store"
      "https://cache.nixos.org"
    ];
  };
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Set fonts
  fonts.packages = with pkgs;[
	noto-fonts
	noto-fonts-cjk-sans
	noto-fonts-cjk-serif
	noto-fonts-color-emoji
	sarasa-gothic
	jetbrains-mono
  ];
  fonts.fontconfig = {
	enable = true;
	defaultFonts = {
	    emoji = ["Noto Color Emoji"];
	    monospace = ["Noto Sans Mono CJK SC" "Sarasa Mono SC" "DejaVu Sans Mono"];
	    sansSerif = ["Noto Sans CJK SC" "Source Han Serif SC" "DejaVu Serif"];
	    serif = ["Noto Serif CJK SC" "Source Han Serif SC" "DejaVu Serif"];
  	};
  };

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable bluetooth
  hardware.bluetooth.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_MESSAGES = "zh_CN.UTF-8";
    LC_ADDRESS = "zh_CN.UTF-8";
    LC_IDENTIFICATION = "zh_CN.UTF-8";
    LC_MEASUREMENT = "zh_CN.UTF-8";
    LC_MONETARY = "zh_CN.UTF-8";
    LC_NAME = "zh_CN.UTF-8";
    LC_NUMERIC = "zh_CN.UTF-8";
    LC_PAPER = "zh_CN.UTF-8";
    LC_TELEPHONE = "zh_CN.UTF-8";
    LC_TIME = "zh_CN.UTF-8";
  };

  # Set fcitx5
  i18n.inputMethod = {
	type = "fcitx5";
	enable = true;
	fcitx5.waylandFrontend = true;
	fcitx5.addons = with pkgs;[
	    fcitx5-gtk
	    qt6Packages.fcitx5-chinese-addons
	    fcitx5-nord
	];
  };

  # Set daed for Internet
  boot.kernel.sysctl = {
	"net.ipv4.ip_forward" = 1;
	"net.ipv6.conf.all.forwarding" = 1;
  };

  services.daed = {
    enable = true;
    listen = "0.0.0.0:2023";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  # Enable KDE Plasma & SDDM
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.cerydra = {
    isNormalUser = true;
    description = "Cerydra";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
    ];
  };

  # Install some programs for system
  programs.firefox.enable = true;
  programs.zsh.enable = true;
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Install systemPackages
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    # fastfetch
    # kitty
    # vscode
    # splayer
    # chromium
    # bat
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

  system.stateVersion = "25.11"; 

}
