{ pkgs, lib, config, ... }:
with lib;
{
  programs.git = {
    enable = true;
    userName = "0thElement";
    userEmail = "quangquangtrung89@gmail.com";
    extraConfig = {
      init = { defaultBranch = "main"; };
      core = {
        excludesfile = "$NIXOS_CONFIG_DIR/scripts/gitignore";
      };
    };
  };

  programs.gh = {
    enable = true;
  };
}
