
#### NPM for Windows
$npmFiles = "@apollo","@apollo-server","@apollo-micro-server","@babel","@docker","@elastic","@ember","@gatsby","@graphql","@graphql-tools","@gulp","@jetbrains","@kibana","@lerna","@logstash","@microsoft","@mongodb","@mui","@next","@next-js","@nextjs","@npm","@parcel","@razzle","@react","@searchkit","@types","@typescript","@verdaccio","@vscode","@webpack","@yarn","apollo","apollo-server","apollo-micro-server","aspnet","babel","bootstrap","code-server","cra-template","create-next-","create-react-","docker","ember","ember-cli","fontawesome","fortawesome","gatsby","gem","graphql","gulp","gyp","jetbrains","kestrel","lerna","materialui","mongo","mongodb","mui","next","next-js","nextjs","node-gyp","npm","parcel","rails","razzle","react","ruby","searchkit","skia","skiasharp","typescript","undefsafe","verdaccio","vscode","webpack","windows","yarn","pnpm","@pnpm","powershell","tty","pty","express","@express","quire","@quire","bootstrap","@bootstrap","dotnet","aspnet","@dotnet","@aspnet","axios","@axios","next-connect","fs-extra","@grpc","grpc","eslint","babel","@babel","@eslint","eslint-config-react-app","@babel/eslint","eslint-config","eslint-config-react","@babel/eslint-parser","rush","@rush","react-chartjs","react-chart","react-chartjs-2","helm","search","dom","server","3ds","unity","game","react-","threejs","@threejs","3d","threejs-","react-use","react-hook-form","react-hook","swr","css","websocket","template","hook","component","form","react-form","@solid.js","solidjs","solid","@solid","react-virtual","react-window","@npm-","npm-","@vscode","vscode-jsonrpc","vscode-uri","vscode-languageserver-types","vscode-languageserver","env-editor","vscode-textmate","@types/vscode","@vscode-logging/types","@vscode-logging","vscode-chrome-debug-core","@vscode/sqlite3","vscode-xterm","websocket","@websocket","@grpc","canvas","@canvas","canvas-","@canvas-","gyp","node-pre-gyp","@mapbox","ansi-color","@gitbeaker/node","gitbeaker","@gitbeaker"

# $npmFiles = "prometheus","prom","exporter","docker","@docker","rancher","kube","kubernetes","backend","create-backend","create-next","create-react"
# Neat little addition to searching over all the alphabet
# $(65..90).foreach({npm search "@mapbox/$([char]$_)"})
# $npmFilesSearched += $(97..122).foreach({npm search -p "@mapbox/$([char]$_)"})

$npmFilesSearched = $npmFiles.foreach({$(npm search -p "$_")})
$npmFilesSearchedUnique = $($npmFilesSearched | sort | unique)
$npmFilesSearchedUnique = $($npmFilesSearchedUnique | sort | unique)
$npmFilesSearchedUnique = $($npmFilesSearchedUnique | sort | unique)
$npmFilesSearchedUnique = $($npmFilesSearchedUnique | sort | unique)

# $npmFilesSearchedUnique.foreach({npm install $($_.split(" ")[0])})
# When using a -p in the search:::
Write-Host "-------------------------------------------------------------------------------"
Write-Host "Downloading $($npmFilesSearchedUnique.count) packages. Not Including deps."
Write-Host "-------------------------------------------------------------------------------"
# $npmFilesSearchedUnique.foreach({npm install --legacy-peer-deps $($_.split("`t")[0])})

$npmFilesClean = $npmFilesSearchedUnique.foreach({$($_.split("`t")[0])})

# Yes I know it is dumb, but I am still testing and don't trust it.
$npmFilesCleanYarn = $npmFilesClean
$npmFilesCleanNpm = $npmFilesClean

while ($npmFilesCleanNpm.count -gt 0) {
    npm install --legacy-peer-deps $npmFilesCleanNpm[0..199]
    npm audit fix --legacy-peer-deps
    npm audit fix -f --legacy-peer-deps
    rm -r -force package*
    rm -r -force node_modules/
    $npmFilesCleanNpm = ($npmFilesCleanNpm[199..($npmFilesCleanNpm.Count)])
}

while ($npmFilesCleanYarn.count -gt 0) {
    yarn add $npmFilesCleanYarn[0] --non-interactive
    yarn audit
    rm -r -force package*
    rm -r -force node_modules/
    $npmFilesCleanYarn = ($npmFilesCleanYarn[1..($npmFilesCleanYarn.Count)])
}

# ------------------------------------------------------------

# npm audit fix --legacy-peer-deps

# npm audit fix -f --legacy-peer-deps

# yarn audit

# ------------------------------------------------------------

