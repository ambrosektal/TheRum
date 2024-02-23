# I think I've over complicated this....

## Testing


#############################################################################################
###################                                                       ###################
###################                                                       ###################
###################################### Archive Verdaccio ####################################

sudo su

npmdate=$(date '+%Y%m%d')
mkdir -p /mnt/d/Transfer/$(echo $npmdate)

# ### Grab the files from the verdaccio container and gpg encrypt them
# find /mnt/d/Transfer/software/verdaccio/storage ! -name "package.json" -ctime -5 -type f -print0 | tar --null -czf - -T - | gpg --batch --passphrase YourPassphrase --symmetric --cipher-algo aes256 -o "/mnt/d/Transfer/Prep/$(date '+%Y%m%d')_storage_nopack_45.tar.gz.gpg"

# ### Grab the files from the npm cache and gpg encrypt them
# find /mnt/d/Transfer/ToMove/npmcache -ctime -5 -type f -print0 | tar --null -czf - -T - | gpg --batch --passphrase YourPassphrase --symmetric --cipher-algo aes256 -o "/mnt/d/Transfer/Prep/$(date '+%Y%m%d')_npm_cache.tar.gz.gpg"


# ### Grab the files from the nodepack folder and gpg encrypt them
# find /mnt/d/Transfer/ToMove/nodepack -ctime -5 -type f -print0 | tar --null -czf - -T - | gpg --batch --passphrase YourPassphrase --symmetric --cipher-algo aes256 -o "/mnt/d/Transfer/Prep/$(date '+%Y%m%d')_nodepack.tar.gz.gpg"



# npmdate=$(date '+%Y%m%d')
# mkdir -p /mnt/d/Transfer/$(echo $npmdate)
# # New test that removes package.json
# # npmdate=$(date '+%Y%m%d')
# # sudo find /mnt/d/Transfer/software/verdaccio/storage ! -name "package.json" -ctime -15 -type f -print0  | tar czf /mnt/d/Transfer/Prep/$(echo $npmdate)_storage_nopack_45.tar.gz --null --files-from=- 
find /mnt/d/Transfer/software/verdaccio/storage ! -name "package.json" -ctime -10 -type f -print0  | tar czf /mnt/d/Transfer/Prep/$(echo $npmdate)_storage_nopack_45.tar.gz --null --files-from=- 
find /mnt/d/Transfer/ToMove/npmcache -ctime -7 -type f -print0 | tar czf /mnt/d/Transfer/Prep/$(echo $npmdate)_npmcache.tar.gz --null --files-from=- 
find /mnt/d/Transfer/ToMove/nodepack -ctime -7 -type f -print0 | tar czf /mnt/d/Transfer/Prep/$(echo $npmdate)_nodepack.tar.gz --null --files-from=- 
# find /mnt/d/.pnpm-store/v3 -ctime -7 -type f -print0 | tar czf /mnt/d/Transfer/Prep/$(echo $npmdate)_pnpm.tar.gz --null --files-from=- 


# # find /mnt/d/Transfer/software/verdaccio/storage ! -name "package.json" -cmin -120 -type f -print0  | tar czf /mnt/d/Transfer/Prep/$(echo $npmdate)_storage_nopack_45.tar.gz --null --files-from=- 

# # gpg --symmetric --cipher-algo aes256 -o myarchive.tar.gz

# # sudo find /mnt/d/Transfer/software/verdaccio/storage -ctime -15 -type f -print0  | tar czf /mnt/d/Transfer/Prep/$(echo $npmdate)_storage.tar.gz --null --files-from=- 
# find /mnt/d/Transfer/software/verdaccio/storage -ctime -3 -type f -print0  | tar czf /mnt/d/Transfer/Prep/$(echo $npmdate)_storage.tar.gz --null --files-from=- 

# # sudo 7za a -v8128M -psimnet1 /mnt/d/Transfer/$(echo $npmdate)/$(echo $npmdate)_storage_nopack_45.tar.7z /mnt/d/Transfer/Prep/$(echo $npmdate)_storage_nopack_45.tar.gz
# # sudo 7za a -v700M -psimnet1 /mnt/d/Transfer/$(echo $npmdate)/$(echo $npmdate)_storage_nopack_45.tar.7z /mnt/d/Transfer/Prep/$(echo $npmdate)_storage_nopack_45.tar.gz
# 7za a -v700M -psimnet1 /mnt/d/Transfer/$(echo $npmdate)/$(echo $npmdate)_storage_nopack_45.tar.7z /mnt/d/Transfer/Prep/$(echo $npmdate)_storage_nopack_45.tar.gz

