project('tictactoe', ['c', 'vala'], default_options : ['warning_level=0'])

gnome = import('gnome')

add_project_arguments(['-w'], language: 'c')

gresource = gnome.compile_resources(
  'gresource',
  'gresource.xml',
  source_dir: 'data'
)

executable('tictactoe',
  'main.vala',
  gresource,
  dependencies : [
    dependency('gtk4'),
    dependency('gee-0.8')],
  install : true)
