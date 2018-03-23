__zshero::system::folder::exists() {
	[[ -d "${ZSHERO_HOME}/${ZSHERO_CONFIG_FOLDER}/${1:-_ZSHNF}" ]] || return 1
}
