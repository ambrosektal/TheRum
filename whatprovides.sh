#!/bin/bash
#function findingDeps() {
#    for j in $(rpm -qR "$1");
#        do rpm -q --whatprovides "$j";
#            done | sort | uniq | grep -v "no package provides" | sort -u  ;
#                 }
#findingDeps $1        


#function findingDeps() {
#        a=$( echo "$1" | awk -F "-[0-9]" '{print $1}' )
#        yum deplist "$a" | grep provider | awk -F ": " {'print $2'} >> /root/remi/config/depdeplist;
#        cat /root/remi/config/depdeplist | awk -F " " '{print $1}' >> /root/remi/config/depdeps_u;
#        sort -u /root/remi/config/depdeps_u > /root/remi/config/depdeps_u_clean
#        mv -f /root/remi/config/depdeps_u_clean /root/remi/config/depdeps_u
#        cat /root/remi/config/depdeps_u >> /root/remi/config/deps_u;
#        echo "deps_u has $(wc -l /root/remi/config/deps_u) files:::  "
#}

function findingDeps() {
        a=$( echo "$1" | awk -F "-[0-9]" '{print $1}' )
        yum deplist "$a" | grep provider | awk -F ": " {'print $2'} | awk -F " " '{print $1}' | sort -u 
}

findingDeps $1
