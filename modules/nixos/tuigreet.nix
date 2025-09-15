{ pkgs, successfulLoginCommand, defaultTheme ? false }:

let
  # Use theme if set
  theming = if defaultTheme then "" else "--theme text=white;container=black;border=grey;prompt=green;input=white;action=white;button=yellow";
in
{
  # tuigreet
  services.greetd = {
    enable = true;
    restart = true;
    settings = {
      initial_session = {
        command = "${successfulLoginCommand}";
        user = "haydn";
      };
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --user-menu --time --asterisks --cmd ${successfulLoginCommand} ${theming}";
        user = "haydn";
      };
    };
  };

  # Stop systemd screen littering
  # From https://github.com/sjcobb2022/nixos-config/blob/main/hosts/common/optional/greetd.nix
  systemd.services.greetd.serviceConfig = {
    Type = "idle";
    StandardInput = "tty";
    StandardOutput = "tty";
    StandardError = "journal"; # Without this errors will spam on screen
    # Without these bootlogs will spam on screen
    TTYReset = true;
    TTYVHangup = true;
    TTYVTDisallocate = true;
  };
}
