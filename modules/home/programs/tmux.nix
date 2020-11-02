{ pkgs
, ...
}:
{
  programs.tmux = {
    enable = true;

    keyMode = "vi";

    plugins = with pkgs.tmuxPlugins; [
      sensible
      yank
      pain-control
      {
        plugin = gruvbox;
        extraConfig = "set -g @tmux-gruvbox 'dark'";
      }
    ];

    extraConfig = let
      statusBarConfig = ''
        set-option -g status-position top

        set  -g status-justify "centre"
        set  -g status "on"
        set  -g status-left-style "none"
        set  -g message-command-style "fg=colour246,bg=colour239"
        set  -g status-right-style "none"
        set  -g pane-active-border-style "fg=colour246"
        set  -g status-style "none,bg=colour237"
        set  -g message-style "fg=colour246,bg=colour239"
        set  -g pane-border-style "fg=colour239"
        set  -g status-right-length "100"
        set  -g status-left-length "100"
        setw -g window-status-activity-style "none"
        setw -g window-status-separator " "
        setw -g window-status-style "none,fg=colour246,bg=colour237"
        set  -g status-left "#[fg=colour235,bg=colour246,bold] #S #[fg=colour246,bg=colour237,nobold,nounderscore,noitalics]#[fg=colour246,bg=colour237] %H:%M "
        set  -g status-right "#[fg=colour246,bg=colour237] %d %b #[fg=colour246,bg=colour237,nobold,nounderscore,noitalics]#[fg=colour235,bg=colour246] #h "
        setw -g window-status-format "#[fg=colour246,bg=colour237] #I | #W "
        setw -g window-status-current-format "#[fg=colour237,bg=colour239,nobold,nounderscore,noitalics]#[fg=colour246,bg=colour239] #I | #W | #P #[fg=colour237,bg=colour239,nobold,nounderscore,noitalics]"
      '';
    in ''
      ${statusBarConfig}
    '';
  };
}
