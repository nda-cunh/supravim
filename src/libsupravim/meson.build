build_config_vala = configure_file(
  input : 'BuildConfig.vala.in',
  output : 'BuildConfig.vala',
  configuration : conf_data,
)

lib_sources = files(
  'Achievements.vala',
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

libsupravim = library('supravim',
  lib_sources,
  build_config_vala,
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

libsupravim_dep = declare_dependency(
  link_with: libsupravim,
  dependencies: lib_deps,
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
