__zshero::config::backup::prepare() {
    typeset -gx ZSHERO_CURRENT_BACKUP="${ZSHERO_BACKUP}/$(date "+%s")"
    typeset -gx ZSHERO_HAS_BACKUP=$ZSHERO_CONST_NO
}

__zshero::config::backup::make() {
 __zshero::config::backup::prepare
 # Check which files are already tracked
 __zshero::base "repository/git"
 tracked_files=($(__zshero::repository::git::get_files))
 for file ($tracked_files) __zshero::config::backup::copy $file
}

__zshero::config::backup::copy() {
    typeset filename file_source file_realpath file_destination
    filename="$1"
    file_source="${HOME}/${filename}"
    file_destination=${ZSHERO_CURRENT_BACKUP}/${filename}
    if [[ -f ${file_source} && ${file_source} == ${file_source:A} ]]; then
        __zshero::io::print::put "Preparing ${filename}…"
        __zshero::base "io/folder"
        __zshero::io::folder::create ${ZSHERO_CURRENT_BACKUP}
        if [[ ${filename} != ${filename:h} ]]; then
            #this config file is located in a subfolder.
            __zshero::io::folder::create ${ZSHERO_CURRENT_BACKUP}/${filename:h}
        fi
        __zshero::base 'io/file'
        __zshero::io::file::copy "${file_source}" "${file_destination}"
    fi
}
