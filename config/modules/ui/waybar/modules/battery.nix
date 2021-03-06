{ colors }:

{
  name = "battery";

  config = {
    states = {
      warning = 15;
      critical = 5;
    };
    format = "{icon} ▼ {capacity}%";
    format-charging = " ▲ {capacity}%";
    format-plugged = " {capacity}%";
    format-alt = "{icon} {time}";
    format-icons = [ "" "" "" "" "" ];
  };

  style.".warning".color = colors.warn;
  style.".critical" = {
    background-color = colors.urgent;
    color = colors.white;
  };
  style.".critical:not(.charging)" = {
    animation-name = "blink";
    animation-duration = "0.5s";
    animation-timing-function = "linear";
    animation-iteration-count = "infinite";
    animation-direction = "alternate";
  };
}
