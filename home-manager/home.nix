# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{ pkgs, ... }:
{
  # Add stuff for your user as you see fit:
  # NOTE: Don't add GUI packages here since it'll conflict with nix-darwin
  # (homebrew casks)
  home.packages = with pkgs; [
    # baseline tools
    git
    ripgrep
    coreutils
    fd
    wget
    curl
    nh

    # emacs stuff
    (aspellWithDicts (
      ps: with ps; [
        en
        en-computers
        en-science
      ]
    ))
    pandoc
    editorconfig-core-c
    sqlite
    fontconfig

    # compiler stuff
    cmake
    gnumake

    # nix lang stuff
    nixfmt-rfc-style
    nil

    # fonts
    jetbrains-mono
    etBook
    (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
  ];

  # Enable programs that need extra config
  # NOTE: Don't add GUI packages here since it'll conflict with nix-darwin
  # (homebrew casks)
  programs = {
    git = {
      enable = true;
      userName = "Isaac Wooden";
      userEmail = "iwooden@protonmail.com";
    };
    vim = {
      enable = true;
      defaultEditor = true;
    };
    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
    zsh = {
      enable = true;
      syntaxHighlighting.enable = true;
      oh-my-zsh = {
        enable = true;
        plugins = [ ];
        theme = "jispwoso";
      };
    };
  };

  # Fonts
  fonts.fontconfig.enable = true;

  # Nicely reload system units when changing configs
  # Disabling cause this prooobably breaks on WSL
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";
}
