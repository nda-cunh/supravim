_supravim_completions() {
    local cur prev opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"

    case "${prev}" in
        -t|--theme)
            opts=$(supravim --print-themes)
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        -e|--enable|-d|--disable)
            opts=$(supravim --print-options)
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        --remove-plugin|--enable-plugin|--disable-plugin)
            opts=$(supravim --print-plugins)
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
    esac

    opts=$(supravim --_list-options=bash)
    
    if [[ ${COMP_CWORD} -eq 1 ]]; then
        COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
    fi
}

complete -F _supravim_completions supravim
