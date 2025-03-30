# Custom heading format script. Living in .zshenv lets it work in nvim command mode.
hdg() {
    ~/.scripts/format_heading.sh  $@
}
. "$HOME/.cargo/env"
