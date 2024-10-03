# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/amber/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Import colorscheme from 'wal' asynchronously
# &   # Run the process in the background.
# ( ) # Hide shell job control messages.
# Not supported in the "fish" shell.
# (cat ~/.cache/wal/sequences &)

# Alternative (blocks terminal for 0-3ms)
# cat ~/.cache/wal/sequences

# To add support for TTYs this line can be optionally added.
source ~/.cache/wal/colors-tty.sh

# Enable syntax highlighting and autosuggestions
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Bind Tab to accept next token of autosuggestion
bindkey '\t' forward-word

eval "$(starship init zsh)"

# Created by `pipx` on 2024-06-01 17:52:50
export PATH="$PATH:/home/amber/.local/bin"

# Start with hyfetch in Kitty windows (i.e., not VSCode)
if [[ $TERM == "xterm-kitty" ]]; then
    hyfetch --ascii-file ~/.config/arch-dots
else
    :
fi
