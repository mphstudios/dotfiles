#!/usr/bin/env nu

# Install the Nushell core plugins
# https://www.nushell.sh/book/plugins.html#core-plugins
#
# Nota bene: this script must be run manually: nu scripts/setup.nu
#
const core_plugins = [
  nu_plugin_formats
  nu_plugin_gstat
  nu_plugin_inc
  nu_plugin_polars
  nu_plugin_query
]

$core_plugins | each {
  cargo install $in --locked
  plugin add $in
} | ignore
