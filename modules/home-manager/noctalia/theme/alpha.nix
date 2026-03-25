# Controlled Theme
{ config, lib, ... }:

lib.mkIf (config.theme.name == "alpha")
{
  programs.noctalia.settings = {
    # Monochrome theme
    theme = {
      mode = "dark";
      source = "community";
      community_palette = "Monochrome";
    };

    # https://docs.noctalia.dev/v5/configuration/shell/
    shell = {
      ui_scale = 1.0;
      font_family = "JetBrainsMono Nerd Font Mono";
      time_format = "{:%H:%M}";
      date_format = "%A, %x";
      app_icon_colorize = true;
      app_icon_color = "on_surface";

      animation = {
        enabled = true;
        speed = 1.0;
      };

      shadow = {
        direction = "down";
        alpha = 0.55;
      };

      panel = {
        transparency_mode = "solid";
        borders = true;
        shadow = true;
        launcher_placement = "centered";
        clipboard_placement = "centered";
        control_center_placement = "attached";
        wallpaper_placement = "attached";
        session_placement = "attached";
      };

      screen_corners = {
        enabled = false;
        size = 32;
      };
    };
    
    # https://docs.noctalia.dev/v5/bar/
    bar = {
      main = {
        thickness = 34;
        background_opacity = 1.0;
        border = "outline";
        border_width = 0.0;
        shadow = true;
        contact_shadow = false;
        panel_overlap = 1;
        radius = 12;
        radius_top_left = 12;
        radius_top_right = 12;
        radius_bottom_left = 12;
        radius_bottom_right = 12;
        margin_ends = 180;
        margin_edge = 10;
        padding = 14;
        widget_spacing = 6;
        scale = 1.0;
        font_weight = "regular";

        capsule = false;
        capsule_fill = "surface_variant";
        capsule_radius = 8.0;
        capsule_opacity = 1.0;
      };
    };

    # https://docs.noctalia.dev/v5/bar/widgets/
    widget = {
      workspaces = {
        type = "workspaces";
        display = "none";
      };
      network = {
        type = "network";
        show_label = false;
      };
      audio_visualizer = {
        type = "audio_visualizer";
        width = 256;
        bands = 64;
      };
      media = {
        type = "media";
        min_length = 256;
        max_length = 512;
        hide_when_no_media = true;
      };
    };
    
    # https://docs.noctalia.dev/v5/desktop/widgets/
    desktop_widgets = {
      enabled = false;
    };

    # https://docs.noctalia.dev/v5/desktop/wallpaper/
    wallpaper = {
      enabled = false;
    };
  };
}
