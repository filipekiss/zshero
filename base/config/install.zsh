# +TODO: Make install able to receive the config name to be installed, default to all configs
__zshero::config::install() {
    __zshero::base "repository/git"
    __zshero::base "io/stow"
    config_folders=($(__zshero::repository::git::get_config_folders))
    __zshero::utils::bin::check "stow" \
        "Stow is not installed" || return $_zshero_status[command_not_found]
    for config_folder ($config_folders) __zshero::io::stow::exec $config_folder
}
