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
    programs.kitty = {
      enable = true;
      theme = "Nord";
      font = {
	name = "JetBrains Mono";
	size = 14;
      };
      settings = {
	confirm_os_window_close = 0;
      };
    };
}
