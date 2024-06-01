{ ... }:
{
  imports = [ ./darwin.nix ];
  networking.hostName = "mac-studio";
  homebrew.casks = [ "steermouse" ];
}
