{ config, pkgs, ... }: let
  username = "subha";
in {

  imports = [
  ];

  home.username = "subha";
  home.homeDirectory = "/home/subha";
  home.stateVersion = "24.05"; # Please read the comment before changing.

  gtk = {
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };
  qt = {
    enable = true;
    style.name = "adwaita-dark";
    platformTheme.name = "gtk3";
  };

  home.packages = with pkgs; [
  ];
  home.file = {
  };
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  programs.home-manager.enable = true;
}
