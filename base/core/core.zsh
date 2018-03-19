__zshero::core::core::variables() {
    # make autoload work in another subshell
    export FPATH="$ZSHERO_ROOT/autoload:$FPATH"

    # Use custom user config or the defaults if it's not set
    typeset -gx ZSHERO_HOME=${ZSHERO_HOME:-~/.dotfiles}
    typeset -gx ZSHERO_BACKUP=${ZSHERO_BACKUP:-${ZSHERO_ROOT}/backups}

    # Constants
    typeset -gx ZSHERO_CONST_NO="NO"
    typeset -gx ZSHERO_CONST_YES="YES"
}
