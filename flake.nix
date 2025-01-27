{
  description = "The first falke";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  }: let
    lib = nixpkgs.lib;
    pkgs = nixpkgs.pkgs;
  in {
    nixosConfigurations = {
      nixos-test = lib.nixosSystem {
        system = "x86_64-linux";
        modules = [./configuration.nix];
      };
    };
    #      hardware.pulseaudio.enable = true;
    #      services.xserver.enable = true;
    #      services.displayManager.sddm.enable = true;
    #      services.desktopManager.plasma6.enable = true;
    #      enviroment.plasma6.excludePackages = with pkgs.kdePackages;[ plasma-browser-intergration oxygen];
  };
}
