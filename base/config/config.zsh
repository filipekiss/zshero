__zshero::config::config::check_file() {
    local config_folder=$(__zshero::core::config_folder)
    local file_path="$1"
    local file_name="${file_path:t}"
    if [[ $file_path =~ $config_folder ]]; then
        if [[ ! $file_path =~ $config_name ]]; then
            config_from_path=$(__zshero::config::config::find_config_name $file_path)
            __zshero::io::print::error "The file $fg[cyan]${file_name}$reset_color is managed by $fg[cyan]${config_from_path}$reset_color"
            return 1
        fi
        __zshero::io::print::warn "$fg[yellow]$file_name$reset_color is already managed by zshero"
        return 1
    fi
    [[ -f $file_path ]]
}

__zshero::config::config::validate_namespace() {
    local config_folder=$(__zshero::core::config_folder)
    local config_name="$1"
    [[ -d "$config_folder/$config_name" ]] && return 0
    __zshero::io::print::info "Created $fg[green]$config_name$reset_color"
    __zshero::io::folder::create "$config_folder/$config_name"
}

__zshero::config::config::find_config_name() {
    local file_path="$1"
    local config_location=$(__zshero::core::config_folder)
    local config_base=${file_path#$config_location/}
    config_base=${config_base:r}
    echo ${config_base%/}
}

__zshero::config::config::resolve_destination_path() {
    local config_name="$1"
    local file_name="$2"
    local config_root="$(__zshero::core::config_folder)/$config_name"
    local destination_root="$(__zshero::core::destination_folder)"
    echo "$config_root${file_name#$destination_root}"
}

__zshero::config::config::add_file_to_config() {
    local config_name="$1"
    local file_name="$2"
    config_file_location=$(__zshero::config::config::resolve_destination_path "$config_name" "$file_name")
    __zshero::io::folder::create "${config_file_location:h}"
    __zshero::io::file::create ${config_file_location}
}

__zshero::config::config::from_folder() {
    local folder_location="$1"
    local folder_contents=$(command ls $folder_location)
    typeset -aU output
    for content_name in ${=folder_contents[@]}; do
        path_to_test="$folder_location/$content_name"
        [[ -f "$path_to_test" ]] && result=("$path_to_test")
        [[ -d "$path_to_test" ]] && result=($(__zshero::config::config::from_folder "$path_to_test"))
        [[ -n $result ]] && output+=("$result")
    done;
    [[ -n $output ]] && echo "${(iF)output}"
}
