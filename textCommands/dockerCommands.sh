
# Starting minikube with a mounted drive and 200GB of space
# minikube start --mount --mount-string="D:\Transfer\ToMove\repo\minikube:/mnt/minikube" --disk-size=200GB
minikube.exe start --mount-string="D:\Transfer:/opt/Transfer" --disk-size 200GB


# Using 7zip to cycle through directories to 7zip them.
$(gci -directory . ) | foreach { & ${env:ProgramFiles}\7-Zip\7z.exe a -psimnet1 "$($_.name).7z" $_ }

docker images
# Find container name
docker container ls
# ReTag
docker commit cranky_margulis verdaccio_transfer
# Verify new name
docker container ls
docker images
# Tag docker image
docker image tag verdaccio_transfer ambrosektal/verdaccio_transfer:latest
# Push to docker.io
docker image push ambrosektal/verdaccio_transfer:latest

#docker pull ambrosektal/verdaccio_transfer:latest

docker run --name cranky_margulis -p 4873:4873 verdaccio/verdaccio
# docker run -it --rm --name verdaccio --env "VERDACCIO_PROTOCOL=https" -p 4873:4873 verdaccio/verdaccio
# Docker Compose Example
services:
  verdaccio:
    # image: verdaccio/verdaccio:nightly-master
	image: verdaccio/verdaccio:latest
    # container_name: verdaccio-docker-local-storage-vol
	container_name: cranky_margulis
    ports:
      - '4873:4873'
    volumes:
      - './storage:/verdaccio/storage'
      - './conf:/verdaccio/conf'
volumes:
  verdaccio:
    driver: local


# docker run --rm --name nuget-server -p 5555:80 --env-file baget.env -v "$(pwd)/packages:/var/baget" loicsharma/baget:latest

docker run -d --name nuget-server -p 5555:80 --env-file baget.env -v "$(pwd):/var/baget" loicsharma/baget:latest

docker run -d --name PowerShell-server -p 7777:80 --env-file baget.env -v "$(pwd)/poshpackages:/var/baget" loicsharma/baget:latest

# https://www.powershellgallery.com/api/v2

docker run -d --name AzureDev-server -p 9999:80 --env-file baget.env -v "$(pwd)/AzurePackages:/var/baget" loicsharma/baget:latest

docker run -d --name AzureNuget-server -p 9889:80 --env-file baget.env -v "$(pwd)/AzureNuGetPackages:/var/baget" ambrosektal/azurenuget_baget:latest

# docker run -d --name AzureNuget-server -p 9889:80 --env-file baget.env -v "D:\Transfer\ToMove\BaGet_Shared\AzurePackages:/var/baget" ambrosektal/azurenuget_baget:latest

docker run  --name cranky_margulis -p 4873:4873 -v "D:\Transfer\software\verdaccio\storage\data:/verdaccio/storage/data" verdaccio/verdaccio:latest

docker run -it -v D:\Transfer\ToMove\repo\docker\el8:/opt/repo/docker  -v D:\Transfer\ToMove\repo\opennms\el8:/opt/repo/opennms -v D:\Transfer\ToMove\repo\gitlab\el8:/opt/repo/gitlab -v D:\Transfer\ToMove\repo\depRepo\el8:/opt/repo/depRepo -v D:\Transfer\ToMove\repo\remi\el8:/opt/repo/remi -v D:\Transfer\ToMove\repo\configs\el8:/opt/repo/configs registry.access.redhat.com/ubi8/ubi:latest /bin/bash


docker run -it -v D:\Transfer\ToMove\repo\docker\el7:/opt/repo/docker  -v D:\Transfer\ToMove\repo\opennms\el7:/opt/repo/opennms -v D:\Transfer\ToMove\repo\gitlab\el7:/opt/repo/gitlab -v D:\Transfer\ToMove\repo\depRepo\el7:/opt/repo/depRepo -v D:\Transfer\ToMove\repo\remi\el7:/opt/repo/remi -v D:\Transfer\ToMove\repo\configs\el7:/opt/repo/configs  registry.access.redhat.com/ubi7/ubi:latest /bin/bash


