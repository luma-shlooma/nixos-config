{ ... }:

{
  # Set as launcher in config
  apps.launcher = {
    name = "walker";
    launch = "walker";
    dmenu = opts: prompt: "echo -e \"${opts}\" | walker --dmenu";
  };
}
