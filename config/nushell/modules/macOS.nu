# Nushell configuration overlay for macOS

# flush directory service and local DNS cache
export def resetDNS [] {
  sudo dscacheutil -flushcache
  sudo killall -HUP mDNSResponder
  echo "macOS DNS Cache Reset"
}

# Preview
export alias preview = ^open -a /Applications/Preview.app

# Safari
export alias safari = ^open -a /Applications/Safari.app

# Quick Look (^C or space to close)
export alias qlp = qlmanage -p | ignore
export alias qlr = qlmanage -r cache
