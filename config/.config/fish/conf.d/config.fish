# XDG folders
set -x XDG_CONFIG_HOME $HOME/.config
set -x XDG_DATA_HOME $HOME/.local/share
set -x XDG_CACHE_HOME $HOME/.cache
# Random env variables
set -gx SHELL /usr/bin/fish
set -gx EDITOR ~/.local/bin/et
set -gx GOPATH ~/workbench/go
set -gx DOCKER_BUILDKIT 1
set -gx DOCKER_HOST unix:///run/user/1000/docker.sock
set -gx SSH_AUTH_SOCK "$XDG_RUNTIME_DIR/ssh-agent.socket"
set -gx RIPGREP_CONFIG_PATH ~/.config/.ripgreprc
set -gx ASDF_DATA_DIR $HOME/.local/share/asdf
contains $HOME/.local/bin $fish_user_paths; or set -Ua fish_user_paths $HOME/.local/bin
contains /usr/local/go/bin $fish_user_paths; or set -Ua fish_user_paths /usr/local/go/bin
contains ~/workbench/go/bin $fish_user_paths; or set -Ua fish_user_paths ~/workbench/go/bin
contains /usr/local/pulumi/bin $fish_user_paths; or set -Ua fish_user_paths /usr/local/pulumi/bin
# cd -
abbr -a -- - 'cd -'

# Theme related
set -g theme_display_date no
set -g theme_display_cmd_duration no
set -g fish_term24bit 1
set -g theme_powerline_fonts no
set -g theme_nerd_fonts no

# Direnv
direnv hook fish | source
set -g direnv_fish_mode eval_on_arrow # trigger direnv at prompt, and on every arrow-based directory change (default)

# Alias
alias bat=/usr/bin/batcat
