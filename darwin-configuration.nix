{ config, pkgs, ... }:

let
  cliPackages = import ./packages-cli.nix { inherit pkgs; };
  devPackages = import ./packages-dev.nix { inherit pkgs; };
  rustDevPackages = import ./packages-rust-dev.nix { inherit pkgs; };

in
{
  # MacOS settings
  system.defaults.NSGlobalDomain.AppleKeyboardUIMode = 3;
  system.defaults.NSGlobalDomain.ApplePressAndHoldEnabled = false;

  # Delay before first key repeat
  system.defaults.NSGlobalDomain.InitialKeyRepeat = 12;
  # Speed of the repeat (1 = fastest)
  system.defaults.NSGlobalDomain.KeyRepeat = 1;

  system.defaults.dock.mru-spaces = false;
  system.defaults.dock.autohide = true;
  system.defaults.dock.orientation = "left";
  system.defaults.dock.showhidden = true;

  system.defaults.finder.AppleShowAllExtensions = true;
  system.defaults.NSGlobalDomain.NSTableViewDefaultSizeMode = 2;
  system.defaults.finder.QuitMenuItem = true;
  system.defaults.finder.FXEnableExtensionChangeWarning = false;
  system.defaults.finder.FXPreferredViewStyle = "Nlsv";
  system.defaults.finder._FXShowPosixPathInTitle = true;

  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToControl = true;

  # Fonts
  fonts.fontDir.enable = true;
  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" "FiraCode" "DroidSansMono" ]; })
  ];

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; cliPackages ++ devPackages ++ rustDevPackages ++ [mpv] ;

  # Brew managed by Nix :D
  homebrew.enable = true;
  homebrew.taps = [
    "redis-stack/redis-stack"
  ];
  homebrew.casks = [
    "alacritty"
    "alt-tab"
    "darktable"
    "firefox"
    "inso" # Insomnia client
    "flameshot"
    "raycast"
    "sonixd"
    "spotify"
    "redis-stack"
  ];

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true; # default shell on catalina

  # TODO The next lines are copy-pasted and not used atm
  # Home manager import
  imports = [ <home-manager/nix-darwin> ];

  programs.zsh.variables.cfg = "$HOME/.config/nixpkgs/darwin/configuration.nix";
  programs.zsh.variables.darwin = "$HOME/.nix-defexpr/darwin";
  programs.zsh.variables.nixpkgs = "$HOME/.nix-defexpr/nixpkgs";

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  # Allow unfree packages (surrealdb)
  nixpkgs.config.allowUnfree = true;
}
