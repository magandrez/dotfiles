# set PATH so it includes stuff from .local/bin (python stuff etc)
if [ -d "$HOME/.local/bin" ]; then
    PATH="$HOME/.local/bin:$PATH"
fi

export EDITOR=~/.local/bin/et
export VISUAL=~/.local/bin/em
export TERMINAL=~/.local/bin/st
export TERM=st-256color
export SHELL=/bin/fish

systemctl --user import-environment DISPLAY PATH EDITOR VISUAL TERMINAL TERM SHELL
