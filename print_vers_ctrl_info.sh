#!/bin/bash

NO_REVISION_MSG="\\textcolor{red}{No version control}"
UNCOMMITTED_MSG="\\textcolor{red}{(uncommitted)}"

SVN_REV="$(svn info 2>/dev/null | grep 'Revision:' | awk '{print $2}')"
GIT_COMM="$(git rev-parse --short HEAD 2>/dev/null)"

if [[ "$SVN_REV" ]]; then
    echo "$SVN_REV"
    if [[ $(svn status -q --no-ignore) ]]; then
        echo "$UNCOMMITTED_MSG"
    fi
elif [[ "$GIT_COMM" ]]; then
    echo "$GIT_COMM"
    if ! git diff-index --quiet HEAD -- 2>/dev/null; then
        echo "$UNCOMMITTED_MSG"
    fi
else
    echo "$NO_REVISION_MSG"
fi
