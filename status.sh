#!/bin/bash
get_status () {
    curl -is https://$1 | grep -Eq "200 OK|401 Unauthorized"
    if [ "$?" -ne "0" ]; then
        status="$(tput setaf 1)DOWN$(tput sgr0)"
    else
        status="$(tput setaf 2)ok$(tput sgr0)"
    fi
    printf "%s%*s\n" $1 $(($(tput cols) - ${#1})) $status
}
export -f get_status

cat domains | xargs -n1 -P2 bash -c 'get_status "$@"' _
