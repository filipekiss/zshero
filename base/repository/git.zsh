__zshero::repository::git::get_files() {
    typeset -a files
    files=($(command git --work-tree=$ZSHERO_HOME --git-dir=$ZSHERO_HOME/.git ls-files "${ZSHERO_SIDEKICKS_FOLDER}/**/*"))
    for file ($files) echo ${file#*/*/}
}

__zshero::repository::git::get_config_folders() {
    typeset -a folders
    folders=($(find $ZSHERO_HOME/$ZSHERO_SIDEKICKS_FOLDER -maxdepth 1 -mindepth 1 -type d))
    for folder ($folders) echo ${folder#${ZSHERO_HOME}/${ZSHERO_SIDEKICKS_FOLDER}/*}
}
