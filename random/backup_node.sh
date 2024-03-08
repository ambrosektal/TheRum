#/bin/bash
# -Acdtrux
repo="/opt/repo/"
directory="/home/ambrose/Downloads/verdaccio/storage/"
share='/opt/repo/shares/'

if [[ -e "/opt/repo/backup_node.tar" ]] ;
then
#    echo "exists"
    mv -f $repo/backup_node.tar $repo/backup_node.tar.$(echo $(date "+%Y%m%d"))
    # Backup all folders changed in the last X days
    touch $directory/backup_node.tar
    '/usr/bin/find' "$directory" -type f -mtime -14 -exec '/usr/bin/tar' rvf $repo/backup_node.tar {} \;  
    '/usr/bin/gzip' $repo/backup_node.tar 
else
#    echo "doesn't exist"
    # Backup all folders changed in the last X days
    touch $directory/backup_node.tar
    '/usr/bin/find' "$directory" -type f -mtime -14 -exec '/usr/bin/tar' rvf $repo/backup_node.tar {} \;
    '/usr/bin/gzip' $repo/backup_node.tar 
fi

cp $repo/backup_node.tar.gz $share/
