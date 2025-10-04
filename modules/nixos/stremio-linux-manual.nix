# FAILED ATTEMPT AT BUILDING FROM SOURCE
# https://github.com/Stremio/stremio-linux-shell
args @ { pkgs, ... }:

let
  cef = pkgs.stdenv.mkDerivation {
    pname = "cef-minimal";
    version = "137.0.19";

    src = pkgs.fetchurl {
      url = "https://cef-builds.spotifycdn.com/cef_binary_137.0.19+g8a1c4ce+chromium-137.0.7151.121_linux64_minimal.tar.bz2";
      sha256 = "sha256-JM4vebBONxKoF+BEM25InWztQcwB6b7b11Scgb/my04=";
    };

    nativeBuildInputs = [ pkgs.bzip2 pkgs.findutils ];

    installPhase = ''
      mkdir tmp
      tar -xjf $src -C tmp
      mkdir -p $out/locales
      find tmp -path "*/Resources/locales/*" -exec cp {} $out/locales/ \;
      find tmp -path "*/Resources/*.pak" -exec cp -t $out/ {} +
      find tmp -path "*/Resources/icudtl.dat" -exec cp -t $out/ {} +
      find tmp -path "*/Release/libcef.so" -exec cp -t $out/ {} +
      find tmp -path "*/Release/libEGL.so" -exec cp -t $out/ {} +
      find tmp -path "*/Release/libGLESv2.so" -exec cp -t $out/ {} +
      find tmp -path "*/Release/libvk_swiftshader.so" -exec cp -t $out/ {} +
      find tmp -path "*/Release/v8_context_snapshot.bin" -exec cp -t $out/ {} +
    '';
  };

  stremio-linux-shell = pkgs.rustPlatform.buildRustPackage {
    pname = "stremio-linux-shell";
    version = "1.0.0-beta.11";

    src = pkgs.fetchFromGitHub {
      owner = "Stremio";
      repo = "stremio-linux-shell";
      rev = "v1.0.0-beta.11";
      sha256 = "sha256-FNAeur5esDqBoYlmjUO6jdi1eC83ynbLxbjH07QZ++E=";
    };

    cargoHash = "sha256-9/28BCG51jPnKXbbzzNp7KQLMkLEugFQfwszRR9kmUw=";

    cargoFeatures = [ "offline-build" ];
    
    nativeBuildInputs = with pkgs; [
      pkg-config
      which
      perl
    ];
    buildInputs = with pkgs; [
      openssl
      cairo
      pango
      glib
      gtk3
      mpv
      cef
      xorg.libX11
      libxkbcommon
      xorg.libXrandr
      xorg.libXfixes
      xorg.libXcursor
      xorg.libXdamage
      xorg.libXcomposite
      xorg.libXtst
      xorg.libXScrnSaver
      cups
      alsa-lib
      libxcb
      nss
      dbus
      mesa
      at-spi2-atk
      libdrm
    ];

    env = {
      "CEF_PATH" = "${cef}";
    };

    patchPhase = ''
      perl -i -0777 -pe 's/println!\\s*\\(\\s*\"cargo:rustc-env=LD_LIBRARY_PATH=.*?\"[\\s\\S]*?\\);\\s*//g' build.rs
    '';

  };
in
{
  # UNFINISHED
  assertions =
  let
    assertLib = import ../../lib/assertions ({module = "nixos/stremio-ng";}//args);
  in
  [ assertLib.unfinished ];

  environment.systemPackages = [ stremio-linux-shell ];
}
