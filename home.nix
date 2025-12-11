{ config, pkgs, ...}:
{
    home.username = "cerydra";
    home.homeDirectory = "/home/cerydra";
    home.stateVersion = "25.11";
    programs.bash = {
      enable = true;
      shellAliases = {
        btw = "echo I use Nixos, btw";
    };
  };
}
