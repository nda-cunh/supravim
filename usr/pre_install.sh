rm -rf $HOME/.local/share/SupraVim
echo "Kill all vim before update"
# killall vim 2> /dev/null
echo "get last_config ..."
value=$($SRCDIR/share/supravim/create_cfg "$SRCDIR/share/supravim/supravim.cfg")
exit $value
