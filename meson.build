#########################
# SupraVim 
#########################

project('SupraVim', ['c', 'vala'], version : '5.88.1')

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

subdir('src')



###################################
# Install
###################################

install_subdir('share/supravim', install_dir : 'share')
install_subdir('share/zsh', install_dir : 'share')
# share/lsp_c share/post_install.sh share/pre_install.sh share/supravim share/uninstall share/zsh
install_data('share/lsp_c', install_dir : 'bin')
install_data('share/post_install.sh', install_dir : '.')
install_data('share/pre_install.sh', install_dir : '.')
install_data('share/uninstall', install_dir : '.')



###################################
# Suprapack
###################################

if find_program('suprapack').found()
  description = 'a makefile compatibility layer. it can do it for you meson|make|none'

  info_file = configure_file(input : 'info.in', output : 'info', configuration : conf_data)

  install_data(info_file, install_dir: '.')
  meson.add_install_script('suprapack_build.sh')
endif

