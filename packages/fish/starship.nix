{ pkgs, ... }:
{
  home.packages = [
    pkgs.starship
  ];

  programs.starship = {
    enable = true;
    settings = {
      format = "[┌──](bold green)$all";
      right_format = "$time";

      # Wait 10 milliseconds for starship to check files under the current directory.
      scan_timeout = 10;
      
      character = {
        success_symbol = "[└>](bold green)";
        error_symbol = "[└>](bold red)" ;
        vicmd_symbol = "[└>](bold yellow)" ;
      };
      
      username = {
        style_user = "white";
        style_root = "black bold";
        format = "[\\[](bold green)[$user]($style)[\\]](bold green) ";
        disabled = false;
        show_always = true;
      }; 

      cmd_duration = {
        min_time = 500;
        format = "took [$duration](bold yellow)";
      };

      directory = {
        format = "[$path]($style)[$read_only]($read_only_style) ";
        style = "bold blue";
        read_only = "🔒";
        read_only_style = "red";
      };

      time = {
        disabled = false;
        format = "[$time]($style)";
        style = "fg:#555555";
        time_format = "%T";
      };
        
      git_branch = {
        format = "on [$symbol $branch ]($style)";
        symbol = " ";
        style = "bold purple";
      };

      git_commit = {
        #format = "[\\($hash\\)]($style) [\\($tag\\)]($style)";
        style = "bold green";
      };

      git_status = {
        format ="([\\[$all_status$ahead_behind\\]]($style))";
        conflicted = "=";
        ahead =	"⇡\${count} ";
        behind = "⇣\${count} ";
        diverged = "⇕⇡\${ahead_count}⇣\${behind_count}";
        untracked = "?\${count} ";
        stashed = "$\${count} ";
        modified = "!\${count} ";
        staged = "+\${count} ";
        renamed = "»\${count} ";
        deleted = "✘\${count} ";
        style =	"bold red";
        disabled = false;
      };

      git_state = {
        rebase = "REBASING";
        merge =	"MERGING";
        revert = "REVERTING";
        cherry_pick = "CHERRY-PICKING";
        bisect = "BISECTING";
        am = "AM";
        am_or_rebase = "AM/REBASE";
        style =	"bold yellow";
        format = "\\([$state( $progress_current/$progress_total)]($style)\\) ";
        disabled = false;
      };

      hg_branch = {
        symbol = " ";
        style =	"bold purple";
        format = "on [$symbol$branch]($style) ";
      };

      memory_usage = {
        format = "via $symbol [\${ram}( | \${ram_pct})]($style)";
        symbol = " ";
        style = "bold dimmed green";
      };

      nodejs = {
        format = "via [$symbol$version]($style) ";
        symbol = "⬢ ";
        style = "bold green";
        disabled = false;
        not_capable_style = "bold red";
      };

      status = {
        format = "[$symbol$status]($style)";
        symbol = "✖";
        style = "bold red";
        disabled = true;
      };

      
      docker_context = {
        symbol = " ";
      };

      conda = {
        symbol = " ";
      };

      package = {
        symbol = " ";
      };

      python = {
        symbol = " ";
      };
    };
  };
}
