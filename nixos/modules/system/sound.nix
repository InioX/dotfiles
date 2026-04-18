{
  config,
  pkgs,
  lib,
  default,
  ...
}:
with lib;
with lib.zenyte; let
  cfg = config.zenyte.system.sound;
in {
  options.zenyte.system.sound = {
    enable = mkBoolOpt false "Whether to enable sound.";
  };

  config = mkIf cfg.enable {
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;

    environment.systemPackages = with pkgs; [
      alsa-utils
      easyeffects
      # helvum
      # pavucontrol
      pwvucontrol
    ];

    boot.extraModprobeConfig = ''
      options snd_hda_intel power_save=0
      options snd_acp3x_pdm_dma power_save=0
    '';

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
      jack.enable = true;
      extraConfig.pipewire = {
        "10-low-latency.conf" = {
          "context.properties" = {
            "default.frags" = 16;
            "default.frag-size" = 1024;
          };
        };
        "10-max-buffers" = {
          "context.properties" = {
            "link.max-buffers" = 128;
            "mem.allow-mlock" = true;
            "mem.mlock-all" = false;
          };
        };
        "11-clock-rates" = {
          "context-properties" = {
            "default.clock.rate" = 48000;
            "default.clock.allowed-rates" = [
              44100
              88200
              176400
              48000
              96000
              192000
            ];
            "default.clock.quantum" = 1024;
            "default.clock.min-quantum" = 256;
            "default.clock.max-quantum" = 8192;
          };
        };
      };

      wireplumber.extraConfig = lib.mkMerge [
        {
          # Low latency for gaming
          "53-gaming-low-latency" = {
            "monitor.alsa.rules" = [
              {
                matches = [
                  {"application.process.binary" = "~.*wine.*";}
                  {"application.process.binary" = "~.*proton.*";}
                  {"application.name" = "~.*\\.exe";}
                  {"application.name" = "~.*steam_app.*";}
                  {"application.name" = "~.*pressure-vessel.*";}
                  {"application.process.binary" = "~.*reaper.*";}
                  {"application.name" = "~.*World of Warcraft.*";}
                  {"application.name" = "~.*Diablo.*";}
                  {"application.name" = "~.*Overwatch.*";}
                  {"application.name" = "~.*Counter-Strike.*";}
                  {"application.name" = "~.*cs2.*";}
                  {"application.name" = "~.*Dota.*";}
                  {"application.name" = "~.*Apex.*";}
                  {"application.name" = "~.*Fortnite.*";}
                  {"application.name" = "~.*Unity.*";}
                  {"application.name" = "~.*UnrealEngine.*";}
                  {"application.name" = "~.*gameoverlayui.*";}
                  {"application.process.binary" = "~.*retroarch.*";}
                  {"application.process.binary" = "~.*dolphin-emu.*";}
                  {"application.process.binary" = "~.*pcsx2.*";}
                  {"application.process.binary" = "~.*rpcs3.*";}
                  {"application.process.binary" = "~.*yuzu.*";}
                  {"application.process.binary" = "~.*cemu.*";}
                  {"application.process.binary" = "~.*ryujinx.*";}
                ];
                actions = {
                  update-props = {
                    "node.latency" = "1024/48000";
                    "api.alsa.period-size" = 1024;
                    "api.alsa.headroom" = 4096;
                    "resample.quality" = 4;
                  };
                };
              }
            ];
          };
          # Optimizes VOIP applications
          "54-voip-optimize" = {
            "monitor.alsa.rules" = [
              {
                matches = [
                  {"application.process.binary" = "~.*vesktop.*";}
                  {"application.process.binary" = "~.*discord.*";}
                  {"application.process.binary" = "~.*Discord.*";}
                  {"application.name" = "~.*Vesktop.*";}
                  {"application.name" = "~.*Discord.*";}
                  {"application.process.binary" = "~.*teamspeak.*";}
                  {"application.process.binary" = "~.*mumble.*";}
                  {"application.process.binary" = "~.*slack.*";}
                ];
                actions = {
                  update-props = {
                    "node.latency" = "1024/48000";
                    "api.alsa.period-size" = 1024;
                    "api.alsa.headroom" = 4096;
                    "resample.quality" = 4;
                  };
                };
              }
            ];
          };
        }
      ];
      # extraConfig.pipewire."context.properties" = {
      #   default.clock.rate = 48000;
      #   default.clock.allowed-rates = [44100 48000 96000];
      #   default.clock.quantum = 1024;
      #   default.clock.min-quantum = 512;
      #   default.clock.max-quantum = 2048;
      # };
    };
  };
}
