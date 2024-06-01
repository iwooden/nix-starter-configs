{ pkgs, ... }: {
  imports = [ ./home.nix ];

  home = {
    username = "iwooden";
    homeDirectory = "/Users/iwooden";
  };

  programs = {
    emacs = {
      enable = true;
      package = pkgs.emacs29-macport;
    };
  };
}
