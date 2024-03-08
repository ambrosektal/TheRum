$dirs = gci -recurse -filter '.git' -Directory -Hidden
$dirs.foreach({ cd $_.parent;
    git pull
})



# Pull all the remotes from a git repository
# git remote -v | foreach({ $_.Split(" ")[0] }).foreach({ git pull $_ })
# ((git branch --remotes --all ).split('origin/') | Where-Object {$_ -inotlike "*remotes/" -and $_ -inotlike "*master*" -and $_ -inotlike "*main" }).foreach({git checkout $_ ; git switch $_ ; git pull})
((git branch --remotes --all ).split('origin/') | Where-Object {$_ -ilike "*release*" -and $_ -inotlike "*remotes/" -and $_ -inotlike "*master*" -and $_ -inotlike "*main" }).foreach({git checkout $_ ; git switch $_ ; git pull})

git checkout master
git switch master
git checkout main
git switch main


##############################

$dirs = gci -recurse -filter '.git' -Directory -Hidden
$dirs.foreach({ cd $_.parent;
    ((git branch --remotes --all ).split('origin/') | Where-Object {$_ -ilike "*release*" -and $_ -inotlike "*remotes/" -and $_ -inotlike "*master*" -and $_ -inotlike "*main" }).foreach({git checkout $_ ; git switch $_ ; git pull})

    git checkout master
    git switch master
    git checkout main
    git switch main

})
