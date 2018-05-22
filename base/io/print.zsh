ZSHERO_LOG_STATUS_SUCCESS="✔"
ZSHERO_LOG_STATUS_ERROR="✖"
ZSHERO_LOG_STATUS_INFO="→"

__zshero::io::print::inline() {
    unset _zshero_newline
    [[ $# > 0 ]] && command printf "$@"
}

__zshero::io::print::start_inline() {
    __zshero::io::print::inline
}
__zshero::io::print::end_inline() {
    __zshero::io::print::reset_newline
}

__zshero::io::print::newline() {
    [[ -z $_zshero_newline ]] || command printf $_zshero_newline
}

__zshero::io::print::reset_newline() {
    typset -g _zshero_newline = ${_zshero_const[NEW_LINE]}
}

__zshero::io::print::put() {
    command printf "$@"
    __zshero::io::print::newline
}

__zshero::io::print::error() {
    local -a pre_formats
    pre_formats+=( "$fg[red]${ZSHERO_LOG_STATUS_ERROR}$reset_color" )
    command printf "$pre_formats[*] $@" >&2
    __zshero::io::print::newline
}

__zshero::io::print::warn() {
    local -a pre_formats
    pre_formats+=( "$fg[yellow]${ZSHERO_LOG_STATUS_INFO}$reset_color" )
    command printf "$pre_formats[*] $@"
    __zshero::io::print::newline
}

__zshero::io::print::success() {
    local -a pre_formats
    pre_formats+=( "$fg[green]${ZSHERO_LOG_STATUS_SUCCESS}$reset_color" )
    command printf "$pre_formats[*] $@"
    __zshero::io::print::newline
}

__zshero::io::print::info() {
    local -a pre_formats
    pre_formats+=( "$fg[blue]${ZSHERO_LOG_STATUS_INFO}$reset_color" )
    command printf "$pre_formats[*] $@"
    __zshero::io::print::newline
}

__zshero::io::print::info_var() {
    local -a pre_formats
    pre_formats+=( "$fg[blue]$1 $reset_color" )
    command printf "$pre_formats[*]= %s" "${(P)1}"
    __zshero::io::print::newline
}
