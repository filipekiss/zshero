__zshero::io::folder::create() {
    typeset folder_path
    folder_path="$1"
    [[ -d "${folder_path}" ]] && return
    command mkdir -p "${folder_path}" && __zshero::io::print::success "${folder_path} created"
}

__zshero::io::is::folder() {
    local file_path="$1"
    [[ -d $file_path ]]
}
