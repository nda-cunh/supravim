config_vala_file = configure_file(input : 'Config.vala.in', output : 'Config.vala', configuration : conf_data)

sources = files(
  'main.vala',
  'Command.vala'
)

executable('supravim',
  sources,
  config_vala_file,
  dependencies: libsupravim_dep,
  c_args: '-w',
  install: true,
)
