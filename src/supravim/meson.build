# The Config.vala file is generated from the Config.vala.in template
config_vala_file = configure_file(input : 'Config.vala.in', output : 'Config.vala', configuration : conf_data)

srcs = files (
   'Cfg.vala',
   'Options.vala',
   'Plugin.vala',
   'PluginLst.vala',
   'SupraParser.vala',
   'Theme.vala',
   'Utils.vala',
   'main.vala',
)

executable('supravim',
   srcs,
   config_vala_file,
   dependencies : vala_dependencies,
   c_args: '-w',
   install : true)
