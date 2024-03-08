#!/bin/bash

echo Dependency Update script started at $(date) >> /var/log/dependency-update-repository.log

dir="$1"

deps=""

function findingDeps() {
    dnf repoquery --deplist "$1" | grep "provider: " | awk -F " " '{print $2}'
}

function downloadMe() {
    dnf download -y "$1" --resolve --downloaddir="$2" | pv -t -e -b > /dev/null
}

deps+=$(find "$dir" -type f -iname "*.rpm" -print0 | while read -r -d $'\0' file; do echo "$(findingDeps "$file")"; done | sort -u)

cleanDeps=$(echo "$deps" | sort -u)

total=$(echo "$cleanDeps" | wc -l)
count=0
echo "$cleanDeps" | while read -r line; do 
    count=$((count+1))
    echo "Downloading dependency $count of $total: $(basename "$line")"
    downloadMe "$(basename "$line")" "$dir" &
done

wait

echo Dependency Update script ended at $(date) >> /var/log/dependency-update-repository.log
