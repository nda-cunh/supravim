lib_sources = files(
  'Globals.vala',
  'Cfg.vala',
  'Export.vala',
  'Options.vala',
  'Plugin.vala',
  'PluginLst.vala',
  'SupraParser.vala',
  'Theme.vala',
)

lib_deps = [
  dependency('glib-2.0'),
  dependency('gobject-2.0'),
  dependency('gio-2.0'),
  dependency('gio-unix-2.0'),
  dependency('yyjson', static: true),
]

# lib_build_dir = meson.current_build_dir()
# WARNING a rmeove

libsupravim = library('supravim',
  lib_sources,
  vala_header: 'supravim.h',
  vala_vapi: 'supravim.vapi',
  dependencies: lib_deps,
  vala_args: [
    '--pkg=yyjson',
  ],
  c_args: '-w',
  install: true,
  install_vala_header : true,
  install_vala_vapi : true,
)

# Voici la manière la plus simple et correcte selon la doc :
libsupravim_dep = declare_dependency(
  link_with: libsupravim,
  dependencies: lib_deps,
  # Indique à Meson d'inclure le dossier de build de la lib (où se trouvent 'supravim.h' et 'PluginLst.h')
  include_directories: include_directories('.'),
)

pkg = import('pkgconfig')

pkg.generate(libsupravim,
  name: 'supravim',
  filebase: 'supravim',
  description: 'SupraVim plugin and configuration management library',
  requires: ['glib-2.0', 'gobject-2.0', 'gio-2.0'],
)

meson.override_dependency('supravim', libsupravim_dep)

# meson.add_install_script('sh', '-c',
  # 'install -Dm644 "@0@/supravim.h" "$DESTDIR@1@/supravim.h"'.format(
    # meson.current_build_dir(), get_option('prefix') / get_option('includedir')),
# )
# 
# meson.add_install_script('sh', '-c',
  # 'install -Dm644 "@0@/supravim.vapi" "$DESTDIR@1@/supravim.vapi"'.format(
    # meson.current_build_dir(),
    # get_option('prefix') / get_option('datadir') / 'vala' / 'vapi'),
# )
