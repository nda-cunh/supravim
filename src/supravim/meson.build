# The Config.vala file is generated from the Config.vala.in template
config_vala_file = configure_file(input : 'Config.vala.in', output : 'Config.vala', configuration : conf_data)

vala_dependencies = [
  dependency('glib-2.0'),
  dependency('gobject-2.0'),
]

srcs = files (
   'Cfg.vala',
   'main.vala',
   'Options.vala',
   'Plugin.vala',
   'PluginLst.vala',
   'SupraParser.vala',
   'Theme.vala',
)

executable('supravim',
   srcs,
   config_vala_file,
   dependencies : vala_dependencies,
   c_args: '-w',
   install : true
)
