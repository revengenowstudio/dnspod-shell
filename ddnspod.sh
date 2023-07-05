#!/bin/sh
#

globals() {
    this="$(cd "$(dirname "$0")" && pwd -P)"
    arToken=""
    updateIPv6=true
}; globals

# Import ardnspod functions
. "$this/ardnspod"

# Combine your token ID and token together as follows

# Place each domain you want to check as follows
# you can have multiple arDdnsCheck blocks

readConfig() {
    local line=""
    while read line;do
        # echo $line
        arToken=$arToken,$line
    done < config
    arToken=${arToken#*,}
}

main() {
    readConfig
    # echo "$arToken"
    # IPv4:
    echo "Updating IPv4 record"
    arDdnsCheck "revengenow.top" "update"

    # IPv6:
    if [ $updateIPv6 = true ];then
        echo "Updating IPv6 record"
        arDdnsCheck "revengenow.top" "subdomain6" 6
    fi
}; main


