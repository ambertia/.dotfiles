# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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

# Custom aliases
# Change directory and list contents
cl() {
    cd $1 && ls -Al
}
# From the internet - search manpages for a term
fman() {
    man $1 | grep -irn $2 -
}
gits() {
    git status
}
gd() {
    git diff $@
}
# Gitmoji alias
gm() {
    gitmoji commit
}
# Commit alias
gc() {
    git commit $@
}

source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
# eval "$(starship init zsh)"

# Created by `pipx` on 2024-06-01 17:52:50
export PATH="$PATH:/home/amber/.local/bin"

# Start with hyfetch in Kitty windows (i.e., not VSCode)
# This makes the prompt jump when using p10k instant prompt. I don't mind
# because it's fast enough that if I know what I'm typing when I open the
# terminal I've only typed a character or two.
if [[ $TERM == "xterm-kitty" ]]; then
    hyfetch --ascii-file ~/.config/arch-dots-text \
        -p $(shuf -e -n 1 \
        transgender \
        nonbinary \
        demigirl \
        lesbian \
        progress \
        rainbow \
        bisexual \
        pansexual \
        old-polyam)
else
    :
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