# # sudo 7za a -v8128M -psimnet1 /mnt/d/Transfer/$(echo $npmdate)/$(echo $npmdate)_storage.tar.7z /mnt/d/Transfer/Prep/$(echo $npmdate)_storage.tar.gz
# # sudo 7za a -v700M -psimnet1 /mnt/d/Transfer/$(echo $npmdate)/$(echo $npmdate)_storage.tar.7z /mnt/d/Transfer/Prep/$(echo $npmdate)_storage.tar.gz
# 7za a -v700M -psimnet1 /mnt/d/Transfer/$(echo $npmdate)/$(echo $npmdate)_storage.tar.7z /mnt/d/Transfer/Prep/$(echo $npmdate)_storage.tar.gz

###################################### Archive Verdaccio ####################################
###################                                                       ###################
###################                                                       ###################
#############################################################################################




#############################################################################################
###################                                                       ###################
###################                                                       ###################
###################################### Archive Gems ####################################
# Container
find / -iname "*.gem" -type f -exec cp {} /opt/repo/ \;
# find / -iname "*.gem" -ctime -2 -type f -exec cp {} /opt/repo/ \;

# Local 
sudo su

gemdate=$(date '+%Y%m%d')
mkdir -p /mnt/d/Transfer/$(echo $gemdate)
# New test that removes package.json

find /mnt/d/Transfer/ToMove/repo -iname "*.gem" -type f -exec cp {} /mnt/d/Transfer/ToMove/repo/gems/ \;
# find /mnt/d/Transfer/ToMove/repo/ruby* -iname "*.gem" -type f -exec cp {} /mnt/d/Transfer/ToMove/repo/gems/ \;

find /mnt/d/Transfer/ToMove/repo/gems -iname "*.gem" -ctime -3 -type f -print0  | tar czf /mnt/d/Transfer/Prep/$(echo $gemdate)_gems.tar.gz --null --files-from=- 


find /mnt/d/Transfer/ToMove/repo/rubylatest/gemstash -ctime -3 -type f -print0  | tar czf /mnt/d/Transfer/Prep/$(echo $gemdate)_gemstash.tar.gz --null --files-from=- 

# sudo 7za a -v8128M -psimnet1 /mnt/d/Transfer/$(echo $gemdate)/$(echo $gemdate)_gems.tar.7z /mnt/d/Transfer/Prep/$(echo $gemdate)_gems.tar.gz
# sudo 7za a -v700M -psimnet1 /mnt/d/Transfer/$(echo $gemdate)/$(echo $gemdate)_gems.tar.7z /mnt/d/Transfer/Prep/$(echo $gemdate)_gems.tar.gz
7za a -v700M -psimnet1 /mnt/d/Transfer/$(echo $gemdate)/$(echo $gemdate)_gems.tar.7z /mnt/d/Transfer/Prep/$(echo $gemdate)_gems.tar.gz

###################################### Archive Gems ####################################
###################                                                       ###################
###################                                                       ###################
#############################################################################################



# ---------------------

# find /mnt/d/Transfer/ToMove/software/verdaccio/storage -mtime -3 -type f -print0  | tar czf /mnt/d/Transfer/ToMove/software/verdaccio/$(echo $npmdate)_storage.tar.gz --files-from=- --null

# ---------------------

# Exactly 188 days ago
npmdate=$(date '+%Y%m%d')
find /mnt/d/Transfer/ToMove/software/verdaccio/storage -mtime 188 -type f -print0  | tar czf /mnt/d/Transfer/ToMove/software/verdaccio/$(echo $npmdate)_missing_storage.tar.gz --files-from=- 

# Between 186 - 190 days ago
npmdate=$(date '+%Y%m%d')
find /mnt/d/Transfer/ToMove/software/verdaccio/storage -mtime +186 -a -mtime -190 -type f -print0  | tar czf /mnt/d/Transfer/ToMove/software/verdaccio/$(echo $npmdate)_missing_storage.tar.gz --files-from=- 

# Between dates
find -newerct "14 Sep 2022" ! -newerct "18 Sep 2022" -ls
find -newermt "14 Sep 2022" ! -newermt "18 Sep 2022" -ls

# all tgz files owned by user 10001 in the last 190 days
npmdate=$(date '+%Y%m%d')
sudo find /mnt/d/Transfer/ToMove/software/verdaccio/storage -iname "*.tgz" -mtime -190 -user 10001 -type f -print0  | tar czf /mnt/d/Transfer/ToMove/software/verdaccio/$(echo $npmdate)_10001_missing_storage.tar.gz --files-from=- 



###################################################################

# Running in wsl

# Variables
newerThan=30
olderThan=31

# Set permissions on folders and files
sudo chown -R ambrose:ambrose /mnt/d/Transfer/ToMove/software/verdaccio/

