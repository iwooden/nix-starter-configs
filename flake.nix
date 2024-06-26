{
  description = "Your new nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    # You can access packages and modules from different nixpkgs revs
    # at the same time. Here's an working example:
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    # Also see the 'unstable-packages' overlay at 'overlays/default.nix'.

    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # WSL
    nixos-wsl.url = "github:nix-community/nixos-wsl";

    # nix-darwin
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nixos-wsl,
      nix-darwin,
      ...
    }@inputs:
    let
      inherit (self) outputs;
      # Supported systems for your flake packages, shell, etc.
      systems = [
        #"aarch64-linux"
        #"i686-linux"
        "x86_64-linux"
        "aarch64-darwin"
        #"x86_64-darwin"
      ];
      # This is a function that generates an attribute by calling a function you
      # pass to it, with each system as an argument
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
      # Your custom packages
      # Accessible through 'nix build', 'nix shell', etc
      packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
      # Formatter for your nix files, available through 'nix fmt'
      # Other options beside 'alejandra' include 'nixpkgs-fmt'
      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt-rfc-style);

      # Your custom packages and modifications, exported as overlays
      overlays = import ./overlays { inherit inputs; };
      # Reusable nixos modules you might want to export
      # These are usually stuff you would upstream into nixpkgs
      nixosModules = import ./modules/nixos;
      # Reusable home-manager modules you might want to export
      # These are usually stuff you would upstream into home-manager
      homeManagerModules = import ./modules/home-manager;

      # NixOS configuration entrypoint
      # Available through 'nixos-rebuild --flake .#your-hostname'
      nixosConfigurations = {
        # Hostname here
        nix-wsl = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs;
          };
          modules = [
            # > Our main nixos configuration file <
            ./nixos/wsl.nix
            # Needed for WSL
            nixos-wsl.nixosModules.wsl
          ];
        };
      };

      darwinConfigurations = {
        mac-studio = nix-darwin.lib.darwinSystem {
          specialArgs = {
            inherit inputs outputs;
          };
          modules = [ ./nixos/mac-studio.nix ];
        };
        macbook = nix-darwin.lib.darwinSystem {
          specialArgs = {
            inherit inputs outputs;
          };
          modules = [ ./nixos/macbook.nix ];
        };
      };

      # Standalone home-manager configuration entrypoint
      # Really just used for macos
      # Available through 'home-manager --flake .#your-username@your-hostname'
      homeConfigurations = {
        # replace with your username@hostname
        "iwooden@mac-studio" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.aarch64-darwin; # Home-manager requires 'pkgs' instance
          extraSpecialArgs = {
            inherit inputs outputs;
          };
          modules = [
            # > Our main home-manager configuration file <
            ./home-manager/darwin-home.nix
          ];
        };
        "iwooden@macbook" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.aarch64-darwin; # Home-manager requires 'pkgs' instance
          extraSpecialArgs = {
            inherit inputs outputs;
          };
          modules = [
            # > Our main home-manager configuration file <
            ./home-manager/darwin-home.nix
          ];
        };
      };
    };
}
