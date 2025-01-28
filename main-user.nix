{ lib, config, pkgs, ... }:

let
  cfg = config.main-user;
in
{
  options = {
    main-user.enable = lib.mkEnableOption "enable user module";

    main-user.userName = lib.mkOption {
      default = "mainuser";
      description = ''
        username
      '';
    };

    main-user.description = lib.mkOption {
      default = "main user";
      description = ''
        description
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    users.users.${cfg.userName} = {
      isNormalUser = true;
      description = "${cfg.description}";
      extraGroups = [ "networkmanager" "wheel" ];
      shell = pkgs.zsh;
    };
  };
}
