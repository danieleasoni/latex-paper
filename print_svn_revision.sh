#!/bin/bash

svn info 2>/dev/null | grep "Revision:" | awk '{print $2}'

if [[ $(svn status -q --no-ignore) ]]; then
    echo "\\textcolor{red}{(uncommitted)}"
fi
