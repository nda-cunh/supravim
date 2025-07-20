# The Config.vala file is generated from the Config.vala.in template
config_vala_file = configure_file(input : 'Config.vala.in', output : 'Config.vala', configuration : conf_data)

srcs = files (
   'main.vala',
   'Theme.vala',
   'Plugin.vala',
   'General.vala',
   'Element.vala',
   'Modificator.vala',
   'Status.vala',
   'Cfg.vala',
   'ArrayElement.vala',
   'Utils.vala',
   'PluginLst.vala'
)

executable('supravim',
   srcs,
   config_vala_file,
   dependencies : vala_dependencies,
   c_args: '-w',
   install : true)
