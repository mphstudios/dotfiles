#!/bin/sh
#
# Install dotfiles using GNU Stow
#
set -e

cd "$(dirname "$0")"
# [!.]*/ excludes hidden directories (.git, .claude, et cetera)
# because when bash dotglob is set */ matches dotfiles as well
stow [!.]*/
