__zshero::core::core::variables() {
    # make autoload work in another subshell
    export FPATH="$ZSHERO_ROOT/autoload:$FPATH"

    typeset -gx ZSHERO_VERSION="0.1.0"
    # Use custom user config or the defaults if it's not set
    typeset -gx ZSHERO_HOME=${ZSHERO_HOME:-~/.dotfiles}
    typeset -gx ZSHERO_BACKUP=${ZSHERO_BACKUP:-${ZSHERO_ROOT}/backups}
    typeset -gx ZSHERO_CONFIG_FOLDER=${ZSHERO_CONFIG_FOLDER:-config}
    typeset -gx ZSHERO_DESTINATION_FOLDER=${ZSHERO_DESTINATION_FOLDER:-${HOME}}

    # Constants
    typeset -gx ZSHERO_CONST_NO="NO"
    typeset -gx ZSHERO_CONST_YES="YES"
    typeset -gx _zshero_newline="\r\n"

    # Exit Status
    typeset -gx -A _zshero_status
    _zshero_status=(
    # based on bash scripting
    # - http://tldp.org/LDP/abs/html/exitcodes.html
    "success"                0
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

__zshero::core::run_command() {
    local arg="$1";
    shift
    local command_name
    local -i ret=0
    command_name="__${arg:gs:_:}__"

    # Load the command if not yet loaded
    if (( ! $+functions[$command_name] )); then
        autoload -Uz "$command_name"
    fi

    # Execute the command
    ${=command_name} "$argv[@]"
    ret=$status

    # Unload the function after running
    unfunction "$command_name" &> /dev/null
    return ret
}

__zshero::core::root_folder() {
    echo "${${(%):-%N}:A:h}"
}
