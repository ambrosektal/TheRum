$dirs = gci -recurse -filter '.git' -Directory -Hidden
$dirs.foreach({ cd $_.parent;
    git pull
})