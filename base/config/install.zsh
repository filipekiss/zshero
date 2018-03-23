__zshero::config::install() {
    __zshero::base "repository/git"
    __zshero::base "io/stow"
    config_folders=($(__zshero::repository::git::get_config_folders))
    if ! __zshero::io::stow::validate; then
        __zshero::core::abort "Stow is not installed" $_zshero_status[command_not_found]
    fi
    for config_folder ($config_folders) __zshero::io::stow::exec $config_folder
}
