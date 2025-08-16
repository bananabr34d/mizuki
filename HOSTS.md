# Mizuki Host Names and Definition

## Definition of Mizuki
*Mizuki* is a multifaceted Japanese word, deeply rooted in cultural, natural, and spiritual contexts, making it a fitting name for this NixOS configuration repository inspired by [Basecamp’s Omarchy](https://github.com/basecamp/omarchy) and the *omakase* (chef-curated) philosophy. Its meanings include:

- **Water (*Mizu*)**: Derived from the kanji 瑞 (*mizu*, auspicious or felicitous), *Mizuki* evokes fluidity, adaptability, and clarity, aligning with the seamless networking (e.g., [Tailscale](https://tailscale.com/)) and modular design of the configuration.
- **Auspicious Tree (*Ki*)**: The kanji 樹 (*ki*, tree) suggests growth, strength, and auspiciousness, reflecting the robust, curated setup across multiple systems (laptops, desktop, VM, Mac Mini) and the use of [Hyprland](https://hyprland.org/) and [Yazi](https://yazi-rs.github.io/) for a developer-friendly environment.
- **Beautiful Moon**: The alternative kanji 美月 (*mi* for beauty, *tsuki* for moon) connects to elegance and guidance, complementing the aesthetic focus (e.g., [Catppuccin Mocha](https://github.com/catppuccin/catppuccin), emoji-enhanced interfaces) and the configuration’s flexibility for theme-switching.
- **Nature (Dogwood Trees)**: *Mizuki* refers to Japanese dogwood trees (*Cornus kousa*), symbolizing natural beauty and resilience, mirroring the configuration’s polished yet practical design.
- **Shinto Spirituality**: In Shinto, *Mizuki* can denote sacred or auspicious qualities, resonating with the curated, intentional workflow inspired by *omakase* and tools like [Neovim](https://neovim.io/) with [Zettelkasten.nvim](https://github.com/oberblastmeister/zettelkasten.nvim) for note-taking.

Hosted in `~/mizuki`, this configuration manages multiple systems using [Nix flakes](https://nixos.wiki/wiki/Flakes), emphasizing reproducibility, elegance, and a developer-centric experience. The host names below reflect *Mizuki*’s cultural depth, ensuring a cohesive, poetic theme that avoids tying any system (especially the ThinkPad) to a specific aesthetic like Catppuccin Mocha, allowing for periodic theme-switching.

## Revised Host Names
The following host names replace the original elemental names (`carbon`, `hydrogen`, `silicon`, `ether`, `relic`) to align with *Mizuki*’s water, tree, moon, and Shinto-inspired theme. Each name reflects the system’s role while maintaining a unified Japanese aesthetic.

| Original Host | New Host | Meaning            | System Role       | OS          | Desktop   |
|---------------|----------|--------------------|-------------------|-------------|-----------|
| carbon        | Sui      | Water              | Laptop            | NixOS       | Hyprland  |
| hydrogen      | Kiyomi   | Pure/Auspicious Beauty | Desktop       | NixOS       | Hyprland  |
| silicon       | Mizore   | Sleet              | Desktop           | Nix-Darwin  | macOS     |
| ether         | Shizuku  | Droplet            | Test VM           | NixOS       | Hyprland  |
| relic         | Yurei    | Spirit/Ghost       | Test Laptop       | NixOS       | Hyprland  |

### Host Name Explanations
- **Sui (ThinkPad X1, Laptop, NixOS, Hyprland)**:
  - **Meaning**: *Sui* (an alternate reading of *mizu*, meaning "water") evokes fluidity and adaptability, aligning with *Mizuki*’s core water theme.
  - **Why**: Perfect for a mobile laptop, *Sui* reflects versatility and supports periodic theme-switching (e.g., beyond Catppuccin Mocha) without tying to a specific aesthetic. It complements the [Hyprland](https://hyprland.org/) environment’s dynamic, fluid workflow.

- **Kiyomi (Beelink GTR5, Desktop, NixOS, Hyprland)**:
  - **Meaning**: *Kiyomi* ("pure beauty" or "auspicious beauty," from *ki* for tree and *mi* for beauty) ties to *Mizuki*’s "auspicious tree" kanji (瑞樹).
  - **Why**: Suits a powerful desktop (AMD Ryzen 9, 32GB RAM) and [Tailscale](https://tailscale.com/) exit node, symbolizing a strong, central "tree" in your network with a robust, elegant setup.

- **Mizore (Mac Mini M4, Desktop, Nix-Darwin)**:
  - **Meaning**: *Mizore* ("sleet") connects to *Mizuki*’s water aspect, suggesting a delicate, balanced system.
  - **Why**: Fits the Mac Mini’s sleek, minimal [Nix-Darwin](https://github.com/LnL7/nix-darwin) environment with a [Spotify](https://www.spotify.com/) PWA, evoking a subtle, fluid aesthetic.

- **Shizuku (Virtual Machine, QEMU, NixOS, Hyprland)**:
  - **Meaning**: *Shizuku* ("droplet") aligns with *Mizuki*’s water theme, representing a small, transient element.
  - **Why**: Ideal for a lightweight VM (2GB RAM, 2 cores) used for testing, its ephemeral nature mirrors a droplet’s fleeting quality in the configuration.

- **Yurei (Dell XPS 13, Test Laptop, NixOS, Hyprland)**:
  - **Meaning**: *Yurei* ("spirit" or "ghost") ties to *Mizuki*’s Shinto spirituality, evoking an experimental, ethereal quality.
  - **Why**: Perfect for a test laptop validating configs (e.g., emoji rendering, Hyprland), its spiritual vibe aligns with *Mizuki*’s deeper cultural roots.

## Implementation Notes
To integrate these names into the `~/mizuki` repository:
- **Update `flake.nix`**: Modify `nixosConfigurations` and `homeConfigurations` to use `Sui`, `Kiyomi`, `Mizore`, `Shizuku`, and `Yurei`, as shown in the [flake.nix configuration](#). Rename host directories in `nixos/hosts/` and `darwin/hosts/` (e.g., `carbon/` to `Sui/`, `silicon/` to `Mizore/`).
- **Update SOPS and Tailscale**: Adjust `secrets.yaml` for new `tailnet_name` entries (e.g., `Sui.cheetoh-galaxy.ts.net`) and update [Tailscale](https://tailscale.com/) MagicDNS aliases in `home/home.nix`.
- **Update README**: Reflect the new names in the System Overview table and Fresh Install Steps, replacing references to old host names.
- **Test the Setup**: Verify the configuration for `Yurei` (formerly `relic`) using:
  ```bash
  sudo nixos-rebuild switch --flake ~/mizuki#Yurei
  home-manager switch -b backup --flake ~/mizuki#joe@Yurei
  ```

These names create a cohesive, poetic theme rooted in *Mizuki*’s water, tree, and spiritual dimensions, ensuring flexibility for theme-switching and alignment with the curated, developer-focused philosophy of *omakase*.
