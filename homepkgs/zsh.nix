{ config, pkgs, ...}:
{
      programs.zsh = {
      enable = true;

       enableCompletion = true;
       syntaxHighlighting.enable = true;
       autosuggestion.enable = true;

      shellAliases = {
        ll = "ls -alF";
        la = "ls -A";
        l = "ls -CF";
        gs = "git status";
	nsr = "sudo nixos-rebuild switch";
      };

      history = {
        size = 10000;
        save = 10000;
        path = "${config.xdg.dataHome}/zsh/history";
      };

      initContent = ''
        setopt interactive_comments
        setopt share_history
        setopt hist_ignore_dups
        setopt extended_glob

        autoload -Uz compinit
        compinit -u

        source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
        if [[ -r ~/.p10k.zsh ]]; then
        source ~/.p10k.zsh
        fi
      '';
    };
  }
