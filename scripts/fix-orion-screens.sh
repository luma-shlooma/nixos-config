#! /usr/bin/env nix-shell
#! nix-shell -i bash -p bash

LAPTOP="Chimei Innolux Corporation 0x143C Unknown"
LEFT="BNQ BenQ EW3270U VAR00152019"
RIGHT="BNQ BenQ EW3270U VAR00148019"

# LAPTOP_MODE="1920x1200@60.003Hz"
BENQ_MODE="2560x1440@59.951Hz"

get() {
  /etc/nixos/scripts/get-monitor.sh "$1"
}

dp_laptop="$(get "$LAPTOP")"
dp_left="$(get "$LEFT")"
dp_right="$(get "$RIGHT")"


swaymsg output "$dp_laptop" pos 1600 1440
swaymsg output "$dp_left" mode "$BENQ_MODE" pos 0 0
swaymsg output "$dp_right" mode "$BENQ_MODE" pos 2560 0

swaymsg workspace 1; swaymsg move workspace to output "$dp_laptop"
swaymsg workspace 2; swaymsg move workspace to output "$dp_left"
swaymsg workspace 3; swaymsg move workspace to output "$dp_right"
swaymsg workspace 1;
