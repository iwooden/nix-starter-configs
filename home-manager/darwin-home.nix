{ outputs, pkgs, ... }:
{
  imports = [ ./home.nix ];

  # Need to define nixpkgs here for standalone home-manager
  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];
    config = {
      allowUnfree = true;
    };
  };

  home = {
    username = "iwooden";
    homeDirectory = "/Users/iwooden";
  };

  programs = {
    home-manager.enable = true;
    emacs = {
      enable = true;
      package = pkgs.emacs-macport;
      extraPackages = epkgs: with epkgs; [ vterm ];
    };
  };
}
