#!/bin/bash

right_align () {
    domain=$1
    size=${#domain}
    len=$(($(tput cols) - $size))
    printf "%s%*s" $1 $len $2
}

get_status () {
    curl -is https://$1 | grep -q "200 OK\|401 Unauthorized"
    if [ "$?" -ne "0" ]; then
        right_align $1 "DOWN"
    else
        right_align $1 "ok"
    fi
}
get_status fromgildywith.love
get_status funhouse.dillonchristensen.com
get_status bookworth.net

