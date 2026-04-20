bash_comp_dir = get_option('datadir') / 'bash-completion' / 'completions'
zsh_comp_dir = get_option('datadir') / 'zsh' / 'site-functions'

install_data(
  'supravim.bash',
  install_dir: bash_comp_dir,
  rename: 'supravim'
)

install_data(
  'supravim.zsh',
  install_dir: zsh_comp_dir,
  rename: '_supravim'
)
