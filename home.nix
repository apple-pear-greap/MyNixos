{ config, pkgs, ...}:
{
    home.username = "cerydra";
    home.homeDirectory = "/home/cerydra";
    home.stateVersion = "25.11";
    home.packages = with pkgs; [
      fastfetch
      vscode
      chromium
      bat 
      splayer
    ];
    
    imports = [
      ./homepkgs/zsh.nix
    ];

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
