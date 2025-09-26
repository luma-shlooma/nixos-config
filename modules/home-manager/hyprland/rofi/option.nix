{ ... }:

{
  # Set as launcher in config
  apps.launcher = {
    name = "rofi";
    launch = "rofi -show drun -show-icons";
    dmenu = opts: prompt: "echo -e \"${opts}\" | rofi -dmenu -p \"${prompt}\"";
  };
}
