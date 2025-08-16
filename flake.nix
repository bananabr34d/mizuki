{
  description = "My NixOS and Home Manager Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
  };

  outputs = { self, nixpkgs, home-manager, disko, hyprland, nixos-hardware, ... }:
  let
    system = "x86_64-linux";
    lib = nixpkgs.lib;
  in
  {
    nixosConfigurations.yurei = lib.nixosSystem {
      inherit system;
      modules = [
        nixos-hardware.nixosModules.dell-xps-13-9360
        disko.nixosModules.disko
        ../nixos
      ];
    };

    homeConfigurations."joe@relic" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.${system};
      modules = [
        ../home-manager
      ];
    };
  };
}
