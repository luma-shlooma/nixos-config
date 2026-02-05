{ ... }:

# TODO: use configured options instead
{
  # Start noctalia
  programs.niri.settings.spawn-at-startup = [
    { argv = [ "noctalia-shell" ]; }
  ];
}
