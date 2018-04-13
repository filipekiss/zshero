__zshero::base "utils/bin"
__zshero::utils::bin::check "git" \
    "You need git! Install git and try again!" || return $status

local CURRENT_FOLDER=$(__zshero::core::root_folder)

__zshero::config::adopt() {
    local config_name="$1"
    config_folders=($1)
    __zshero::base "repository/git"
    __zshero::base "io/stow"
    # If no config is passed, adopt all by default
    if [[ -z $config_name ]]; then
        config_folders=($(__zshero::repository::git::get_config_folders))
    fi
    __zshero::utils::bin::check "stow" \
        "Stow is not installed" || return $_zshero_status[command_not_found]
    for config_folder ($config_folders) __zshero::io::stow::adopt $config_folder
}
