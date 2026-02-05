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
    # You also need to set Steam Launch Options for DBD to:
    # WINEDLLOVERRIDES="d3d12=n,b;d3dcompiler_47=n" %command%

    environment.systemPackages = with pkgs; [
      mangohud
    ];

    programs.gamemode.enable = true;

    programs.steam = {
      enable = true;
      protontricks.enable = true;
      extraCompatPackages = with pkgs; [
        proton-ge-bin
        # protontricks
      ];
    };
  };
}
