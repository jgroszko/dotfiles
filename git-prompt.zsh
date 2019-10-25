# The various escape codes that we can use to color our prompt.
YELLOW="226"
BLACK="0"
GREY_0="235"
GREY_1="237"
GREY_2="239"
GREY_3="245"
GREY_4="255"

CLEAN_COLOR=$GREY_4
DIRTY_COLOR=$YELLOW

SEGMENT_SEPARATOR=""

CURRENT_BG='NONE'

prompt_segment() {
    local bg fg
    [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
    [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
    if [[ $CURRENT_BG != 'NONE' && $1 != $CURRENT_BG ]]; then
	echo -n " %{$bg%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR%{$fg%} "
    else
	echo -n "%{$bg%}%{$fg%} "
    fi
    CURRENT_BG=$1
    [[ -n $3 ]] && echo -n $3
}

# End the prompt, closing any open segments
prompt_end() {
  if [[ -n $CURRENT_BG ]]; then
    echo -n " %{%k%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR"
  else
    echo -n "%{%k%}"
  fi
  echo -n "%{%f%}"
  CURRENT_BG=''
}

prompt_user() {
    prompt_segment $GREY_2 $GREY_4 "%n"
}

prompt_dir() {
    prompt_segment $GREY_1 $GREY_4 "%~"
}

prompt_git() {
    (( $+commands[git] )) || return
    local ref dirty

    if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
	dirty=$(parse_git_dirty)
	ref=$(git symbolic-ref --short HEAD 2> /dev/null) || ref="$(git rev-parse --short HEAD 2> /dev/null)"
	if [[ -n $dirty ]]; then
	   prompt_segment $GREY_0 $YELLOW $ref
	else
	   prompt_segment $GREY_0 $GREY_4 $ref
	fi
    fi
}

build_prompt() {
    prompt_user
    prompt_dir
    prompt_git
    prompt_end
}

PROMPT='%{%f%b%k%}$(build_prompt) '
# PROMPT="$PRE_ARROW %n $ARROW_FIRST %~ $ARROW_SECOND_FINAL "
