{ pkgs, lib, config, ... }:
with lib;
{
  imports = [ ./starship.nix ];

  home.packages = [
    pkgs.fish
    pkgs.pfetch-rs
    pkgs.eza
  ];

  home.sessionVariables = {
    PF_INFO = "ascii title os host kernel uptime memory";
    PF_CUSTOM_LOGOS = /home/zeroth/.config/pfetch_logos.sh;
    PF_FAST_PKG_COUNT = 1;
    PF_COL1 = 4;
  };

  home.file.".config/pfetch_logos.sh".source = ./pfetch_logos.sh;

  programs.fish = {
    enable = true;
    shellInit = ''
      fish_vi_key_bindings
      function fish_greeting
        pfetch
      end

      starship init fish | source

      function fish_right_prompt
	set_color '#555555'
	date '+%H:%M:%S'	
	set_color normal
      end
      funcsave -q fish_greeting

      ### COLOR
      set fish_color_normal white
      set fish_color_autosuggestion '#555555'
      set fish_color_command '#87d9ff'
      set fish_color_error '#ff6b6b'
      set fish_color_param white
      set fish_color_quote '#fffaa5'
      set fish_color_comment '#7d7d7d'
      set fish_color_cancel '#555555'
    '';
  
    shellAbbrs = {
      add = "git add";
      branch = "git branch";
      checkout = "git checkout";
      clone = "git clone";
      commit = "git commit -m";
      fetch = "git fetch";
      pull = "git pull origin";
      push = "git push origin";
      tag = "git tag";
      gs = "git status";
      newtag = "git tag -a";
    };

    shellAliases = {
      cl = "clear";
      clp = "clear && pfetch";
      vi = "nvim";
      
      #DIRECTORY
      la = "eza -la --color=always --group-directories-first";
      ll = "eza -l --color=always --group-directories-first";
      lt = "eza -aT --color=always --group-directories-first";
      #"l." = "eza -a | egrep \"^\.\"";
  
      #GREP
      grep = "grep --color=auto";
      egrep = "egrep --color=auto";
      fgrep = "fgrep --color=auto";
      
      #CONFIRM BEFORE OVERWRITING SOMETHING
      cp = "cp -i";
      mv = "mv -i";
      rm = "rm -i";
      
      #MKDIR
      mkdir = "mkdir -pv";
      
      #CONFIG
      toconf = "cd /etc/nixos/";
    };
  };

  # Switch to fish from bash
  programs.bash = {
    initExtra = ''
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
      then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi
  '';
};
}