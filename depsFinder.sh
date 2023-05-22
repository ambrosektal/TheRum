#!/bin/bash

deps=""

function findingDeps() {
	dnf repoquery --deplist "$1" | grep "provider: " | awk -F " " '{print $2}'
}

deps+=" $(findingDeps "$1" | sort -u)"
echo "$deps"

# # I keep losing connection when I leave this running overnight
# # This logs the parent file that is getting deps downloaded/searched for.

# if [ ! -z "$1" ]
#     then
#         echo "Downloading deps for $1" >> /var/log/update-repository.log
# fi

# # Reports to STDOUT how many deps are being downloaded for each file.
# # echo "Discovered $(wc -l "$filename") dependencies"

# for i in "$deps" ;
# 	do dnf download -y "$i" --resolve --downloaddir=/opt/repo/depRepo ;
# 	done;
