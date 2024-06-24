{ pkgs, lib, config, ...} :
let
  # Linea-Nord theme provided by wpgtk, installed in a more nix-y way
  linearNordSrc = pkgs.fetchFromGitHub {
    owner = "deviantfero";
    repo = "wpgtk-templates";
    rev = "4119a9afb27acf9e231c211cdfd12992c318499e";
    hash = "sha256-LKIVasIO6ZjuRnY5NEj4NrtHchW8lafsnfh1IiEcoR0=";
  };
  gtkTheme = walEnable: pkgs.stdenvNoCC.mkDerivation {
    pname = "linea-nord theme";
    version = "0.1";

    src = linearNordSrc;
    propagatedUserEnvPkgs = [ pkgs.gtk-engine-murrine ];

    installPhase = ''
      runHook preInstall
      mkdir -p $out/share/themes/linea-nord-color

      ${
        # Look for gtk theme in wpgtk config instead
        if walEnable then ''
          rm ./linea-nord-color/general/dark.css
          printf "@import url(\"gtk-version.css\");
          @import url(\"../general/gtk-colors.css\");
          @import url(\"../general/widgets.css\");
          @import url(\"../general/titlebar.css\");
          @import url(\"file:///home/zeroth/.config/wpg/templates/gtk.css\");" > ./linea-nord-color/general/dark.css

          # Remove now invalid imports
          cp ./linea-nord-color/dark.css.base ./tmp.css
          tail -n +7 ./tmp.css > ./linea-nord-color/dark.css.base
          rm ./tmp.css
        ''
        # Delete the unneeded .base file
        else
          "rm ./linea-nord-color/dark.css.base"
      }

      # Copy content to destination
      cp -r ./linea-nord-color/* $out/share/themes/linea-nord-color/

      runHook postInstall
    '';

    passthru.updateScript = pkgs.unstableGitUpdater {
      tagPrefix = "v";
    };
  };
in
{
  options.wal = { enable = lib.mkEnableOption "wal"; };
  config = let theme = gtkTheme config.wal.enable; in
    lib.mkMerge [
    (lib.mkIf config.wal.enable
      {
        home.packages = with pkgs; [
          wpgtk
          xsettingsd
        ];

        home.file.".config/wpg/templates/gtk.css.base".source = theme + "/share/themes/linea-nord-color/dark.css.base";
        home.file.".config/wpg/wpg.conf".text = ''
          [settings]
            set_wallpaper = false
            gtk = true
            active = 0
            light_theme = false
            editor = nvim
            execute_cmd = false
            command =
            backend = wal
            alpha = 100
            smart_sort = true
            auto_adjust = true
        '';
      }
    )
    {
      gtk = {
        theme.name = "linea-nord-color";
        theme.package = theme;
      };
    }
  ];
}
