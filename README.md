
# Mizuki: A Curated NixOS Configuration

[Mizuki](https://github.com/your-username/mizuki) is a [NixOS](https://nixos.org/), [Nix-Darwin](https://github.com/LnL7/nix-darwin), and [Home Manager](https://github.com/nix-community/home-manager) configuration inspired by [Basecamp’s Omarchy](https://github.com/basecamp/omarchy), drawing from the Japanese *omakase* (chef-curated experience) and *mizu* (water) for a fluid, elegant, and opinionated developer environment. Hosted in `~/mizuki`, it manages multiple systems—laptops (`carbon`, `relic`), a desktop (`hydrogen`), a [Mac Mini](https://www.apple.com/mac-mini/) (`silicon`), and a VM (`ether`)—using [Nix flakes](https://nixos.wiki/wiki/Flakes) for reproducible setups. Mizuki features [LUKS](https://wiki.archlinux.org/title/Dm-crypt)-encrypted [BTRFS](https://btrfs.wiki.kernel.org/), [Hyprland](https://hyprland.org/), file management with nautilus and yazi, and tools like [Neovim](https://neovim.io/) for a modern workflow. It emphasizes simplicity, dark theming, and seamless networking via [Tailscale](https://tailscale.com/). 
This flake provides a minimal NixOS configuration for the Dell XPS 13 (`relic`) with LUKS-encrypted BTRFS and Hyprland desktop. It includes essential packages, SSH, and power management, designed for reliable installation. The `nixosConfigurations` and `homeConfigurations` are defined separately in `../nixos` and `../home-manager` directories for modularity.

## System Overview

| Hostname | Board       | CPU                | RAM  | GPU             | OS    | Role        | Desktop  |
|----------|-------------|--------------------|------|-----------------|-------|-------------|----------|
| relic    | Dell XPS 13 | Intel (varies)     | 8GB+ | Intel (integrated) | NixOS | Test Laptop | Hyprland |

### Common Settings
- **Disk Layout**:
  - 1GB EFI boot partition (`/boot`, FAT32)
  - LUKS-encrypted BTRFS partition with subvolumes: `/` (root), `/home`, `/nix`
- **Desktop Environment**: Hyprland with Waybar, Fuzzel, Kitty, and Yazi. Keybindings: `brave` (`SUPER+F`), Thunar (`SUPER+E`), Yazi (`SUPER+Y`), emoji picker (`SUPER+I`), lock screen (`SUPER+L`), Fuzzel (`SUPER+R`).
- **File Managers**: Thunar (GUI, `Adwaita-dark`) and Yazi (terminal-based, Catppuccin Mocha with emoji icons).
- **Editor**: Neovim with `nvim-treesitter`, `nvim-cmp`, `telescope.nvim`.
- **Fonts**: Hack Nerd Font for Kitty, Waybar, Fuzzel, and Starship.
- **Emoji Support**: Curated emoji list (`~/.config/emojis.txt`) and `emoji-picker.sh` for Fuzzel-based emoji selection.
- **User**: `joe` (Zsh shell, `lp` group for printing, initial password `temporary-password`)
- **Packages**: `brave`, `curl`, `git`, `vim`, `hyprland`, `waybar`, `fuzzel`, `kitty`, `thunar`, `yazi` (system); `neovim`, `zsh`, `starship`, `fzf`, `ripgrep`, `fd`, `bat`, `bemoji` (user).
- **Services**: OpenSSH (key-based), NetworkManager, PipeWire, CUPS (printing), Avahi (printer discovery).
- **Timezone**: America/Chicago
- **Locale**: `en_US.UTF-8`
- **Keyboard**: US layout for Hyprland
- **Power Management**: TLP with XPS-specific charge thresholds
- **State Version**: `25.05`

## Files
All files are organized across `~/wtf`, `../nixos`, and `../home-manager`.

Project Overview
Mizuki delivers a curated, reproducible environment for developers, blending Omarchy’s one-command setup philosophy with a polished, aesthetic-driven experience. Key features include:

Multi-System Support: Configurations for NixOS (laptops, desktop, VM) and Nix-Darwin (Mac Mini), defined in flake.nix.
Desktop Environment: Hyprland on NixOS with Waybar, SwayNC, Fuzzel, Kitty, and keybindings (SUPER+F for Brave, SUPER+Y for Yazi, SUPER+I for emoji picker).
Aesthetic: Catppuccin Mocha dark theme across Hyprland, Yazi, Kitty, and Fuzzel, with Hack Nerd Font and emoji icons for filetypes (e.g., 📄 for .txt, 📁 for directories).
File Management: Thunar (GUI, Adwaita-dark) and Yazi (terminal, emoji-enhanced) for intuitive navigation.
Editor: Neovim with nixvim, supporting nvim-orgmode, zettelkasten.nvim, and nvim-cmp for note-taking and coding.
Networking: Tailscale for secure VPN and SSH, Caddy for Syncthing reverse proxy, and Samba for network shares.
Storage: LUKS-encrypted BTRFS with subvolumes (/, /home, /nix, etc.) and Snapper for hourly snapshots.
Secrets: SOPS with age encryption for credentials (joe_password, tailscale_auth_key).
Packages: Curated tools like bemoji, lazygit, ripgrep, spotify, and zen-browser for productivity and media.

Mizuki’s fluid, modular design ensures a consistent, developer-friendly experience across systems, with a focus on modern aesthetics and streamlined workflows. Future enhancements may include [Grok API](https://x.ai/api) integration for AI-assisted note-taking and additional [Yazi plugins](https://github.com/yazi-rs/plugins).
