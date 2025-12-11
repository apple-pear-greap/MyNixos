{ config, pkgs, ...}:
{
    imports = [
      ./homepkgs/zsh.nix
    ];

    home.username = "cerydra";
    home.homeDirectory = "/home/cerydra";
    home.stateVersion = "25.11";
    home.packages = with pkgs; [
      fastfetch
      vscode
      chromium
      bat 
      splayer
      zsh-powerlevel10k
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
