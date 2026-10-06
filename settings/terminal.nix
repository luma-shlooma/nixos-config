{ config, lib, ... }:
with lib;
let
  # The config option(s) this introduces
  cfg = config.settings.terminal;
in
{
  # New options to be used between modules
  options.settings.terminal = {
    app = {
      selected = mkOption {
        type = types.enum [ "alacritty" ];
        default = "alacritty";
        description = "The prefered terminal. The strings match executable names.";
      };
      package = mkOption {
        type = types.package;
        description = "The package corresponding to the selected terminal application.";
      };
      launch = mkOption {
        type = types.str;
        description = "Command to run the terminal application. Generated using supplied settings.";
      };
    };
    shell = {
      selected = mkOption {
        type = types.enum [ "bash" "zsh" ];
        default = "bash";
        description = "The prefered shell. The strings match executable names.";
      };
      package = mkOption {
        type = types.package;
        description = "The package corresponding to the selected terminal shell.";
      };
      launch = mkOption {
        type = types.str;
        description = "Command to run the shell application. Generated using supplied settings.";
      };
    };
  }; 

  # Enable corresponding modules if preferred
  # Terminals
  config.modules.alacritty.enable = mkIf (cfg.app.selected == "alacritty") true;
  # Shells
  # NOTE: bash always enabled
  config.modules.zsh.enable = mkIf (cfg.shell.selected == "zsh") true;

  # Generate run commands
  config.settings.terminal.app.launch = "${cfg.app.package}/bin/${cfg.app.selected}";
  config.settings.terminal.shell.launch = "${cfg.shell.package}/bin/${cfg.shell.selected}";
}
