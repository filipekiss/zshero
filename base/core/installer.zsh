__zshero::core::installer::is_self_folder() {
    local arg="$1"
    [[ $arg == $ZSHERO_ROOT ]] || return 1
}