docker run -it -v D:\Transfer\ToMove\repo\docker\debian:/opt/repo/docker  -v D:\Transfer\ToMove\repo\opennms\el8:/opt/repo/opennms -v D:\Transfer\ToMove\repo\gitlab\el8:/opt/repo/gitlab -v D:\Transfer\ToMove\repo\depRepo\el8:/opt/repo/depRepo -v D:\Transfer\ToMove\repo\remi\el8:/opt/repo/remi -v D:\Transfer\ToMove\repo\configs\el8:/opt/repo/configs registry.access.redhat.com/ubi8/ubi:latest /bin/bash


docker run -it -v D:\Transfer\ToMove\repo\debian\lens:/opt/repo/lens  -v D:\Transfer\ToMove\repo\debian\compass:/opt/repo/compass -v D:\Transfer\ToMove\repo\debian\mattermost:/opt/repo/mattermost debian:latest /bin/bash




docker images
# Find container name
docker container ls
# ReTag
docker commit nuget-server baget_transfer
#docker commit agitated_hellman baget_transfer
# Verify new name
docker container ls
docker images
# Tag docker image
docker image tag baget_transfer ambrosektal/baget_transfer:latest
# Push to docker.io
docker image push ambrosektal/baget_transfer:latest

# PLATFORMS = ["win32", "linux", "linux-deb", "linux-rpm", "darwin", "linux-snap", "server-linux","cli-linux","cli-win32","server-win32"]

# is it not connecting? Not pulling extensions? maybe this will work???
# docker run -it -v 'D:\Transfer\ToMove\software\vscodeoffline\artifacts:/artifacts' lolinternet/vscsync:latest sh
# docker run -it -v 'D:\Transfer\software\vscodeoffline\artifacts:/artifacts' ambrosektal/vscsync:latest sh
docker run -it -d -v 'D:\Transfer\software\vscodeoffline\artifacts:/artifacts' ambrosektal/vscsync:20231115


# Start vsync 
# python sync.py --check-recommended-extensions --check-specified-extensions --check-binaries --check-insider --update-binaries --update-malicious --update-extensions --artifacts /artifacts

python sync.py --check-recommended-extensions --check-specified-extensions --check-binaries --update-binaries --update-extensions  --update-malicious --artifacts /artifacts

python sync.py --check-recommended-extensions --check-specified-extensions --update-extensions --artifacts /artifacts --update-malicious
python sync.py --check-specified-extensions --update-extensions --artifacts /artifacts --update-malicious

python sync.py --skip-binaries --check-specified-extensions --update-malicious --update-extensions --artifacts /artifacts


###################
# Pull every Target Platform of an extensions

$files = $(gc latest.json | convertfrom-json)

($files.versions).foreach({$(mkdir C:\Users\joesp\Downloads\Transfer\ToMove\software\vscodeoffline\artifacts\extensions\ms-dotnettools.csharp\$($_.version)\$($_.targetPlatform) ) })

($files.versions).foreach({$(cd C:\Users\joesp\Downloads\Transfer\ToMove\software\vscodeoffline\artifacts\extensions\ms-dotnettools.csharp\$($_.version)\$($_.targetPlatform) && ($_.files.source).foreach({Invoke-WebRequest $_ -OutFile $_.Split("/")[-1]  }) ) })
###################



######################################################################################################################
###################                                                                                ###################
###################                                                                                ###################
###################################### Restart if CPU == 0% for over threshold  ######################################

# Set the container name or ID that you want to monitor
$containerNameOrId = "verdaccio"

# Set the threshold for CPU usage in percentage
$cpuThreshold = 1.0

# Set the duration in seconds for which CPU usage should be below the threshold
$durationThresholdInSeconds = 180

$counter = 0

while ($true) {
    # Get the current CPU usage of the container
    $cpuUsage = (docker stats --no-stream $containerNameOrId | Select-String -Pattern "$containerNameOrId" | ForEach-Object { $_ -split '\s+' } | Select-Object -Index 2).Trim('%')

    if ([float]$cpuUsage -le $cpuThreshold) {
        # If the CPU usage is below the threshold, increment the counter
        $counter++
        Write-Host "CPU usage is below $cpuThreshold% for $($counter*10) seconds."
    } else {
        # If the CPU usage is above the threshold, reset the counter
        $counter = 0
        Write-Host "CPU usage is above $cpuThreshold%. Resetting counter..."
    }

    if ($($counter*10) -ge $durationThresholdInSeconds) {
        Write-Host "CPU usage is below $cpuThreshold% for more than $durationThresholdInSeconds seconds."
        Write-Host "Restarting the container at $(Get-Date)..."
        
        # Stop and then start the container (you may need to adjust this based on your container setup)
        docker stop $containerNameOrId
        docker start $containerNameOrId
    }

    # Sleep for a few seconds before checking again
    Start-Sleep -Seconds 10
}

