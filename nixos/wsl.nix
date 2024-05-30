{ ... }: {
  imports = [ ./default-stuff.nix ];
  nixpkgs.hostPlatform = "x86_64-linux";
  networking.hostName = "nix-wsl";

  # wsl-specific config
  wsl = {
    enable = true;
    defaultUser = "iwooden";
    startMenuLaunchers = true;
    # needed to fix home-manager services
    # see https://github.com/nix-community/NixOS-WSL/issues/375
    # and https://github.com/microsoft/WSL/issues/10205
    nativeSystemd = false;
  }

  # don't change this
  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}
