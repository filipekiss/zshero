__zshero::utils::fd::list_install_candidates() {
    local ignores=$(fd --hidden ".zshero-ignore" "${root}")
    local ignore_option="--exclude=.gitignore"
    [[ -n ${ignores} ]] && ignore_option="--ignore-file=${ignores}"
    echo $(fd --exclude=".zshero-ignore" --exclude=".git" --hidden ${ignore_option} . "${root}")
}
