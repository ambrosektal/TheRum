#!/bin/bash

rm -rf /root/remi/config/*
#touch /root/remi/config/deps_u


function fileExists() {
	if [[ -f "$1" ]]
	then
	    echo "$1 exists on your filesystem."
	fi
}
function findingDeps() {
	a=$( echo "$1" | awk -F "-[0-9]" '{print $1}' )
#	for j in $(rpm -qR "$a");
#		do rpm -q --whatprovides "$j";
#			done | sort | uniq | grep -v "no package provides" | sort -u >> /root/remi/config/depdeps ;
	yum deplist "$a" | grep provider | awk -F ": " {'print $2'} | awk -F " " '{print $1}' | sort -u >> /root/remi/config/deps_u;
	echo "deps_u has $(wc -l /root/remi/config/deps_u) files:::  "
	
}

function downloadDeps(){ 
	if [ -z $1 ]
	then 
		echo "You Must enter write the command like this:  "
		echo "downloadMe.sh <Package_to_Download> <Number_of_recursive_dependency_levels>"
		echo "downloadMe.sh httpd 5"
		echo
		echo
		echo
		exit
	fi

	if [ -z $2 ]
	then 
		echo "You didn't enter the recursion level!!!"
		echo "You Must enter write the command like this:  "
		echo "downloadMe.sh <Package_to_Download> <Number_of_recursive_dependency_levels>"
		echo "downloadMe.sh httpd 5"
		echo
		echo
		echo
		exit
	fi

#	echo "" > /root/remi/config/deps
#	echo "" > /root/remi/config/depdeps
#	echo "" > /root/remi/config/deps_u_cleaned
#	echo "" > /root/remi/config/deps_cleaned
	#echo "" > /root/remi/config/deps_u
#	echo "" > /root/remi/config/depdeps_u
#	echo "" > /root/remi/config/depdeplist
#	echo "" > /root/remi/config/deps_u_comma

	k=0
	findingDeps "$1"
	echo "recursion is equal to::  $2"
	while [ "$k" -lt "$2" ]
		do for i in $(cat /root/remi/config/deps_u); 
			do findingDeps "$i";
				done;
		k=$[$k+2]
		echo "recursion is equal to::  $k"
		echo "Levels to go::  $[$2-$k]"
	done
}		

#	sort -u /root/remi/config/deps_u > /root/remi/config/deps_u_clean
#        mv -f /root/remi/config/deps_u_clean /root/remi/config/deps_u

#	for i in $(cat /root/remi/config/deps_u);
#                do yumdownloader -y "$i" --downloadonly ;
#                done;



downloadDeps "$1" "$2"


#sort -u /root/remi/config/deps_u > /root/remi/config/deps_u_clean
#mv -f /root/remi/config/deps_u_clean /root/remi/config/deps_u

# I keep losing connection when I leave this running overnight
# This logs the parent file that is getting deps downloaded/searched for.

if [ ! -z "$1" ]
    then
        echo "Downloading deps for $1" >> /var/log/update-repository.log
fi

# Reports to STDOUT how many deps are being downloaded for each file.
echo "Discovered $(wc -l /root/remi/config/deps_u) dependeincies"

for i in $(cat /root/remi/config/deps_u);
	do yumdownloader -y "$i" --downloadonly ;
	done;
echo "" > /root/remi/config/deps_u
