# The various escape codes that we can use to color our prompt.
FG_YELLOW="\e[38;5;226m"
FG_GREY_0="\e[38;5;234m"
FG_GREY_1="\e[38;5;236m"
FG_GREY_2="\e[38;5;238m"
FG_GREY_3="\e[38;5;255m"

BG_BLACK="\e[48;5;0m"
BG_GREY_0="\e[48;5;234m"
BG_GREY_1="\e[48;5;236m"
BG_GREY_2="\e[48;5;238m"
BG_GREY_3="\e[48;5;255m"

CLEAN_COLOR=$FG_GREY_3
DIRTY_COLOR=$FG_YELLOW

ARROW=""

PRE_ARROW="$BG_GREY_2$FG_GREY_3"
ARROW_FIRST="$FG_GREY_2$BG_GREY_1$ARROW$FG_GREY_3"

ARROW_SECOND_FINAL="$FG_GREY_1$BG_BLACK$ARROW$FG_GREY_3"

ARROW_SECOND="$FG_GREY_1$BG_GREY_0$ARROW$FG_GREY_3"
ARROW_THIRD="$FG_GREY_0$BG_BLACK$ARROW$FG_GREY_3"

# Detect whether the current directory is a git repository.
function is_git_repository {
  git branch > /dev/null 2>&1
}

# Determine the branch/state information for this git repository.
function set_git_branch {
  # Set the final branch string.
  BRANCH=`git rev-parse --abbrev-ref HEAD 2>/dev/null || echo ""`

  if [[ `git status` =~ "working tree clean" ]]; then
  	 BRANCH_COLOR=$CLEAN_COLOR
  else
	 BRANCH_COLOR=$DIRTY_COLOR
  fi
}

# Set the full bash prompt.
function set_bash_prompt () {
  # Set the BRANCH variable.
  if is_git_repository ; then
    set_git_branch
	BRANCH="$ARROW_SECOND $BRANCH_COLOR$BRANCH $ARROW_THIRD"
  else
    BRANCH="$ARROW_SECOND_FINAL"
  fi

  # Set the bash prompt variable.
  PS1="$PRE_ARROW \h $ARROW_FIRST \w $BRANCH \$ "
}

# Tell bash to execute this function just before displaying its prompt.
PROMPT_COMMAND=set_bash_prompt
