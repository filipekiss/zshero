__zshero::repository::git::get_files() {
    typeset -a files
    files=($(command git --work-tree=$ZSHERO_HOME --git-dir=$ZSHERO_HOME/.git ls-files "config/**/*"))
    for file ($files) echo ${file#*/*/}
}

__zshero::repository::git::get_config_folders() {
    typeset -a folders
    folders=($(find $ZSHERO_HOME/$ZSHERO_CONFIG_FOLDER -maxdepth 1 -mindepth 1 -type d))
    for folder ($folders) echo ${folder#${ZSHERO_HOME}/${ZSHERO_CONFIG_FOLDER}/*}
}
