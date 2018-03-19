ZSHERO_LOG_STATUS_SUCCESS="✔"
ZSHERO_LOG_STATUS_ERROR="✖"
ZSHERO_LOG_STATUS_INFO="→"

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
    pre_formats+=( "$fg[yellow]$em[under]${ZSHERO_LOG_STATUS_INFO}$reset_color" )
    command printf "$pre_formats[*] $@"
    __zshero::io::print::newline
}

__zshero::io::print::success() {
    local -a pre_formats
    pre_formats+=( "$fg[green]$em[under]${ZSHERO_LOG_STATUS_SUCCESS}$reset_color" )
    command printf "$pre_formats[*] $@"
    __zshero::io::print::newline
}

__zshero::io::print::newline() {
    command printf "\r\n"
}