###################################### Restart if CPU == 0% for over 3 minutes  ######################################
###################                                                                                ###################
###################                                                                                ###################
######################################################################################################################


#############################################################################################
###################                                                       ###################
###################                                                       ###################
###################################### Archive VSCSync ######################################
## Fix for overcomplication and 7z crc errors...


# find /mnt/d/Transfer/software/vscodeoffline/artifacts -ctime -5 -type f -print0 | tar --null -czf - -T - | gpg --batch --passphrase YourPassphrase --symmetric --cipher-algo aes256 -o "/mnt/d/Transfer/Prep/$(date '+%Y%m%d')_vscodeoffline.tar.gz.gpg"

# The "Inappropriate ioctl for device" and "Operation cancelled" errors related to GPG often occur when GPG is trying to interact with a terminal that it doesn't have access to. To resolve these issues, you can try the following:

# 1. **Use `--batch` and `--passphrase` options:** Add the `--batch` option to the `gpg` command to run it in batch mode, and specify the passphrase using the `--passphrase` option. This will prevent GPG from attempting to interact with a terminal:

# ```bash
# find /mnt/d/Transfer/software/vscodeoffline/artifacts -ctime -5 -type f -print0 | tar --null -czf - -T - | gpg --batch --passphrase YourPassphrase --symmetric --cipher-algo aes256 -o "/mnt/d/Transfer/Prep/$(date '+%Y%m%d')_vscodeoffline.tar.gz.gpg"
# ```

# Replace `YourPassphrase` with your actual passphrase.

# 2. **Start the GPG agent:** If you're still facing issues, you can try starting the GPG agent before running the command. You can start the agent by running:

# ```bash
# gpg-agent --daemon
# ```

# Then, run your original command with the GPG agent running.

# 3. **Ensure GPG agent is properly configured:** Make sure that your GPG agent is properly configured, and you have the necessary permissions to use it. You may need to adjust your GPG configuration settings to work in your specific environment.

# Additionally, ensure that you have the necessary permissions to read the files in the `find` command and write to the output directory specified in the `tar` and `gpg` commands.

# If these steps do not resolve the issue, please provide more information about your system environment, GPG configuration, and any specific constraints you're working under so that I can offer more targeted advice.




vscodedate=$(date '+%Y%m%d')

find /mnt/d/Transfer/software/vscodeoffline/artifacts -ctime -4 -type f -print0  | tar czf /mnt/d/Transfer/Prep/$(echo $vscodedate)_vscodeoffline.tar.gz --files-from=- 
# find /mnt/d/Transfer/software/vscodeoffline/artifacts -ctime -5 -type f -print0  | tar cf /mnt/d/Transfer/Prep/$(echo $vscodedate)_vscodeoffline.tar --files-from=-

# find /mnt/d/Transfer/software/vscodeoffline/artifacts -ctime -5 -type f -print0 | tar --null -czf - -T - | gpg --batch --passphrase YourPassphrase --symmetric --cipher-algo aes256 -o "/mnt/d/Transfer/Prep/$(date '+%Y%m%d')_vscodeoffline.tar.gz.gpg"

# tar czvpf - file1.txt file2.pdf file3.jpg | gpg --symmetric --cipher-algo aes256 -o myarchive.tar.gz

# Create folders in case the system throws errors about now folders
mkdir -p /mnt/d/Transfer/$(echo $vscodedate)



# Sets it to the DVD size
7za a -v8128M -psimnet1 /mnt/d/Transfer/$(echo $vscodedate)/$(echo $vscodedate)_vscodeoffline.tar.7z /mnt/d/Transfer/Prep/$(echo $vscodedate)_vscodeoffline.tar.gz
# 7za a -v8128M -psimnet1 /mnt/d/Transfer/$(echo $vscodedate)/$(echo $vscodedate)_vscodeoffline.tar.7z /mnt/d/Transfer/Prep/$(echo $vscodedate)_vscodeoffline.tar

# Sets it to the 700M size
# 7za a -v700M -psimnet1 /mnt/d/Transfer/$(echo $vscodedate)/$(echo $vscodedate)_vscodeoffline.tar.7z /mnt/d/Transfer/Prep/$(echo $vscodedate)_vscodeoffline.tar.gz