# Copy changed directories, while maintaining timestamps, to another folder.
cp -r -p /mnt/d/Transfer/ToMove/software/verdaccio/storage/data/* /mnt/d/Transfer/ToMove/software/verdaccio/backup/storage/

# Remove all tgz files that older than "olderThan" days
find /mnt/d/Transfer/ToMove/software/verdaccio/backup/storage/ -iname "*.tgz" -type f -mtime +"$olderThan" -delete

# # Remove the package.jsons and tgzs that are older than $olderthan
# find /mnt/d/Transfer/ToMove/software/verdaccio/backup/storage/ -type f -mtime +"$olderThan" -delete

# Clean up files
## Only tar folders with tgzs and not just package.jsons
find /mnt/d/Transfer/ToMove/software/verdaccio/backup/storage/ -iname "*.tgz" > tgzFiles
cat tgzFiles |  sed 's/\/mnt\/d\/Transfer\/ToMove\/software\/verdaccio\/backup\/storage//' | cut -d '/' -f2 | sort -u | sort -u > keepFiles
mkdir /mnt/d/Transfer/ToMove/software/verdaccio/backup/clean/
for i in ` cat keepFiles ` ; do mv /mnt/d/Transfer/ToMove/software/verdaccio/backup/storage/"$i" /mnt/d/Transfer/ToMove/software/verdaccio/backup/clean/ ; done
rm -rf /mnt/d/Transfer/ToMove/software/verdaccio/backup/storage
mv /mnt/d/Transfer/ToMove/software/verdaccio/backup/clean /mnt/d/Transfer/ToMove/software/verdaccio/backup/storage
du -cksh /mnt/d/Transfer/ToMove/software/verdaccio/backup/storage

# Tar the files up
npmdate=$(date '+%Y%m%d')
tar czvf /mnt/d/Transfer/ToMove/software/verdaccio/storage/data/$(echo $npmdate)_storage.tar.gz /mnt/d/Transfer/ToMove/software/verdaccio/backup/storage/


###################################################################


# Variables
newerThan=3
olderThan=4

# Number of new tgz files added in the last "newerThan" days
# find /verdaccio/storage/data/* -iname "*.tgz" -type f -mtime -"$newerThan" | wc -l

# Number of directories changed in the last "newerThan" days
# find /verdaccio/storage/data/* -type d -mtime -"$newerThan" | wc -l

# Copy changed directories, while maintaining timestamps, to another folder.
# find /verdaccio/storage/data/* -type d -mmin -360 -exec cp -r -p {} /opt/verdaccio/backup/storage/ \;
find /verdaccio/storage/data/\@* -type d -exec cp -r -p {} /opt/verdaccio/backup/storage/ \;
find /verdaccio/storage/data/* -type d -mtime -"$newerThan" -exec cp -r -p {} /opt/verdaccio/backup/storage/ \;

# Find the number of tgz files that older than "olderThan" days
# find /opt/verdaccio/backup/storage/ -iname "*.tgz" -type f -mmin +361 | wc -l
find /opt/verdaccio/backup/storage/ -iname "*.tgz" -type f -mtime +"$olderThan" | wc -l

# Remove all tgz files that older than "olderThan" days
# find /opt/verdaccio/backup/storage/ -iname "*.tgz" -type f -mtime +"$olderThan" -exec rm -f {} \;
# find /opt/verdaccio/backup/storage/ -iname "*.tgz" -type f -mmin +361 -delete
find /opt/verdaccio/backup/storage/ -iname "*.tgz" -type f -mtime +"$olderThan" -delete


# # Remove the package.jsons
# find /opt/verdaccio/backup/storage/ -type f -mtime +"$olderThan" -delete

#Clean up files
find /opt/verdaccio/backup/storage/* -iname "*.tgz" > tgzFiles
cat tgzFiles |  sed 's/\/opt\/verdaccio\/backup\/storage//' | cut -d '/' -f2 | sort -u | sort -u > keepFiles
mkdir /opt/verdaccio/backup/clean
for i in ` cat keepFiles ` ; do mv /opt/verdaccio/backup/storage/"$i" /opt/verdaccio/backup/clean/ ; done
rm -rf /opt/verdaccio/backup/storage
mv /opt/verdaccio/backup/clean /opt/verdaccio/backup/storage
du -cksh /opt/verdaccio/backup/storage


# Tar the files up
npmdate=$(date '+%Y%m%d')
tar czvf /verdaccio/storage/data/$(echo $npmdate)_storage.tar.gz /opt/verdaccio/backup/storage/
# mv $(echo $npmdate)_storage.tar.gz /verdaccio/storage/data/


# docker cp cranky_margulis:/opt/verdaccio/20220913_storage.tar.gz .

###################################################################

# Running in wsl

# Variables
newerThan=14
olderThan=15

# Copy changed directories, while maintaining timestamps, to another folder.
find /mnt/d/Transfer/ToMove/software/verdaccio/storage/data/\@* -type d -exec cp -r -p {} /mnt/d/Transfer/ToMove/software/verdaccio/backup/storage/ \;
find /mnt/d/Transfer/ToMove/software/verdaccio/storage/data/* -type d -mtime -"$newerThan" -exec cp -r -p {} /mnt/d/Transfer/ToMove/software/verdaccio/backup/storage/ \;
# find /mnt/d/Transfer/ToMove/software/verdaccio/storage/data/* -type d -exec cp -r -p {} /mnt/d/Transfer/ToMove/software/verdaccio/backup/storage/ \;

# Find the number of tgz files that older than "olderThan" days
find /mnt/d/Transfer/ToMove/software/verdaccio/backup/storage/ -iname "*.tgz" -type f -mtime +"$olderThan" | wc -l

# Remove all tgz files that older than "olderThan" days
find /mnt/d/Transfer/ToMove/software/verdaccio/backup/storage/ -iname "*.tgz" -type f -mtime +"$olderThan" -delete

# # Remove the package.jsons
# find /mnt/d/Transfer/ToMove/software/verdaccio/backup/storage/ -type f -mtime +"$olderThan" -delete

#Clean up files
find /mnt/d/Transfer/ToMove/software/verdaccio/backup/storage/* -iname "*.tgz" > tgzFiles
cat tgzFiles |  sed 's/\/mnt\/d\/Transfer\/ToMove\/software\/verdaccio\/backup\/storage//' | cut -d '/' -f2 | sort -u | sort -u > keepFiles
mkdir /mnt/d/Transfer/ToMove/software/verdaccio/backup/clean/
for i in ` cat keepFiles ` ; do mv /mnt/d/Transfer/ToMove/software/verdaccio/backup/storage/"$i" /mnt/d/Transfer/ToMove/software/verdaccio/backup/clean/ ; done
rm -rf /mnt/d/Transfer/ToMove/software/verdaccio/backup/storage
mv /mnt/d/Transfer/ToMove/software/verdaccio/backup/clean /mnt/d/Transfer/ToMove/software/verdaccio/backup/storage
du -cksh /mnt/d/Transfer/ToMove/software/verdaccio/backup/storage


# Tar the files up
npmdate=$(date '+%Y%m%d')
tar czvf /mnt/d/Transfer/ToMove/software/verdaccio/storage/data/$(echo $npmdate)_storage.tar.gz /mnt/d/Transfer/ToMove/software/verdaccio/backup/storage/


###################################################################



# Deleting files from a specific date
## From 5 days ago - not 4 and not 6. only 5 days.
find backup/storage/ -iname "*.tgz" -mtime 5  -delete

## ls -latr /verdaccio/storage/data/* | grep 'Apr 20' | awk -F " " '{print $9}' >> files
## ls -latr /verdaccio/storage/data/* | grep 'Apr 21' | awk -F " " '{print $9}' >> files
## ls -latr /verdaccio/storage/data/* | grep 'Apr 22' | awk -F " " '{print $9}' >> files
## ls -latr /verdaccio/storage/data/* | grep 'Apr 23' | awk -F " " '{print $9}' >> files
## grep "tgz" files > tgzfiles
## sort -u tgzfiles > cleantgzfiles
## for i in  $(cat cleantgzfiles) ; do find ./backup/storage/ -iname $i -delete  ; done

#directory notes
find /opt/verdaccio/backup/storage/ -iname "package.json" -exec rm -f {} \;
find /opt/verdaccio/backup/storage/ -empty -type d -delete

##for i in $(find /opt/verdaccio/backup/storage/* -type d )
#find /opt/verdaccio/backup/storage/* -type d -exec cp -r -p /verdaccio/storage/data/"$i" /opt/verdaccio/backup/storage/ \;


# Date notes
# put current date as yyyy-mm-dd in $date
date=$(date '+%Y-%m-%d')

# put current date as yyyy-mm-dd HH:MM:SS in $date
date=$(date '+%Y-%m-%d %H:%M:%S')

# print current date directly
echo $(date '+%Y-%m-%d')


# vite app creation

npm create vite@latest my-svelte-app -- --template svelte
npm create vite@latest my-svelte-ts-app -- --template svelte-ts
npm create vite@latest my-preact-app -- --template preact
npm create vite@latest my-preact-ts-app -- --template preact-ts
npm create vite@latest my-lit-app -- --template lit
npm create vite@latest my-lit-ts-app -- --template lit-ts
npm create vite@latest my-react-app -- --template react
npm create vite@latest my-react-ts-app -- --template react-ts
npm create vite@latest my-vanilla-ts-app -- --template vanilla-ts
npm create vite@latest my-vanilla-app -- --template vanilla
npm create vite@latest my-vue-ts-app -- --template vue-ts
npm create vite@latest my-vue-app -- --template vue
 
npx create-react-app@latest that
