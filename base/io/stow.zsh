__zshero::io::stow::exec() {
    local config_name
    config_name="$1"
    __zshero::base "system/folder"
    if ! __zshero::system::folder::exists "${config_name}"; then
        __zshero::io::print::warn "${config_name} not found at $(__zshero::core::config_folder)"
        return
    fi
    $commands[stow] \
        --restow \
        --ignore ".DS_Store" \
        --target="$(__zshero::core::destination_folder)" \
        --dir="$(__zshero::core::config_folder)" \
        $config_name
    __zshero::io::print::success "${config_name} installed"
}

__zshero::io::stow::adopt() {
    local config_name
    config_name="$1"
    __zshero::base "system/folder"
    if ! __zshero::system::folder::exists "${config_name}"; then
        __zshero::io::print::warn "${config_name} not found at $(__zshero::core::config_folder)"
        return
    fi
    __zshero::io::print::success "Adopting ${config_name}!"
    output=$($commands[stow] \
        --ignore ".DS_Store" \
        --target="$(__zshero::core::destination_folder)" \
        --dir="$(__zshero::core::config_folder)" \
        --adopt \
        --verbose \
        $config_name)
    __zshero::io::print::success "${config_name} adopted!"
}
