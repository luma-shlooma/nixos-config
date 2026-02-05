{ ... }:

{
  # The following were originally required by noctalia

  # Allow power management support in apps
  services.upower.enable = true;
  # Allow system changes based on configured power profiles
  services.power-profiles-daemon.enable = true;
}
