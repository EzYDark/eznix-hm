{
  options,
  config,
  pkgs,
  lib,
  namespace,
  inputs,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.programs.spotify;
in {
  options.${namespace}.programs.spotify = with types; {
    enable = mkBoolOpt false "Whether or not to enable Spotify player.";
  };

  config = mkIf cfg.enable {
  
    programs.spicetify =
      let
        spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
      in
      {
        enable = true;
        enabledExtensions = with spicePkgs.extensions; [
          adblock
          hidePodcasts
          shuffle
          groupSession
          trashbin
          popupLyrics
          fullAppDisplay
          autoSkipVideo
          powerBar
          skipStats
          featureShuffle
          showQueueDuration
          history
          betterGenres
          savePlaylists
          volumePercentage
          addToQueueTop
          autoSkip
          sectionMarker
          beautifulLyrics
        ];
        theme = spicePkgs.themes.text;
        enabledCustomApps = with spicePkgs.apps; [
          reddit
        ];
      };

  };
}