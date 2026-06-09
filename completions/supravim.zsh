#compdef supravim

_supravim() {
    case "$words[CURRENT-1]" in
        -t|--theme)
            local -a themes
            themes=(${(f)"$(supravim --print-themes)"})
            _describe 'themes' themes
            return
            ;;
        -e|--enable|-d|--disable)
            local -a configs_switch
            configs_switch=(${(f)"$(supravim --print-options-switchable)"})
            _describe 'config options' configs_switch
            return
            ;;
        -S|--set)
            local -a configs
            configs=(${(f)"$(supravim --print-options)"})
            _describe 'config options' configs
            return
            ;;
        --remove-plugin|--enable-plugin|--disable-plugin|\
        --update-plugin|--pin-plugin|--unpin-plugin)
            local -a plugins
            plugins=(${(f)"$(supravim --print-plugins)"})
            _describe 'plugins' plugins
            return
            ;;
        --add-group|--remove-group)
            local -a plugins
            plugins=(${(f)"$(supravim --print-plugins)"})
            _describe 'plugins (format: plugin:group)' plugins
            return
            ;;
        --enable-group|--disable-group|--group)
            local -a groups
            groups=(${(f)"$(supravim --print-groups)"})
            _describe 'groups' groups
            return
            ;;
    esac

    local -a main_opts
    main_opts=(${(f)"$(supravim --_list-options=zsh)"})
    _describe 'options' main_opts
}

_supravim "$@"
