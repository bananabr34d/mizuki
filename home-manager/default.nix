{
  pkgs,
  ...
}: {

  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default
  ];
  home = {
    stateVersion = "25.05";
    username = "joe";
    homeDirectory = "/home/joe";

    # Home Manager packages
    packages = with pkgs; [
      bemoji
      fd
      hack-font 
      neovim
    ];

    sessionVariables = {
      EDITOR = "nvim";
      SUDO_EDITOR = "nvim";
      SYSTEMD_EDITOR = "nvim";
      VISUAL = "nvim";
      MANPAGER = "sh -c 'col --no-backspaces --spaces | bat --language man'";
      MANROFFOPT = "-c";
      PAGER = "bat";
    };
  };

  # Font configuration
  fonts.fontconfig.enable = true;

  news.display = "silent";

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  nix = {
    package = pkgs.nixVersions.latest;
    settings = {
      experimental-features = "flakes nix-command";
    };
  };

  programs = {
    bat = {
      enable = true;
      extraPackages = with pkgs.bat-extras; [
        batgrep
        batwatch
        prettybat
      ];
      config = {
        style = "plain";
      };
    };
    bottom = {
      enable = true;
      settings = {
        disk_filter = {
          is_list_ignored = true;
          list = [ "/dev/loop" ];
          regex = true;
          case_sensitive = false;
          whole_word = false;
        };
        flags = {
          dot_marker = false;
          enable_gpu_memory = true;
          group_processes = true;
          hide_table_gap = true;
          mem_as_value = true;
          tree = true;
        };
      };
    };
    dircolors = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };
    direnv = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      nix-direnv = {
        enable = true;
      };
    };
    eza = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      extraOptions = [
        "--group-directories-first"
        "--header"
        "--time-style=long-iso"
      ];
      git = true;
      icons = "auto";
    };
    fzf = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };
    gpg.enable = true;
    home-manager.enable = true;
    info.enable = true;
    kitty = {
      enable = true;
      theme = "Catppuccin-Mocha";
      font = {
        name = "Hack Nerd Font";
        size = 12;
      };
    };
    neovim = {
      enable = true;
      plugins = with pkgs.vimPlugins; [
        nvim-treesitter
        nvim-cmp
        telescope-nvim
      ];
    };
    nix-index.enable = true;
    ripgrep = {
      arguments = [
        "--colors=line:style:bold"
        "--max-columns-preview"
        "--smart-case"
      ];
      enable = true;
    };
    starship = {
      enable = true;
      settings = {
        add_newline = false;
      };
      enableBashIntegration = true;
      enableZshIntegration = true;
    };
    tealdeer = {
      enable = true;
      settings = {
        compact = false;
        use_pager = true;
        updates = {
          auto_update = true;
          auto_update_interval_hours = 72;
        };
      };
    };
    yazi = {
      enable = true;
      settings = {
        manager = {
          show_hidden = true;
          sort_by = "alphabetical";
        };
      };
      theme = {
        filetypes = {
          txt = { icon = "📄"; };
          md = { icon = "📝"; };
          jpg = { icon = "📷"; };
          dir = { icon = "📁"; };
        };
        manager = {
          cwd = { fg = "#cba6f7"; };
        };
      };
    };
    zsh = {
      enable = true;
      dotDir = ".config/zsh";
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting = {
        enable = true;
      };

      history = {
        save = 10000;
        size = 10000;
        path = "$HOME/.cache/zsh_history";
      };

      initContent = ''
                bindkey '^[[1;5C' forward-word # Ctrl+RightArrow
                bindkey '^[[1;5D' backward-word # Ctrl+LeftArrow

                zstyle ':completion:*' completer _complete _match _approximate
                zstyle ':completion:*:match:*' original only
                zstyle ':completion:*:approximate:*' max-errors 1 numeric
                zstyle ':completion:*' menu select
                zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"

                # HACK! Simple shell function to patch ruff bins downloaded by tox from PyPI to use
                # the ruff included in NixOS - needs to be run each time the tox enviroment is
                # recreated
                patch_tox_ruff() {
                  for x in $(find .tox -name ruff -type f -print); do
                    rm $x;
                    ln -sf $(which ruff) $x;
                  done
                }

                clean-crafts-lxc() {
                  for CRAFT in snapcraft rockcraft charmcraft; do
                    lxc --project $CRAFT list -fcsv -cn | xargs lxc --project $CRAFT delete -f >/dev/null
                  done
                }

                export LEDGER_FILE=~/Hledger/2024.journal
                export HISTFILE=~/.cache/zsh_history
      '';

      shellAliases = {
        #  ls = "eza -gl --git --color=automatic";
        tree = "eza --tree";
        cat = "bat";

        ip = "ip --color";
        ipb = "ip --color --brief";

        gac = "git add -A  && git commit -a";
        gp = "git push";
        gst = "git status -sb";

        htop = "btm -b";
        neofetch = "fastfetch";

        wgu = "sudo wg-quick up";
        wgd = "sudo wg-quick down";

        ts = "tailscale";
        tst = "tailscale status";
        tsu = "tailscale up --ssh --operator=$USER";
        tsd = "tailscale down";

        open = "xdg-open";

        opget = "op item get \"$(op item list --format=json | jq -r '.[].title' | fzf)\"";

        cleanup-nix = "nh clean all --keep-since 10d --keep 3";
        rln = "nh os switch /home/joe/wtf";
        rlh = "nh home switch /home/joe/wtf";
        rlb = "rln;rlh";

        moon = "curl www.wttr.in/Moon";
        wttr = "curl wttr.in/Baton+Rouge";
      };
    };
  };

  # Hyprland configuration
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = [
        "eDP-1,1920x1080@60,0x0,1"
      ];
      exec-once = [
        "waybar"
        "hyprpaper"
      ];
      input = {
        kb_layout = "us";
      };
      bind = [
        "SUPER,F,exec,brave"
        "SUPER,E,exec,thunar"
        "SUPER,Y,exec,kitty -e yazi"
        "SUPER,I,exec,~/.config/emoji-picker.sh"
        "SUPER,L,exec,hyprlock"
        "SUPER,R,exec,fuzzel"
      ];
    };
  };

  # Emoji picker script
  home.file.".config/emoji-picker.sh".text = ''
    #!/bin/sh
    bemoji -t | fuzzel --dmenu | wl-copy
  '';

  # Basic emoji list
  home.file.".config/emojis.txt".text = ''
    😊 smile
    📄 document
    📁 folder
    📝 note
    📷 photo
  '';

}
