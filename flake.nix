{
  description = "The first falke";

  inputs = {
    nixpkgs-stable.url = "nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-stable,
    nixpkgs-unstable,
    ...
  }: let
    lib = nixpkgs-stable.lib;
    pkgs = nixpkgs-stable.legacyPackages.${system};
    system = "x86_64-linux";
    unstable = nixpkgs-unstable.legacyPackages.${system};
  in {
    nixosConfigurations = {
      kde-nixOS = lib.nixosSystem {
        inherit system;
        modules = [./configuration.nix];
        specialArgs = {
          inherit unstable;
          inherit lib;
        };
      };
    };
    #      hardware.pulseaudio.enable = true;
    #      services.xserver.enable = true;
    #      services.displayManager.sddm.enable = true;
    #      services.desktopManager.plasma6.enable = true;
    #      enviroment.plasma6.excludePackages = with pkgs.kdePackages;[ plasma-browser-intergration oxygen];
  };
}
