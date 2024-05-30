{ ... }: {
  imports = [ ./default-stuff.nix ];
  nixpkgs.hostPlatform = "x86_64-linux";
  networking.hostName = "nix-wsl";

  # wsl-specific config
  wsl = {
    enable = true;
    defaultUser = "iwooden";
    startMenuLaunchers = true;
  }

  # don't change this
  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}
