# Taken from https://github.com/zplug/zplug/blob/master/init.zsh
__zshero::base()
{
    local     load_file arg
    local -aU load_files

    while (( $# > 0 ))
    do
        arg="$1"
        case "$arg" in
            -*|--*)
                return 1
                ;;
            */'*')
                # e.g. 'base/*'
                load_files+=( "$ZSHERO_ROOT/base/${arg:h}"/*.zsh(N-.) )
                ;;
            */*)
                # e.g. 'core/add'
                # if 'core/add' if a folder, look for 'core/add/init.zsh'
                if [[ -f  "$ZSHERO_ROOT/base/${arg}/init.zsh" ]]; then
                    load_files+=( "$ZSHERO_ROOT/base/${arg}/init.zsh"(N-.) )
                else
                    load_files+=( "$ZSHERO_ROOT/base/${arg}.zsh"(N-.) )
                fi
                ;;
            *)
                return 1
                ;;
        esac
        shift
    done

    # invalid format
    if (( $#load_files == 0 )); then
        return 1
    fi

    fpath=(
    "${load_files[@]:h}"
    "${fpath[@]}"
    )

    for load_file in "${load_files[@]}"
    do
        if (( $+functions[$load_file] )); then
            # already defined
            continue
        fi

        autoload -Uz "${load_file:t}" &&
            eval "${load_file:t}"     &&
            unfunction "${load_file:t}"
    done
}
