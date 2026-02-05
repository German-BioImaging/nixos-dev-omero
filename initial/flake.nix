{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    nix-ld.url = "github:Mic92/nix-ld";
    nix-ld.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nixos-wsl, nix-ld, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      # Make pkgs available inside modules
      specialArgs = { inherit inputs; };
      pkgs = import nixpkgs { system = "x86_64-linux"; };

      modules = [
        nixos-wsl.nixosModules.default
        nix-ld.nixosModules.nix-ld

        ({ pkgs, ... }: {
          system.stateVersion = "25.05";
          wsl.enable = true;

          environment.systemPackages = with pkgs; [
            git
            vim
            direnv
            tmux
          ];
        })
      ];
    };
  };
}
