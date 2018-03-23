__zshero::io::file::copy() {
    typeset source_path destination_path
    source_path="$1"
    destination_path="$2"
    command cp "${source_path}" "${destination_path}"
    typeset -gz -U __zshero_copied_files
    __zshero_copied_files+=(${source_path})
    __zshero::io::print::success "${source_path:t} copied to ${destination_path}"
}


__zshero::io::file::check_copy() {
( [[ ${__zshero_copied_files[(i)${path_to_check}]} -le ${#__zshero_copied_files} ]] ) || return 1
}
