__zshero::system::folder::exists() {
    # _ZSHNF is to return false if no argument is passed. No folder named _ZSHNF
    # should exists
	[[ -d "${ZSHERO_HOME}/${ZSHERO_SIDEKICKS_FOLDER}/${1:-_ZSHNF}" ]] || return 1
}
