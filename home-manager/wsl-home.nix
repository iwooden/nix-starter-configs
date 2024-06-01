{ pkgs, ... }:
{
  imports = [ ./home.nix ];

  home = {
    username = "iwooden";
    homeDirectory = "/home/iwooden";
  };

  programs = {
    firefox.enable = true;
    emacs = {
      enable = true;
      package = pkgs.emacs;
      extraPackages = epkgs: with epkgs; [ vterm ];
    };
  };

  # Services
  services = {
    syncthing.enable = true;
  };
}
