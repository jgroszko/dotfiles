#!/bin/bash -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

#
# Requirements:
#
# - Fura Code or similar font with powerline glyphs
#

#
# tmux conf
#

pipenv run jinja2 tmux.conf.tmpl colors.local.json > tmux.conf
if [ ! -e ~/.tmux.conf ]; then
	ln -s $DIR/tmux.conf ~/.tmux.conf
fi

pipenv run jinja2 tmux.conf.tmpl colors.remote.json > tmux.conf.remote
if [ ! -e ~/.tmux.conf.remote ]; then
	ln -s $DIR/tmux.conf.remote ~/.tmux.conf.remote
fi

if [ ! -e ~/bin/git-status.sh ]; then
	mkdir -p ~/bin
	ln -s $DIR/git-status.sh ~/bin/git-status.sh
fi

#
# bash profile
#
PROFILE="source $DIR/profile.sh"
PROFILE_ESCAPED="$( echo ${PROFILE} | sed -e 's:[\/]:\\&:g' )"
sed -i.bak -e '$a\' -e "\n\n$PROFILE\n\n" -e "/^$PROFILE_ESCAPED$/d" ~/.profile
