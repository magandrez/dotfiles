set -gx SHELL /usr/bin/fish
set -gx EDITOR ~/.local/bin/et
set -gx GOPATH ~/workbench/go
set -gx DOCKER_BUILDKIT 1
set -gx NVM_DIR /home/manuel/.nvm
contains /usr/local/go/bin $fish_user_paths; or set -Ua fish_user_paths /usr/local/go/bin
contains ~/workbench/go/bin $fish_user_paths; or set -Ua fish_user_paths ~/workbench/go/bin

# No greeting
set fish_greeting

# cd -
abbr -a -- - 'cd -'

# Theme related
set -g theme_display_date no
set -g theme_display_cmd_duration no
set -g fish_term24bit 1

# Alias
alias bat=/usr/bin/batcat