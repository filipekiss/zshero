__zshero::io::folder::create() {
    typeset folder_path
    folder_path="$1"
    [[ -e "${folder_path}" ]] && return
    mkdir -p "${folder_path}" && __zshero::io::print::success "${folder_path} created"
}
