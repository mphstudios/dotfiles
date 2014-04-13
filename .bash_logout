if [ "$SHLVL" = 1 ]; then

    # clear screen
    [ -x /usr/bin/clear ] && /usr/bin/clear

    # delete mysql history
    [ -f $HOME/.mysql_history ] && /bin/rm $HOME/.mysql_history

fi