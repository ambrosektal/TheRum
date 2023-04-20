#!/bin/bash

# rm -rf /root/remi/config/el8/*
#touch $filename
filename=$(mktemp /root/remi/config/el8/XXXXXXXXXXXX_deps_u)
# touch "$filename"

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
#			done | sort | uniq | grep -v "no package provides" | sort -u >> /root/remi/config/el8/depdeps ;
	yum deplist "$a" | grep provider | awk -F ": " {'print $2'} | awk -F " " '{print $1}' | sort -u >> "$filename";
	echo "$filename has $(wc -l "$filename") files:::  "
	
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

#	echo "" > /root/remi/config/el8/deps
#	echo "" > /root/remi/config/el8/depdeps
#	echo "" > $filename_cleaned
#	echo "" > /root/remi/config/el8/deps_cleaned
	#echo "" > $filename
#	echo "" > /root/remi/config/el8/dep$filename
#	echo "" > /root/remi/config/el8/depdeplist
#	echo "" > $filename_comma

	k=0
	findingDeps "$1"
	echo "recursion is equal to::  $2"
	while [ "$k" -lt "$2" ]
		do for i in $(cat "$filename"); 
			do findingDeps "$i";
				done;
		k=$[$k+2]
		echo "recursion is equal to::  $k"
		echo "Levels to go::  $[$2-$k]"
	done
}		

#	sort -u $filename > $filename_clean
#        mv -f $filename_clean $filename

#	for i in $(cat $filename);
#                do yumdownloader -y "$i" --downloadonly ;
#                done;



downloadDeps "$1" "$2"


#sort -u $filename > $filename_clean
#mv -f $filename_clean $filename

# I keep losing connection when I leave this running overnight
# This logs the parent file that is getting deps downloaded/searched for.

if [ ! -z "$1" ]
    then
        echo "Downloading deps for $1" >> /var/log/update-repository.log
fi

# Reports to STDOUT how many deps are being downloaded for each file.
echo "Discovered $(wc -l "$filename") dependencies"

for i in $(cat "$filename");
	# do yumdownloader -y "$i" --downloadonly ;
	do dnf download -y "$i" --resolve ;
	done;
# echo "" > $filename
