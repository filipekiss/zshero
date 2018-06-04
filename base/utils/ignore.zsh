# @TODO: Better way to read and apply ignore files
# @BODY: Currently this is very slow: we check each file against each ignore
# file and this takes a lot of time. I need to find a way to, in order:
# 1. Find All "ignore" files (like .zshero-ignore and .gitignore)
# 2. Read all "ignorable" patterns into an array, respecting the "ignore level"
# 3. Match the files againts the patterns in the array (maybe ZSH can do this in
#    a way that I can "glob-match" the string against the array)
__zshero::utils::ignore::test_file() {
    local file_path="$1"
    local file_source="$2"
    if __zshero::utils::ignore::should_ignore_file "${file_path}" "${file_source}"; then
        echo "Ignoring ${file_path}"
    else
        echo "Copying ${file_path}"
    fi
}

__zshero::utils::ignore::find_ignore_for() {
    local file_to_check="${1:-non-existing-file}"
    local ignore_file_name=".zshero-ignore"
    local startingFolder="${file_to_check:h}"
    local endFolder=$(__zshero::core::config_folder)
    local -au ignore_files
    ignore_files+=($(__zshero::utils::ignore::find_ignore_file "$ignore_file_name" "$startingFolder" "$endFolder"))
    ignore_files+=($(__zshero::utils::ignore::find_ignore_file ".gitignore" "$startingFolder" "$endFolder"))
    echo ${ignore_files}
}

__zshero::utils::ignore::is_file_ignored() {
    [[ -z $_zshero_ignored_files ]] && typeset -a _zshero_ignored_files
    local file_to_check="${1}"
    local ignore_files=($(__zshero::utils::ignore::find_ignore_for "${file_to_check}"))
    if [[ ${_zshero_ignored_files[(i)${file_to_check}]} -le ${#_zshero_ignored_files} ]]; then
        return 0
    fi
    for ignore_file in ${ignore_files[@]}; do
        if __zshero::utils::ignore::is_file_ignored_in "$ignore_file" "$file_to_check"; then
            _zshero_ignored_files+=($file_to_check)
            return 0
        fi
    done
    return 1
}

__zshero::utils::ignore::is_file_ignored_in() {
    zmodload zsh/mapfile
    local file_lines
    local file_to_check="${2:-non-existing-file}"
    sidekicks_location=$(__zshero::core::config_folder)
    file_to_check="${file_to_check#${sidekicks_location}}"
    file_lines=( "${(f)mapfile[$1]}" )
    [[ -z ${file_lines} ]] && return 1
    for line in $file_lines; do
        [[ $line =~ "^\s?#" ]] && continue
        if [[ "${file_to_check#/*/}" == ${~line}* ]]; then
            return 0
        fi
    done;
    return 1
}

__zshero::utils::ignore::find_ignore_file() {
    local ignore_file_name="${1:-non-existing-file}"
    local startingFolder="${2:-${ignore_file_name:h}}"
    local endFolder="${3:-/}"
    (
    cd ${startingFolder}
    while true; do
        if [[ -f $PWD/$ignore_file_name ]]; then
            echo "$PWD/$ignore_file_name"
        fi
        if [[ $PWD = ${endFolder:-/} ]] || [[ $PWD = / ]] || [[ $PWD = // ]]; then
            break;
        fi
        cd ..
    done
    )
}
