{ pkgs, ... }:

{
  # Set udev rules
  hardware.logitech.wireless.enable = true;

  # Install
  environment.systemPackages = [ pkgs.logiops ];
  
  # Systemd unit for logiops
  systemd.services.logid = {
    description = "Logitech Configuration Daemon";
    after = [ "multi-user.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.logiops}/bin/logid";
      # Wait delay after initial system startup, then check for "device found" success message.
      ExecStartPost = pkgs.writeShellScript "check-logid-init" ''
        sleep 5
        if ! ${pkgs.systemd}/bin/journalctl -u logid --since "10 seconds ago" | grep -q "Device found: MX Master 4"; then
          echo "Mouse not detected in logs, triggering restart..."
          exit 1
        fi
      '';
      Restart = "on-failure";
      RestartSec = "5s";
      StartLimitIntervalSec = 0;
    };
  };

  # Config file
  environment.etc."logid.cfg".text = ''
  devices: ({
      name: "MX Master 4";
      thumbwheel: {
        invert: true;
      };
      buttons: (
          {
              # Front-most button
              cid: 0x00c3;
              action =
              {
                  type: "Keypress";
                  keys: ["KEY_KPENTER"];
              };
          },
          {
              # Thumb-pad button
              cid: 0x01a0;
              action =
              {
                  type: "Gestures";
                  gestures: (
                      {
                          direction: "Up";
                          mode: "OnInterval";
                          interval: 20;
                          action =
                          {
                              type: "Keypress";
                              keys: ["KEY_VOLUMEUP"];
                          };
                      },
                      {
                          direction: "Down";
                          mode: "OnInterval";
                          interval: 20;
                          action =
                          {
                              type: "Keypress";
                              keys: ["KEY_VOLUMEDOWN"];
                          };
                      },
                      {
                          # Discord mute
                          direction: "Left";
                          mode: "OnRelease";
                          interval: 40;
                          action =
                          {
                              type: "Keypress";
                              keys: ["KEY_LEFTCTRL", "KEY_LEFTSHIFT", "KEY_M"];
                          };
                      },
                      {
                          # Discord deafen
                          direction: "Right";
                          mode: "OnRelease";
                          interval: 40;
                          action =
                          {
                              type: "Keypress";
                              keys: ["KEY_LEFTCTRL", "KEY_LEFTSHIFT", "KEY_D"];
                          };
                      },
                      # I cannot seem to get this to work - mapping a regular button press with no movement
                      {
                          direction: "None"
                          action:
                          {
                              type: "None";
                          };
                      }
                  );
              };
          },
      );
  });
  '';
}
