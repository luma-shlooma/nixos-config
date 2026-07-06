{ inputs, pkgs, session ? "", monitor ? "", ... }:

let
  # Session value must be provided
  getSession = if session == "noctalia-greeter session must be set" then throw "" else session;
in
{
  imports = [
    inputs.noctalia-greeter.nixosModules.default
  ];

  programs.noctalia-greeter = {
    enable = true;

    # Optional configuration
    greeter-args = "";
    settings = {
      session.default = "${getSession}";
      user.default = "haydn";
      output.name = "${monitor}";
      keyboard.layout = "gb";
      cursor = {
        theme = "phinger-cursors-light";
        package = pkgs.phinger-cursors;
      };
      appearance = {
        scheme = "Synced";
        hide_logo = true;
      };
    };
  };
}
