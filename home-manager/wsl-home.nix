{ ... }: {
  imports = [
    ./home.nix
  ];

  home.packages = with pkgs; [
    # editors
    emacs29
  ];

  # Enable programs that need extra config
  # NOTE: Don't add GUI packages here since it'll conflict with nix-darwin
  # (homebrew casks)
  programs = {
    firefox.enable = true;
  };

  # Services
  services = {
    syncthing.enable = true;
  };
}
