__zshero::utils::bin::check() {
	local bin="$1"
	local error_message="${2:-${bin} not in path!}"
	local exit_code="${3:-$_zshero_status[command_not_found]}"
	if (( ! $+commands[$bin] )); then
		echo ${error_message}
		return $exit_code
	fi
	return $_zshero_status[success]
}
