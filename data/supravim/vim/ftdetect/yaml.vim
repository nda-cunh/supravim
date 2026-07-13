vim9script

augroup CustomYamlFiletype
    autocmd!
    autocmd BufRead,BufNewFile *.yml.* setfiletype yaml
    
    autocmd BufRead,BufNewFile *.yaml.* setfiletype yaml
augroup END
