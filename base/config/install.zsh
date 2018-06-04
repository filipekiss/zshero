__zshero::config::install() {
    __zshero::base "repository/git"
    __zshero::base "io/stow"
    if [[ $# -gt 0 && $1 != "all" ]]; then
        config_folders=("$@")
    else
        config_folders=($(__zshero::repository::git::get_config_folders))
    fi
    for config_folder ($config_folders); do
        local files=($(__zshero::utils::config::find_config_files $config_folder))
        for file ($files) echo $file
    done
}


__zshero::utils::config::find_config_files() {
    __zshero::base "utils/fd"
    local config_name="$1"
    local root=$(__zshero::core::config_folder)/${config_name}
    __zshero::utils::fd::list_install_candidates ${root}
}

