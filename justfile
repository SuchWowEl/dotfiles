# either 'nvim', 'hypr', 'tmux'
cp conf:
  # rsync -av --exclude '.git' ~/.config/{{conf}}/ ~/temp/external_{{conf}}/
  rsync -av --exclude '.git' ~/.config/{{conf}}/ ~/.local/share/chezmoi/dot_config/external_{{conf}}

rr-mark:
  chezmoi add ~/.local/share/ranger/bookmarks
