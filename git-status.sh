#!/bin/bash

YELLOW=colour226
GREY_0=colour232
GREY_1=colour236
GREY_2=colour240
GREY_3=colour255

CLEAN_COLOR=$GREY_3
DIRTY_COLOR=$YELLOW

ARROW=""

ARROW_FIRST="#[fg=$GREY_1,bg=$GREY_0]$ARROW#[fg=$GREY_3,bg=$GREY_1]"
ARROW_SECOND="#[fg=$GREY_2,bg=$GREY_1]$ARROW#[fg=$GREY_3,bg=$GREY_2]"

function is_git_repository {
    git branch > /dev/null 2>&1
}

if is_git_repository; then
    BRANCH=`git rev-parse --abbrev-ref HEAD`
    REPO=`basename $(git rev-parse --show-toplevel)`

    if [[ `git status` =~ "working tree clean" ]]; then
        BRANCH_COLOR="#[fg=$CLEAN_COLOR]"
    else
        BRANCH_COLOR="#[fg=$DIRTY_COLOR]"
    fi

    echo "$ARROW_FIRST $BRANCH_COLOR$BRANCH $ARROW_SECOND $REPO "
else
    echo "$ARROW_FIRST $PWD "
fi
