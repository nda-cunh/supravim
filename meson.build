#########################
# SupraVim 
#########################

project('supravim', ['c', 'vala'], version : '6.2.4', 
  default_options : [
    'warning_level=0',
    'buildtype=release',
    'optimization=3',
    'b_lto=true',
  ])

add_global_arguments('--target-glib=auto', language : ['vala'])
add_global_arguments('-w', language : ['c', 'cpp'])

description = 'un supraediteur sur vim'


###################################
# Configuration
###################################

conf_data = configuration_data()
conf_data.set('description', description)
conf_data.set('name', meson.project_name())
conf_data.set('version', meson.project_version())


####################################
# Create the supravim executable
####################################

vala_dependencies = [
  dependency('glib-2.0'),
  dependency('gobject-2.0'),
  dependency('gio-2.0'),
]

subdir('src')



###################################
# Install
###################################

install_subdir('data/supravim', install_dir : 'share')
install_subdir('data/zsh', install_dir : 'share')
install_data('data/lsp_c', install_dir : 'bin')
install_data('data/post_install.sh', install_dir : '.')
install_data('data/pre_install.sh', install_dir : '.')
install_data('data/uninstall', install_dir : '.')



###################################
# Suprapack
###################################

if find_program('suprapack').found()
  description = 'a makefile compatibility layer. it can do it for you meson|make|none'

  info_file = configure_file(input : 'data/info.in', output : 'info', configuration : conf_data)

  install_data(info_file, install_dir: '.')
  meson.add_install_script('suprapack_build.sh')
endif

