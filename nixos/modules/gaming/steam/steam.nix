{
  config,
  pkgs,
  lib,
  default,
  ...
}:
with lib;
with lib.zenyte; let
  cfg = config.zenyte.gaming.steam;
in {
  options.zenyte.gaming.steam = {
    enable = mkBoolOpt false "Whether to enable steam.";
  };

  config = mkIf cfg.enable {
    # How to enable Reshade for DBD
    # Follow https://www.reddit.com/r/deadbydaylight/comments/1i9ghol/tutorial_installing_reshade_for_dbd_on_linux/
    # Do NOT rename d3d11.dll to anything other than dxgi.dll
    # Update d3dcompiler_47 for Dead by Daylight to work with reshade:
    # protontricks 381210 d3dcompiler_47
    # You also MIGHT need to set Steam Launch Options for DBD to:
    # WINEDLLOVERRIDES="d3d12=n,b;d3dcompiler_47=n" %command%

    # Dead by Daylight launch options:
    # ENABLE_GAMESCOPE_WSI=0 PROTON_NO_ESYNC=1 PROTON_NO_FSYNC=1 PROTON_NVIDIA_LIBS_NO_32BIT=1 DXVK_ASYNC=1 gamemoderun %command% -dx11

    environment.systemPackages = with pkgs; [
      adwsteamgtk
    ];

    programs.steam = {
      enable = true;
      protontricks.enable = true;
      package = pkgs.steam.override {
        extraPkgs = pkgs:
          with pkgs; [
            gamemode
            mangohud
          ];
      };
      extraCompatPackages = with pkgs; [
        proton-ge-bin
        # protontricks
      ];
    };
  };
}
