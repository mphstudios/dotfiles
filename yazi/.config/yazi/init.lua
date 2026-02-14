-- ~/.config/yazi/init.lua
th.git = th.git or {}
th.git.modified = ui.Style():fg("blue")
th.git.deleted = ui.Style():fg("red"):bold()
require("git"):setup {
  -- Order of status signs showing in the linemode
  order = 1500,
}

require("full-border"):setup {
  -- Available values: ui.Border.PLAIN, ui.Border.ROUNDED
  type = ui.Border.ROUNDED,
}
