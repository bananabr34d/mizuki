{
  config,
  pkgs,
  ...
}: {

  # Include disko configuration
  imports = [ 
    # Use module this flake exports; from modules/nixos
    #outputs.nixosModules.my-module
    # Use modules from other flakes
    ./yurei
  ];

  boot = {
    consoleLogLevel = 0;
    initrd.verbose = false;
    kernelModules = [ "vhost_vsock" ];
    kernelParams = [ "udev.log_priority=3" ];
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
        consoleMode = "max";
        memtest86.enable = true;
        timeout = 10;
      };
    };
  };

  # System configuration
  networking = {
    networkmanager.enable = true;
    hostName = "yurei";
  };
  time.timeZone = "America/Chicago";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
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
  };

  users.users.joe = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "lp" ];
    shell = pkgs.zsh;
    initialPassword = "temporary-password"; # Change after first login
  };

  # Essential services
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };
  networking.networkmanager.enable = true;
  services.printing.enable = true;
  services.avahi.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  # Power management for XPS
  services.tlp = {
    enable = true;
    settings = {
      TLP_DEFAULT_MODE = "BAT";
      START_CHARGE_THRESH_BAT0 = 75;
      STOP_CHARGE_THRESH_BAT0 = 80;
    };
  };

  # Packages
  environment = {
    systemPackages = with pkgs; [
      brave
      curl
      fastfetch
      fuzzel
      git
      hyprland
      kitty
      thunar
      vim
      waybar
      wget
      yazi
    ];
    variables = {
      EDITOR = "nvim";
      SYSTEMD_EDITOR = "nvim";
      VISUAL = "nvim";
    };
  };

  # Allow unfree packages (e.g., for Brave)
  nixpkgs.config.allowUnfree = true;

  # Enable flakes
  nix = {
    optimise.automatic = true;
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      trusted-users = [ "joe" ];
      warn-dirty = false;
    };
    channel.enable = false;
  };
  programs = {
    zsh = {
      enable = true;
      shellAliases = {
        nano = "nvim";
      };
      nh = {
        enable = true;
        clean = {
          enable = true;
          extraArgs = "--keep-since 15d --keep 10";
        };
        flake = "/home/joe/mizuki"
      };
    };
  };

  # State version
  system.stateVersion = "25.05";
}
