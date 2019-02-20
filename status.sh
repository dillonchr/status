#!/bin/bash
right_align () {
    printf "%s%*s" $1 $(($(tput cols) - ${#1})) $2
}
export -f right_align

get_status () {
    curl -is https://$1 | grep -Eq "200 OK|401 Unauthorized"
    if [ "$?" -ne "0" ]; then
        right_align $1 "DOWN"
    else
        right_align $1 "ok"
    fi
}
export -f get_status

cat domains | xargs -n1 -P2 bash -c 'get_status "$@"' _
