#!/bin/bash
#
# Display Homebrew updates in Notification Center on Mac OS X
# http://codeworkshop.net/posts/notification-center-updates-for-homebrew
#
# Using launchctl and lunchy
# http://nathangrigg.net/2012/07/schedule-jobs-using-launchd/
# https://github.com/mperham/lunchy/
#
# Author: Matt Stevens, codeworkshop.net
# Requires: terminal-notifier (available via Homebrew)
# See https://github.com/alloy/terminal-notifier for documentation
#
export PATH=/usr/local/bin:$PATH

sleep 10 # give the network a chance to connect on wake from sleep

brew update > /dev/null 2>&1
outdated=`brew outdated | sort | tr '\n' ' '`

if [ ! -z "$outdated" ]; then
	terminal-notifier \
		-group homebrew.mxcl.brew-update-notifier \
		-title "Homebrew Updates Available" \
		-message "$outdated" \
		-sender com.apple.Terminal > /dev/null 2>&1
fi