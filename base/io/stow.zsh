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
        "$config_name"
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
    __zshero::io::print::info "Adopting ${config_name}!"
    output=$($commands[stow] \
        --ignore ".DS_Store" \
        --target="$(__zshero::core::destination_folder)" \
        --dir="$(__zshero::core::config_folder)" \
        --adopt \
        $config_name)
    __zshero::io::print::success "${config_name} adopted!"
}

__zshero::io::stow::install() {
    __zshero::base "utils/ignore"
    local config_name config_folders config_files
    sidekicks_location=$(__zshero::core::config_folder)
    destination_folder=$(__zshero::core::destination_folder)
    config_name="$1"
    config_files=($(find ${sidekicks_location}${config_name}/ -type f))
    for config_file in ${config_files}; do
        final_location="${destination_folder}${config_file#${sidekicks_location}/${config_name}}"
        if ! __zshero::utils::ignore::is_file_ignored "${config_file}"; then
            echo "Copying from ${config_file} to ${destination_folder}"
        fi
    done;
}
