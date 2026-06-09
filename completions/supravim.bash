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
            opts=$(supravim --print-options-switchable)
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        -S|--set)
            opts=$(supravim --print-options)
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        --remove-plugin|--enable-plugin|--disable-plugin|\
        --update-plugin|--pin-plugin|--unpin-plugin)
            opts=$(supravim --print-plugins)
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        --add-group|--remove-group)
            opts=$(supravim --print-plugins)
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        --enable-group|--disable-group|--group)
            opts=$(supravim --print-groups)
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
    esac

    opts=$(supravim --_list-options=bash)
    COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
}

complete -F _supravim_completions supravim
