__zshero::io::stow::exec() {
    local config_name
    config_name="$1"
    __zshero::base "system/folder"
    if ! __zshero::system::folder::exists "${config_name}"; then
        __zshero::io::print::warn "${config_name} not found at ${ZSHERO_HOME}/${ZSHERO_CONFIG_FOLDER}"
        return
    fi
    $commands[stow] \
        --restow \
        --ignore ".DS_Store" \
        --target="${ZSHERO_DESTINATION_FOLDER}" \
        --dir="${ZSHERO_HOME}/${ZSHERO_CONFIG_FOLDER}" \
        $config_name
    __zshero::io::print::success "${config_name} installed"
}
