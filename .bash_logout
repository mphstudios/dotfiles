if [ "$SHLVL" = 1 ]; then
    # clear screen and scrollback buffer
    [ -x /usr/bin/clear ] && /usr/bin/clear && printf '\e[3J'

    # delete mysql history
    [ -f $HOME/.mysql_history ] && /bin/rm $HOME/.mysql_history
fi

# prevent ssh-agent daemons from continuing to run after logout
#kill $SSH_AGENT_PID

trap "echo 'goodbye'" EXIT
