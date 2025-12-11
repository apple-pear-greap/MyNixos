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
      };

      history = {
        size = 10000;
        save = 10000;
        path = "${config.xdg.dataHome}/zsh/history";
      };

      initContent = ''
        setopt auto_cd
        setopt interactive_comments
        setopt share_history
        setopt hist_ignore_dups
        setopt hist_reduce_blanks
        setopt extended_glob

        autoload -Uz compinit
        compinit -u

      '';
    };
  }
