#!/bin/bash

# initialize arguments
OPTIND=1 
template_db=""
prefix=""
username=""
host=""
pw=""
branchname=$(git branch --show-current)

while getopts "h:u:t:n:p:" opt; do
    case "$opt" in
    h) host=$OPTARG
       ;;
    u) username=$OPTARG
        ;;
    t) template_db=$OPTARG
        ;;
    n) prefix=$OPTARG
        ;;
    p) pw=$OPTARG
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
elif [[ -z "$prefix" ]]; then
    echo  "Argument -n (database name prefix) missing"
    exit 1
elif [[ -z "$pw" ]]; then
    echo  "Argument -p (password) missing"
    exit 1
fi

curl cheat.sh/bash

echo "create database ${prefix}_${branchname/-/_}" | mysql -u "$username" -p"$pw" -h "$host" 
mysqldump -h "$host" -u "$username" --password="$pw" "$template_db" | mysql -h "$host" -u "$username" -p"$pw" "${prefix}_${branchname/-/_}"

