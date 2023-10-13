{ config, pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
	      modules-left = [ "sway/workspaces" ];
	      modules-right = [
          "tray"
          "wireplumber"
          "bluetooth"
          "sway/language"
          "network"
          "backlight"
          "battery"
          "clock"
	      ];

        "sway/workspaces" = {
          format = "{icon}";
          format-icons = {
            "1" = "󰋜";
            "2" = "󰖟";
            "3" = "󰠮";
            "4" = "󰭹";
            "5" = "󱓷";
            "6" = "󱇧";
            "7" = "󰊢";
            "8" = "󰖲";
            "9" = "󰕧";
            "10" = "󰝚";
          };
          persistent_workspaces = {
            "1" = [];
            "2" = [];
            "3" = [];
            "4" = [];
            "5" = [];
            "6" = [];
            "7" = [];
            "8" = [];
            "9" = [];
            "10" = [];
          };
	      };
      };
    };
    style = ''
      * {
        font-family: JetBrainsMono Nerd Font;
	      font-size: 14px;
      }

      window#waybar {
        background: transparent;
        background: #3b4252;
      }

      #workspaces {
        background-color: #4c566a;
        margin: 5px;
        margin-left: 10px;
        border-radius: 5px;
      }
      #workspaces button {
          padding: 0 10px;
          color: #eceff4;
      }

      #workspaces button.focused {
          color: #2e3440;
          background-color: #88c0d0;
          border-radius: 5px;
      }

      #workspaces button:hover {
        background-color: #5e81ac;
        border-radius: 5px;
      }

      #clock, #battery, #wireplumber, #network, #backlight, #language, #bluetooth {
        background-color: #4c566a;
        padding: 0px 10px;
        margin: 5px 0px;
      }

      #clock {
          color: #b48ead;
          border-radius: 0px 5px 5px 0px;
          margin-right: 10px;
      }

      #battery {
          color: #a3be8c;
      }

      @keyframes blink {
          to {
              background-color: #ffffff;
              color: black;
          }
      }

      #battery.charging {
          color: #a3be8c;
      }

      #battery.critical:not(.charging) {
          background-color: #f53c3c;
          color: #ffffff;
          animation-name: blink;
          animation-duration: 0.5s;
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
      }

      #network {
        color: #d08770;
      }

      #wireplumber {
        color: #ebcb8b;
        border-radius: 5px 0px 0px 5px;
      }
    '';
  };
}
