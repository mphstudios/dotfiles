# Ghostty configuration file

See the [Ghostty configuration documnentation](https://ghostty.org/docs/config).

[Spectre Ghostty Config Generator](https://spectre-ghostty-config.vercel.app/editor)

## File Location

The configuration file, config, is loaded from these locations in the following order:

XDG configuration Path (all platforms):
- `$XDG_CONFIG_HOME/ghostty/config`
- if `XDG_CONFIG_HOME` is not defined, it defaults to `$HOME/.config/ghostty/config`.
 
macOS-specific Path (macOS only):
- `$HOME/Library/Application\ Support/com.mitchellh.ghostty/config`
- macOS also supports the XDG configuration path mentioned above.

Run `ghostty +show-config --default --docs` to view a list of all available config options and their default values.

Ghostty can reload the configuration while running by using the menu options or the bound key (default: Command + Shift + comma on macOS and Control + Shift + comma on other platforms). Not all config options can be reloaded while running; some only apply to new windows and others may require a full restart to take effect.

Config syntax crash course
==========================

The config file consists of simple key-value pairs,
separated by equals signs.
```sh
font-family = Liga SFMono Nerd Font Regular 14
window-padding-x = 2
```

Spacing around the equals sign does not matter.
All of these are identical:
```sh
key=value
key= value
key =value
key = value
```

Any line beginning with # is a comment. It's not possible to put a comment after a config option, since it would be interpreted as a part of the value. 
For example, this will have a value of "#123abc":
```sh
background = #123abc
```

Empty values are used to reset config keys to default.
```sh
key =
```

Some config options have unique syntaxes for their value, which is explained in the docs for that config option. 
Just for example:
```sh
resize-overlay-duration = 4s 200ms
```
