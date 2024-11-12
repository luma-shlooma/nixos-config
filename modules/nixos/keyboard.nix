# Keyboard layout and mapping settings
{ ... }:

{
  # Import Kanata custom keyboard config
  imports = [
    ./kanata.nix
  ];
  
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "gb";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "uk";
}
