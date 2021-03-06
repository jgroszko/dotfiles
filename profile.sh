#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

source $DIR/git-prompt.sh

function sst () {
	/usr/bin/ssh \
		-o PermitLocalCommand=yes \
		-o LocalCommand="cat ${HOME}/.tmux.conf.remote | ssh -o PermitLocalCommand=no %n \"cat > ${HOME}/.tmux.conf\"" \
		-t $@ "tmux new-session -A -s \"`hostname -fs`\""
}

alias rmrfnm='rm -rf node_modules && npm install'
alias rfrfym='rm -rf node_modules && yarn install'

alias watchtemps="watch 'sensors && liquidctl status && nvidia-smi'"
