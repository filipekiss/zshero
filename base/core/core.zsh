__zshero::core::core::variables() {
    # make autoload work in another subshell
    export FPATH="$ZSHERO_ROOT/autoload:$FPATH"

    # Use custom user config or the defaults if it's not set
    typeset -gx ZSHERO_HOME=${ZSHERO_HOME:-~/.dotfiles}
    typeset -gx ZSHERO_BACKUP=${ZSHERO_BACKUP:-${ZSHERO_ROOT}/backups}
    typeset -gx ZSHERO_CONFIG_FOLDER=${ZSHERO_CONFIG_FOLDER:-config}
    typeset -gx ZSHERO_DESTINATION_FOLDER=${ZSHERO_DESTINATION_FOLDER:-${HOME}}

    # Constants
    typeset -gx ZSHERO_CONST_NO="NO"
    typeset -gx ZSHERO_CONST_YES="YES"

    # Exit Status
    typeset -gx -A _zshero_status
    _zshero_status=(
    # based on bash scripting
    # - http://tldp.org/LDP/abs/html/exitcodes.html
    "error"                  1
    "builtin_error"          2
    "command_not_executable" 126
    "command_not_found"      127
    "error_signal_hup"       129
    "error_signal_int"       130
    "error_signal_kill"      137
    # ZsHero Custom Exit Status
    "folder_not_found"       10
    )
}


__zshero::core::abort() {
    __zshero::io::print::error "$1"
    return ${2:-$_zshero_status[error]}
}
