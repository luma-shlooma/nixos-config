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
      run = mkOption {
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
      run = mkOption {
        type = types.str;
        description = "Command to run the shell application. Generated using supplied settings.";
      };
    };
  }; 

  # Enable corresponding modules if preferred
  # Terminals
  config.modules.alacritty = mkIf (cfg.app.selected == "alacritty") { enable = true; };
  # Shells
  # NOTE: bash always enabled
  config.modules.zsh = mkIf (cfg.shell.selected == "zsh") { enable = true; };

  # Generate run commands
  config.settings.terminal.app.run = "${cfg.app.package}/bin/${cfg.app.selected}";
  config.settings.terminal.shell.run = "${cfg.shell.package}/bin/${cfg.shell.selected}";
}
