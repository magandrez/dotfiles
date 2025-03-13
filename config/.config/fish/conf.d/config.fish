set -gx SHELL /usr/bin/fish
set -gx EDITOR ~/.local/bin/et
set -gx GOPATH ~/workbench/go
set -gx DOCKER_BUILDKIT 1
set -gx SSH_AUTH_SOCK "$XDG_RUNTIME_DIR/ssh-agent.socket"
contains /usr/local/go/bin $fish_user_paths; or set -Ua fish_user_paths /usr/local/go/bin
contains ~/workbench/go/bin $fish_user_paths; or set -Ua fish_user_paths ~/workbench/go/bin
contains ~/.pulumi/bin $fish_user_paths; or set -Ua fish_user_paths ~/.pulumi/bin
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
