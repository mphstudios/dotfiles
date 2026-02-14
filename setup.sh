#!/bin/sh
#
# Install dotfiles using GNU Stow
#
set -e

cd "$(dirname "$0")"
stow */
