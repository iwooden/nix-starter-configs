{ ... }:
{
  imports = [ ./default-stuff.nix ];
  nixpkgs.hostPlatform = "aarch64-darwin";

  services.nix-daemon.enable = true;

  homebrew = {
    enable = true;

    # Careful - this will delete everything not listed below
    onActivation.cleanup = "uninstall";

    casks = [
      "1password"
      "google-chrome"
      "wezterm"
      "spotify"
      "discord"
      "signal"
      "whatsapp"
      "zoom"
      "syncthing"
    ];

    # Mac AppStore stuff
    masApps = { };
  };

  system.defaults = {
    # minimal dock
    dock = {
      autohide = true;
      show-process-indicators = false;
      show-recents = false;
      static-only = true;
    };
    # a finder that tells me what I want to know and lets me work
    finder = {
      AppleShowAllExtensions = true;
      ShowPathbar = true;
      FXEnableExtensionChangeWarning = false;
    };
    NSGlobalDomain = {
      AppleInterfaceStyle = "Dark";
    };
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
