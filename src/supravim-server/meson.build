sources = files(
  'LspServer.vala',
  'main.vala',
  'Monitor.vala',
  'Stdin.vala',
  'SupportLang.vala',
)

vala_dependencies = [
  dependency('glib-2.0'),
  dependency('gobject-2.0'),
  dependency('gio-2.0'),
  dependency('gio-unix-2.0')
]

vala_args = [
  
]

# Add Discord presence support on non-Windows platforms, or if the user has explicitly enabled it on Windows
if host_machine.system() != 'windows' and get_option('discord-presence') == true
  sources += files('Discord.vala')
  # add -DDISCORD_PRESENCE to the compiler arguments to enable conditional compilation in the code
  vala_args += '--define=DISCORD_PRESENCE'
endif

executable('supravim-server',
  sources,
  c_args: '-w',
  vala_args: vala_args,
  dependencies : vala_dependencies,
  install : true
)