###################################### Archive VSCSync ######################################
###################                                                       ###################
###################                                                       ###################
#############################################################################################



##########################################################################################
###################                                                    ###################
###################                                                    ###################
###################################### BanderSnatch ######################################

docker run -it -v 'D:\Transfer\ToMove\repo\simple:/opt/bandersnatch' pypa/bandersnatch bash

###################################### BanderSnatch ######################################
###################                                                    ###################
###################                                                    ###################
##########################################################################################

# After exporting the docker images to tar files, this will test for the integrity of the files.

# for file in *.tar; 
for file in *; 
  do echo "Testing $file...";     
    # output=$(7za t "$file" 2>&1) # Capture both stdout and stderr
    output=$(7za t -psimnet1 "$file" 2>&1) # Capture both stdout and stderr
    if ! echo "$output" | grep -q "Everything is Ok"; 
    then echo "$file failed the integrity test";     
    fi; 
  done 



###################

# find /mnt/d/Transfer/ToMove/software/vscodeoffline/artifacts -mtime -3 -type f -print0  | tar czf /mnt/d/Transfer/ToMove/software/vscodeoffline/$(echo $vscodedate)_vscodeoffline.tar.gz --files-from=- --null

###################

# Variables
newerThan=2
olderThan=3

# Copy changed directories, while maintaining timestamps, to another folder.
cp -r -p /artifacts/* /opt/vscoffline/backup/

# find /opt/vscoffline/backup/ -mtime -"$newerThan" -type d | wc -l
# find /opt/vscoffline/backup/ -mtime +"$olderThan" -type f | wc -l 

# Delete files older than X days
find /opt/vscoffline/backup/ -mtime +"$olderThan" -type f -delete

# remove old and extraneous files
find /opt/vscoffline/backup/extensions/* -iname "Microsoft.VisualStudio*" > VsixFiles
cat VsixFiles |  sed 's/\/opt\/vscoffline\/backup\/extensions//' | cut -d '/' -f2 | sort -u | sort -u > keepFiles
mkdir /opt/vscoffline/backup/clean
for i in ` cat keepFiles ` ; do mv /opt/vscoffline/backup/extensions/"$i" /opt/vscoffline/backup/clean/ ; done
rm -rf /opt/vscoffline/backup/extensions
mv /opt/vscoffline/backup/clean /opt/vscoffline/backup/extensions
du -cksh /opt/vscoffline/backup/extensions

# Remove old install files
find /opt/vscoffline/backup/installers/* -type f -mtime +"$olderThan" -delete

# tar up files

# Tar the files up
newdate=$(date '+%Y%m%d')
tar czvf /artifacts/$(echo $newdate)_vscoffline.tar.gz /opt/vscoffline/backup/

-------------------------------------------------------------------

# # move tar file to share 
# mv $(echo $newdate)_vscoffline.tar.gz /artifacts/

-------------------------------------------------------------------

# backup Rust
newdate=$(date '+%Y%m%d')
find panamax/ -mtime -3 -type f -print0  | tar czf ../$(echo $newdate)_changed.tar.gz --files-from=- --null


docker images
# Find container name
docker container ls -a
# ReTag
docker commit vscodeoffline-vscsync-1 vscsync_offline
# Verify new name
docker container ls
docker images
# Tag docker image
docker image tag vscsync_offline ambrosektal/vscsync_offline
# Push to docker.io
docker image push ambrosektal/vscsync_offline


docker commit netbox-docker-netbox-housekeeping-1 netbox-docker-netbox-housekeeping-1
docker commit netbox-docker-netbox-worker-1       netbox-docker-netbox-worker-1
docker commit netbox-docker-netbox-1              netbox-docker-netbox-1
docker commit netbox-docker-postgres-1            netbox-docker-postgres-1
docker commit netbox-docker-redis-1               netbox-docker-redis-1
docker commit netbox-docker-redis-cache-1         netbox-docker-redis-cache-1

docker run --rm -it -v D:\Transfer\ToMove\software\panamax\:/mirror ambrosektal/panamax:20221019 init /mirror

docker run --rm -it -v D:\Transfer\ToMove\software\panamax\:/mirror ambrosektal/panamax:20221019 sync /mirror

docker run --rm -it -v D:\Transfer\ToMove\software\panamax\:/mirror -p8080:8080 ambrosektal/panamax:20221019 serve /mirror

export NFS_AUDIOVOL_NAME=plexaudioshare
export NFS_MOVIESVOL_NAME=plexmoviesshare
export NFS_TVVOL_NAME=plextvshare
export NFS_LIBRARYVOL_NAME=plexlibraryshare
export NFS_LOCAL_AUDIO=/audio
export NFS_LOCAL_MOVIES=/movies
export NFS_LOCAL_TV=/tv
export NFS_LOCAL_LIBRARY=/config
export NFS_SERVER=192.168.0.124
export NFS_AUDIO_SHARE=\data\plex\audio
export NFS_MOVIES_SHARE=\data\plex\movies
export NFS_TV_SHARE=\data\plex\tv
export NFS_LIBRARY_SHARE=\data\plex\library
#export NFS_OPTS=vers=4,soft
export NFS_OPTS='vers=4,soft,username=ambrose,password=THIS'

$NFS_AUDIOVOL_NAME='plexaudioshare'
$NFS_MOVIESVOL_NAME='plexmoviesshare'
$NFS_TVVOL_NAME='plextvshare'
$NFS_LIBRARYVOL_NAME='plexlibraryshare'
$NFS_LOCAL_AUDIO='/audio'
$NFS_LOCAL_MOVIES='/movies'
$NFS_LOCAL_TV='/tv'
$NFS_LOCAL_LIBRARY='/config'
$NFS_SERVER='192.168.0.124'
$NFS_AUDIO_SHARE='\volume2\plex\plex\audio'
$NFS_MOVIES_SHARE='\volume2\plex\plex\movies'
$NFS_TV_SHARE='\volume2\plex\plex\tv'
$NFS_LIBRARY_SHARE='\volume2\plex\plex\library'
$NFS_OPTS='vers=3,soft,username=ambrose,password=THIS'



#export NFS_SERVER=\\stored\plex
#export NFS_AUDIO_SHARE=\plex\audio
#export NFS_MOVIES_SHARE=\plex\movies
#export NFS_TV_SHARE=\plex\tv
#export NFS_LIBRARY_SHARE=\plex\library

#docker run --mount \
#  "src=$NFS_VOL_NAME,dst=$NFS_LOCAL_MNT,volume-opt=device=:$NFS_SHARE,\"volume-opt=o=addr=$NFS_SERVER,$NFS_OPTS\",type=volume,volume-driver=local,volume-opt=type=nfs" \
#  busybox ls $NFS_LOCAL_MNT

docker run --rm -it -v D:\Transfer\ToMove\repo\docker:/opt/docker 270f760d3d046dabd97e0b0f172ea326cb9afac988e3f2a74e8833eec21817b6 /bin/bash

docker volume create `
  --driver local `
  --opt type=nfs `
  --opt o=addr=$NFS_SERVER,$NFS_OPTS `
  --opt device=:$NFS_AUDIO_SHARE `
  $NFS_AUDIOVOL_NAME

docker volume create `
  --driver local `
  --opt type=nfs `
  --opt o=addr=$NFS_SERVER,$NFS_OPTS `
  --opt device=:$NFS_MOVIES_SHARE `
  $NFS_MOVIESVOL_NAME

docker volume create `
  --driver local `
  --opt type=nfs `
  --opt o=addr=$NFS_SERVER,$NFS_OPTS `
  --opt device=:$NFS_TV_SHARE `
  $NFS_TVVOL_NAME

docker volume create `
  --driver local `
  --opt type=nfs `
  --opt o=addr=$NFS_SERVER,$NFS_OPTS `
  --opt device=:$NFS_LIBRARY_SHARE `
  $NFS_LIBRARYVOL_NAME


sudo mount -t cifs -o username=ambrose //stored/plex/plex/movies testmount/   

docker run --rm -v $NFS_VOL_NAME:$NFS_LOCAL_MNT busybox ls $NFS_LOCAL_MNT

## THIS ONE ALMOST WORKED
docker run -d `
  --name=plex `
  --net=host `
  -e PUID=1000 `
  -e PGID=1000 `
  -e VERSION=docker `
  -e PLEX_CLAIM='claim-WzBPgzpNZUybCzwSNnu7' `
  --restart unless-stopped `
  --privileged `
  --mount type=bind,source=\\wsl.localhost\Ubuntu\mnt\plex\movies,target=/movies `
  --mount type=bind,source=\\wsl.localhost\Ubuntu\mnt\plex\TV_Shows,target=/tv `
  --mount type=bind,source=\\wsl.localhost\Ubuntu\mnt\plex\audio,target=/audio `
  --mount type=bind,source=\\wsl.localhost\Ubuntu\mnt\plex\library,target=/config `
  lscr.io/linuxserver/plex:latest


sudo mount -t nfs 192.168.0.124:/volume2/plex /opt/shares/plex

# fstab:://stored/plex/plex /mnt/plex type cifs (rw,relatime,vers=3.1.1,cache=strict,username=ambrose,uid=0,noforceuid,gid=0,noforcegid,addr=192.168.0.124,file_mode=0755,dir_mode=0755,soft,nounix,serverino,mapposix,rsize=4194304,wsize=4194304,bsize=1048576,echo_interval=60,actimeo=1)  

//stored/plex/plex /opt/shares/plex cifs credentials=/etc/plexcreds,rw,relatime,vers=3.1.1,cache=strict,username=ambrose,uid=0,noforceuid,gid=0,noforcegid,addr=192.168.0.124,file_mode=0777,dir_mode=0777,soft,nounix,serverino,mapposix,rsize=4194304,wsize=4194304,bsize=1048576,echo_interval=60,actimeo=1 0 0
  
docker run -d `
  --name=plex `
  --net=host `
  -e PUID=0 `
  -e PGID=0 `
  -e VERSION=docker `
  -e PLEX_CLAIM='claim-vxS_Q_HrRefAR8yb55DT' `
  --restart unless-stopped `
  -v \\wsl.localhost\Ubuntu\mnt\plex\movies:/movies `
  -v \\wsl.localhost\Ubuntu\mnt\plex\TV_Shows:/tv `
  -v \\wsl.localhost\Ubuntu\mnt\plex\audio:/audio `
  -v \\wsl.localhost\Ubuntu\mnt\plex\library:/config `
  lscr.io/linuxserver/plex:latest
  
  # i had to create one contatiner using default network with the 32400 port exposed. so I could continue setup. Hopefully I can switch back after the setup completes.
docker run -d `
  --name=plex_share `
  -p19876:32400 `
  -e PUID=0 `
  -e PGID=0 `
  -e VERSION=docker `
  -e PLEX_CLAIM='claim-jEhD8xUdGJ61FXSf1EvS' `
  --restart unless-stopped `
  --privileged `
  -v \\wsl.localhost\Ubuntu\mnt\plex\movies:/movies `
  -v \\wsl.localhost\Ubuntu\mnt\plex\TV_Shows:/tv `
  -v \\wsl.localhost\Ubuntu\mnt\plex\audio:/audio `
  -v \\wsl.localhost\Ubuntu\mnt\plex\library:/config `
  lscr.io/linuxserver/plex:latest
  
  
docker run `
-d `
--name plex `
--network=host `
--privileged `
-e TZ="America/New_York" `
-e PLEX_CLAIM="claim--7TYz7PqYyiun9NsTpc5" `
  -v \\wsl.localhost\Ubuntu\mnt\plex\movies:/movies `
  -v \\wsl.localhost\Ubuntu\mnt\plex\TV_Shows:/tv `
  -v \\wsl.localhost\Ubuntu\mnt\plex\audio:/audio `
  -v \\wsl.localhost\Ubuntu\mnt\plex\library:/config `
plexinc/pms-docker
  
  
  
  
docker run `
-d `
--name plex `
--network=host `
--privileged `
-e TZ="America/New_York" `
-e PLEX_CLAIM="claim-1x8JJ7eqyRoFzhK-nXVc" `
plexinc/pms-docker
  
  
  
docker run `
-d `
--name plexport `
--privileged `
-p19876:32400 `
-e TZ="America/New_York" `
-e PLEX_CLAIM="claim-wxB6yDzsKRcDrzkq1DzU" `
-h "BobContained" `
ambrosektal/plex:latest 
  
  
  
docker run `
-d `
--name plexport `
--privileged `
--network=host `
-e TZ="America/New_York" `
-e PLEX_CLAIM="claim-wxB6yDzsKRcDrzkq1DzU" `
-h "BobContained" `
ambrosektal/plex:latest 
  
  
  
docker run `
-d `
--name plex `
--privileged `
-p 32400:32400/tcp `
-p 3005:3005/tcp `
-p 8324:8324/tcp `
-p 32469:32469/tcp `
-p 1900:1900/udp `
-p 32410:32410/udp `
-p 32412:32412/udp `
-p 32413:32413/udp `
-p 32414:32414/udp `
-e TZ="America/New_York" `
-e PLEX_CLAIM="claim-LLz5MkraehqZJDZdDyqZ" `
-e ADVERTISE_IP="http://127.0.0.1:32400/" `
-h "BobContained" `
ambrosektal/plex:latest 
  
  
docker run `
-d `
--name plexport2 `
--privileged `
--network=host `
-e TZ="America/New_York" `
-h "BobContained" `
ambrosektal/plex:latest 
  
  

docker run \
-d \
--name plex \
--network=host \
--privileged \
-e TZ="America/New_York" \
-e VERSION=docker \
-v \mnt\plex\movies:/movies \
-v \mnt\plex\TV_Shows:/tv \
-v \mnt\plex\audio:/audio \
-v \mnt\plex\library:/config \
--restart unless-stopped \
lscr.io/linuxserver/plex:latest
    
  
###################################################
# ProGet Build

# afccb000b1b5 otter
# 9767b866a609 buildmaster
# 2a019ea785a7 proget
# 261c74fb18fe inedo-sql


docker images
# Find container name
docker container ls
# ReTag
docker commit otter otter_transfer
# Verify new name
docker container ls
docker images
# Tag docker image
docker image tag otter_transfer otter_transfer:latest

docker commit buildmaster buildmaster_transfer
# Verify new name
docker container ls
docker images
# Tag docker image
docker image tag buildmaster_transfer buildmaster_transfer:latest

docker commit proget proget_transfer
# Verify new name
docker container ls
docker images
# Tag docker image
docker image tag proget_transfer proget_transfer:latest

docker commit inedo-sql inedo-sql_transfer
# Verify new name
docker container ls
docker images
# Tag docker image
docker image tag inedo-sql_transfer inedo-sql_transfer:latest

inedo-sql_transfer:latest
proget_transfer:latest
buildmaster_transfer:latest
otter_transfer:latest
##############################################################################################

docker pull bitnami/rails:7
docker pull bitnami/rails:7.1.1
docker pull bitnami/rails:latest
docker pull bitnami/ruby:latest
docker pull bitnami/rails:5
docker pull bitnami/rails:6
docker pull ruby:latest
docker pull ruby:2.7.8-bullseye
docker pull ruby:2.6.10-bullseye
docker pull ruby:3.0-bullseye



docker run -it -d -v 'D:\Transfer\ToMove\repo\bit_rails7:/opt/repo' bitnami/rails:7             bash
docker run -it -d -v 'D:\Transfer\ToMove\repo\bit_railslatest:/opt/repo' bitnami/rails:latest   bash
docker run -it -d -v 'D:\Transfer\ToMove\repo\bit_rails5:/opt/repo' bitnami/rails:5             bash
docker run -it -d -v 'D:\Transfer\ToMove\repo\bit_ruby:/opt/repo' bitnami/ruby:latest           bash
docker run -it -d -v 'D:\Transfer\ToMove\repo\bit_rails6:/opt/repo' bitnami/rails:6             bash
docker run -it -d -v 'D:\Transfer\ToMove\repo\rubylatest:/opt/repo' ruby:latest                 bash
docker run -it -d -v 'D:\Transfer\ToMove\repo\ruby2.7.8:/opt/repo' ruby:2.7.8-bullseye          bash
docker run -it -d -v 'D:\Transfer\ToMove\repo\ruby2.6.10:/opt/repo' ruby:2.6.10-bullseye        bash
docker run -it -d -v 'D:\Transfer\ToMove\repo\ruby3:/opt/repo' ruby:3.0-bullseye                bash

# docker run -it -d --rm -v 'D:\Transfer\ToMove\repo\ruby2.7.8:/opt/repo' bitnami/ruby:2.7.8-debian-11-r156          bash
docker run -it --rm -v 'D:\Transfer\ToMove\repo\ruby2.7.8:/opt/repo' bitnami/ruby:2.7.8-debian-11-r156          bash


ruby 2.7.8
gem install rails -v 5.2.2 --path '/opt/repo'
nodejs >= 18
@rails/webpacker ^5.4.4