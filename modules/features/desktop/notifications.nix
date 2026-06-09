{ ... }:
{
  flake.modules.homeManager.notifications =
    { ... }:
    {
      services.mako = {
        enable = true;
        settings = {
          anchor = "top-right";
          background-color = "#2d353bff";
          text-color = "#d3c6aa";
          border-color = "#a7c080";
          border-radius = 12;
          border-size = 2;
          font = "Sans 11";
          height = 100;
          width = 400;
          margin = "15";
          padding = "5,15";
          max-visible = 5;
        };
      };
    };
}
