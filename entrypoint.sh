#!/bin/bash

# initialize arguments
OPTIND=1 
template_db=""
name=""
username=""
host=""
pw=""
branchname=$(git branch --show-current)

while getopts "h:u:t:n:p:" opt; do
    case "$opt" in
    h) host=${OPTARG//[[:blank:]]/}
       ;;
    u) username=${OPTARG//[[:blank:]]/}
        ;;
    t) template_db=${OPTARG//[[:blank:]]/}
        ;;
    n) name=${OPTARG//[[:blank:]]/}
        ;;
    p) pw=${OPTARG//[[:blank:]]/}
        ;;
    *) exit 1
    esac
done

shift $((OPTIND - 1))

[ "${1:-}" = "--" ] && shift

if [[ -z "$template_db" ]]; then
    echo  "Argument -t (template database) missing"
    exit 1
elif [[ -z "$username" ]]; then
    echo  "Argument -u (username) missing"
    exit 1
elif [[ -z "$host" ]]; then
    echo  "Argument -h (host) missing"
    exit 1
elif [[ -z "$name" ]]; then
    echo  "Argument -n (database name) missing"
    exit 1
elif [[ -z "$pw" ]]; then
    echo  "Argument -p (password) missing"
    exit 1
fi

echo "create database ${name//-/_}" | mysql -u "$username" -p"$pw" -h "$host" 
mysqldump -h "$host" -u "$username" --password="$pw" "$template_db" | mysql -h "$host" -u "$username" -p"$pw" "${name//-/_}"

