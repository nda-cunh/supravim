rm -rf $HOME/.local/share/SupraVim
echo "Kill all vim before update"
# killall vim 2> /dev/null
echo "get last_config ..."
value=$($SRCDIR/bin/supravim --save-config) 2>/dev/null | true
exit $!
