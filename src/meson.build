# The Config.vala file is generated from the Config.vala.in template
config_vala_file = configure_file(input : 'Config.vala.in', output : 'Config.vala', configuration : conf_data)

srcs = files (
   'main.vala',
   'Theme.vala',
   'General.vala',
   'Element.vala'
)

executable('supravim',
   srcs,
   config_vala_file,
   dependencies : [
      dependency('gio-2.0'),
      dependency('glib-2.0'),
      dependency('gobject-2.0')],
   c_args: '-w',
   install : true)
