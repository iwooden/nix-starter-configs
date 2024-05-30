# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # switch stuff based on darwin/linux
  inherit (pkgs.stdenv) isDarwin;

  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  home = {
    username = "iwooden";
    homeDirectory = "/home/iwooden";
  };

  # Add stuff for your user as you see fit:
  home.packages = with pkgs; [
    # baseline tools
    git
    ripgrep
    coreutils
    fd
    wget
    curl
    unstable.nh

    # editors
    (if isDarwin then emacs-mac else emacs29)

    # emacs stuff
    aspell
    pandoc
    editorconfig-core-c
    sqlite

    # compiler stuff
    cmake
    gnumake

    # nix lang stuff
    nixfmt
  ];

  # Enable programs that need extra config
  programs = {
    home-manager.enable = true;
    git = {
      enable = true;
      userName = "Isaac Wooden";
      userEmail = "iwooden@protonmail.com";
    };
    firefox.enable = true;
    vim = {
      enable = true;
      defaultEditor = true;
    };
    direnv = {
      enable = true;
      enableBashIntegration = true;
      nix-direnv.enable = true;
    }
  };

  # Services
  services = {
    syncthing.enable = true;
  };

  # Nicely reload system units when changing configs
  # Disabling cause this prooobably breaks on WSL
  # systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";
}
