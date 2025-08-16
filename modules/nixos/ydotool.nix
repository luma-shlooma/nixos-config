{ ... }:

{
  programs.ydotool = {
    group = "ydotool";
    enable = true;
  };

  users.users.haydn.extraGroups = [ "ydotool" ];
}

