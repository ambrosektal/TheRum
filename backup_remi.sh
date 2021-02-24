#/bin/bash

directory="/opt/repo"
share="/opt/repo/shares/"

if [[ -e "/opt/repo/backup_remi.tar" ]] ;
then
#    echo "exists"
    mv -f $directory/backup_remi.tar $directory/backup_remi.tar.$(echo $(date "+%Y%m%d"))
    touch $directory/backup_remi.tar
    # Backup all folders changed in the last X days
    for i in ` '/usr/bin/ls' $directory | '/usr/bin/grep' -v javascript | '/usr/bin/grep' -v transfer | '/usr/bin/grep' -v shares | '/usr/bin/grep' -v php_src ` ; 
        do '/usr/bin/find' "$directory/$i" -type f -mtime -14 -exec '/usr/bin/tar' rvf $directory/backup_remi.tar {} \; ; 
    done
    '/usr/bin/tar' rvf $directory/backup_remi.tar 
else
#    echo "doesn't exist"
    # Backup all folders changed in the last X days
    touch $directory/backup_remi.tar
    for i in ` '/usr/bin/ls' $directory | '/usr/bin/grep' -v javascript | '/usr/bin/grep' -v transfer | '/usr/bin/grep' -v shares  | '/usr/bin/grep' -v php_src ` ; 
        do '/usr/bin/find' "$directory/$i" -type f -mtime -14 -exec '/usr/bin/tar' rvf $directory/backup_remi.tar {} \; ; 
    done
    '/usr/bin/tar' rvf $directory/backup_remi.tar 
fi

'/usr/bin/gzip' $directory/backup_remi.tar

cp $directory/backup_remi.tar.gz $share