# foreach( $num in $(1..20) ){ npm i --legacy-peer-deps npm@~"$num" }

# comm -3 \
# <(find . -iname "*.tgz" -printf '%h\n' | sort -u) \
# <(find . -type d | sort) \
# | sed 's/^.tgz\///'

# find . -type d '!' -exec test -e "{}/*.tgz" ';' -print







# # When using a -p in the search
# # $npmFilesSearchedUnique.foreach({npm pack $($_.split(" ")[0])})
# $npmFilesSearchedUnique.foreach({npm pack $($_.split("`t")[0])})
# #

# cd node_modules
# # cd C:\\Users\\$env:USERNAME\\Downloads\\Transfer\\ToMove\\node\\node_modules\\
# $directory=$(pwd)
$folders = gci -Recurse -Directory
$folders.foreach({cd "$_" && npm i --legacy-peer-deps && npm audit fix --force })

# # HISTORY

# rm -rf /opt/verdaccio/backup/storage/*

# find /verdaccio/storage/data/* -mtime -3 -type d -exec cp -r -p {} ~/backup/storage/ \;
# find ~/backup/storage/ -type f -iname "*.tgz" -mtime +5 -exec rm -f {} \;

# find /verdaccio/storage/data/* -type f -iname "*.tgz" -mtime -3 | wc -l
# find /verdaccio/storage/data/* -mtime -3 -type d -exec cp -r -p {} ~/backup/storage/ \;
# find ~/backup/storage/ -type f -iname "*.tgz" -mtime +5 -exec rm -f {} \;

# find /verdaccio/storage/data/* -mtime -3 -type d -exec cp -r -p {} ~/backup/storage/ \;
# find ~/backup/storage/ -type f -iname "*.tgz" -mtime +5 -exec rm -f {} \;



# ------------------------------------------------------------
# $(npm search searchkit).foreach({npm pack $($_.split(" ")[0])})

# $Directory = "C:\\Users\\$env:USERNAME\\Downloads\\Transfer\\ToMove\\node\\"

# $npmFiles = $(gci -recurse . -Filter package.json)

# # $npmFiles.foreach({cd $_.directory && npm pack })
# $npmFiles.foreach({cd $_.directory && npm pack . })

# $tgzFiles = $(gci -recurse . -Filter "*.tgz")
# $tgzFiles.foreach({copy-item $_ -destination $Directory})

# # npm audit fix --force 
# # $(gci -recurse . -Filter package.json).foreach({cd $_.directory && npm pack . })

# ------------------------------------------------------------

# $packageFiles = gci -recurse . -Filter package.json
# $packageFiles.foreach({cd $_.directory && npm pack . })

# $(gci -recurse "C:\\Users\\$env:USERNAME\\Downloads\\Transfer\\ToMove\\" -Filter "*.tgz").foreach({Move-Item $_ -destination "C:\\Users\\$env:USERNAME\\Downloads\\Transfer\\ToMove\\node\\"})


# DeDupe
$moved = gci "*.tgz" -Recurse -Path "C:\\Users\\$env:USERNAME\\Downloads\\Transfer\\Moved\\Node\\"
$toMove = gci -recurse "*.tgz" -Path "C:\\Users\\$env:USERNAME\\Downloads\\Transfer\\ToMove\\Node\\"
# mkdir C:\Users\$env:USERNAME\Downloads\Staging
$staging = "C:\\Users\\$env:USERNAME\\Downloads\\Transfer\\Staging\\Node\\"
$count = 0
$leavingCount = 0
$toMove.foreach({if($_.name -notin $moved.Name){$count++ }})
$toMove.foreach({if($_.name -in $moved.Name){$leavingCount++ }})
write-host "Going to move $count packages"
write-host "$leavingCount duplicate packages"

# Move Files
$toMove.foreach({if($_.name -notin $moved.Name){move-item $_ $staging}})

# Hashing Files
$Directory = "C:\\Users\\$env:USERNAME\\Downloads\\Transfer\\Staging\\node"
get-filehash "$Directory\\*" | format-list | Out-File "$Directory\\..\\PRE_DTA_HASH_$(Get-Date -Format "yyyyMMdd")_node.txt"


# $Directory = "C:\\Users\\$env:USERNAME\\Downloads\\Transfer\\Staging\\Software"
# $toHash = gci -recurse -Path $Directory
# $toHash.foreach({Get-FileHash $_ | format-list | Out-File -Append "$Directory\\..\\PRE_DTA_HASH_$(Get-Date -Format "yyyyMMdd")_Software.txt"})

# ------------------------------------------------------------

yarn config set registry http://10.245.42.25:4873/
yarn config set unsafeHTTPWhiteList 10.245.42.25