
#### NPM for Windows
$npmFiles = "@apollo","@apollo-micro-server","@apollo-server","@aspnet","@axios","@babel","@babel/eslint","@babel/eslint-parser","@bootstrap","@canvas","@canvas-","@docker","@dotnet","@elastic","@elastic/apm","@elastic/elastic","@elastic/elastic-apm","@ember","@eslint","@express","@gatsby","@gitbeaker","@gitbeaker/node","@graphql","@graphql-tools","@grpc","@gulp","@jetbrains","@kibana","@lerna","@logstash","@mapbox","@microsoft","@mongodb","@mui","@next","@next-js","@nextjs","@npm","@npm-","@parcel","@pnpm","@quire","@razzle","@react","@rush","@searchkit","@solid","@solid.js","@threejs","@types","@types/vscode","@typescript","@verdaccio","@vscode","@vscode-logging","@vscode-logging/types","@vscode/sqlite3","@webpack","@websocket","@yarn","3d","3ds","ansi-color","apm","apollo","apollo-micro-server","apollo-server","aspnet","axios","babel","backend","bootstrap","canvas","canvas-","code-server","component","cra-template","create-backend","create-next","create-next-","create-react","create-react-","css","docker","dom","dotnet","elastic","elastic-apm","ember","ember-cli","env-editor","eslint","eslint-config","eslint-config-react","eslint-config-react-app","exporter","express","fontawesome","form","fortawesome","fs-extra","game","gatsby","gem","gitbeaker","graphql","grpc","gulp","gyp","helm","hook","jetbrains","kestrel","kube","kubernetes","lerna","materialui","mongo","mongodb","mui","next","next-connect","next-js","nextjs","node-gyp","node-pre-gyp","npm","npm-","parcel","pnpm","powershell","prom","prometheus","pty","quire","rails","rancher","razzle","react","react-","react-chart","react-chartjs","react-chartjs-2","react-form","react-hook","react-hook-form","react-use","react-virtual","react-window","ruby","rush","search","searchkit","server","skia","skiasharp","solid","solidjs","swr","template","threejs","threejs-","tty","typescript","undefsafe","unity","verdaccio","vscode","vscode-chrome-debug-core","vscode-jsonrpc","vscode-languageserver","vscode-languageserver-types","vscode-textmate","vscode-uri","vscode-xterm","webpack","websocket","windows","yarn"



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