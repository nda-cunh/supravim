#compdef supravim

_supravim() {
    local -a main_opts
    
    if (( CURRENT == 2 )); then
        main_opts=(${(f)"$(supravim --_list-options=zsh)"})
        _describe 'options' main_opts
    else
        case "$words[2]" in
            -t|--theme)
                local -a themes
                themes=(${(f)"$(supravim --print-themes)"})
                _describe 'themes' themes
                ;;
            -e|--enable|-d|--disable)
                local -a configs
                configs=(${(f)"$(supravim --print-options)"})
                _describe 'config options' configs
                ;;
            --remove-plugin|--enable-plugin|--disable-plugin)
                local -a plugins
                plugins=(${(f)"$(supravim --print-plugins)"})
                _describe 'plugins' plugins
                ;;
        esac
    fi
}

_supravim "$@"
