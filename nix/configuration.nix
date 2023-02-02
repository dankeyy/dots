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
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.loader.grub.configurationLimit = 10;

  networking.hostName = "computer";
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  users.defaultUserShell = pkgs.fish;

  # Set your time zone.
  time.timeZone = "Asia/Jerusalem";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_IL";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "he_IL.UTF-8";
    LC_NAME = "he_IL.UTF-8";
    LC_MONETARY = "he_IL.UTF-8";
    LC_PAPER = "he_IL.UTF-8";
    LC_IDENTIFICATION = "he_IL.UTF-8";
    LC_TELEPHONE = "he_IL.UTF-8";
    LC_MEASUREMENT = "he_IL.UTF-8";
    LC_TIME = "he_IL.UTF-8";
    LC_NUMERIC = "he_IL.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dankey = {
    isNormalUser = true;
    description = "dankey";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
    packages = with pkgs; [
      firefox
      kate
    # thunderbird
    ];
  };
  
  # virtualisation
  networking.firewall.trustedInterfaces = [ "virbr0" "virbr1" ];
  virtualisation.libvirtd = {
    enable = true;

    onShutdown = "suspend";
    onBoot = "ignore";

    qemu = {
      package = pkgs.qemu_kvm;
      ovmf.enable = true;
      ovmf.packages = [ pkgs.OVMFFull.fd ];
      swtpm.enable = true;
      runAsRoot = false;
    };
  };

  # built in programs config
  programs.gnupg.agent = {
    enable = true;
    pinentryFlavor = "qt";
    enableSSHSupport = true;
  };
  programs.dconf.enable = true;
  programs.partition-manager.enable = true;
  programs.kdeconnect.enable = true;
  
  # some more general services
  services.emacs.package = pkgs.emacsPgtk;  
  services.mullvad-vpn.enable = true;
  services.earlyoom.enable = true;

  # packages
  environment.systemPackages = with pkgs; [
    (pkgs.emacs.override {withGTK3 = false; nativeComp = true;})
    (let 
      my-python-packages = python-packages: with python-packages; [ 
        mypy
        numpy
        pandas
        requests
        ipython
        jupyter
      ];
      python-with-my-packages = python3.withPackages my-python-packages;
    in
    python-with-my-packages)
    procs
    xclip
    git
    clang
    gtk2
    gcc
    vim
    stremio
    sublime4
    wget
    tmux
    discord
    tldr
    fish
    xonsh
    mullvad-vpn
    neovim
    starship
    exa
    htop
    docker
    docker-compose
    ripgrep
    fd
    tabnine
    fortune
    libinput-gestures
    tdesktop
    rustup
    cbqn
    file
    bat
    go
    rlwrap
    tree-sitter
    dmd
    clang-tools
    gnumake
    llvm
    nodePackages.pyright
    nerdfonts
    imagemagick
    zoom-us
    virt-manager
    nasm
    mold
    fasm 
    yasm
    gimp
    gforth
    rlwrap
    factor-lang
    ascii
    dnsmasq
    libtpms
    tpm2-tss
    tpm2-tools
    win-virtio
    cutter
    vscode-fhs  
    lua
    ocaml
    luajit
    earlyoom
    fzf
    _7zz
    xarchiver
    brotli
    gnupg
    helix
    spotify
    direnv 
    nix-direnv
   ];

  # nix + direnv
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    keep-outputs = true;
    keep-derivations = true;
  };

  nixpkgs.config.allowUnfree = true;
  
  nixpkgs.overlays = [
    (self: super: { nix-direnv = super.nix-direnv.override { enableFlakes = true; }; } )
  ];

  environment.pathsToLink = [
    "/share/nix-direnv"
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
  system.stateVersion = "22.11"; # Did you read the comment?

}
