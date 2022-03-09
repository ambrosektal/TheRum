
#### NPM for Windows
$npmFiles = "@apollo","@apollo-server","@apollo-micro-server","@babel","@docker","@elastic","@ember","@gatsby","@graphql","@graphql-tools","@gulp","@jetbrains","@kibana","@lerna","@logstash","@microsoft","@mongodb","@mui","@next","@next-js","@nextjs","@npm","@parcel","@razzle","@react","@searchkit","@types","@typescript","@verdaccio","@vscode","@webpack","@yarn","apollo","apollo-server","apollo-micro-server","aspnet","babel","bootstrap","code-server","cra-template","create-next-","create-react-","docker","ember","ember-cli","fontawesome","fortawesome","gatsby","gem","graphql","gulp","gyp","jetbrains","kestrel","lerna","materialui","mongo","mongodb","mui","next","next-js","nextjs","node-gyp","npm","parcel","rails","razzle","react","ruby","searchkit","skia","skiasharp","typescript","undefsafe","verdaccio","vscode","webpack","windows","yarn","pnpm","@pnpm","powershell","tty","pty","express","@express","quire","@quire","bootstrap","@bootstrap","dotnet","aspnet","@dotnet","@aspnet","axios","@axios","next-connect","fs-extra","@grpc","grpc","algolia","@algolia","algoliasearch","@algoliasearch","eslint","babel","@babel","@eslint","eslint-config-react-app","@babel/eslint","eslint-config","eslint-config-react","@babel/eslint-parser","rush","@rush","react-chartjs","react-chart","react-chartjs-2","helm","search","dom","server","3ds","unity","game","react-","threejs","@threejs","3d","threejs-","react-use","react-hook-form","react-hook","swr","css","websocket","template","hook","component","form","react-form","@solid.js","solidjs","solid","@solid"

$npmFilesSearched = $npmFiles.foreach({$(npm search -p "$_")})
$npmFilesSearchedUnique = $($npmFilesSearched | sort | unique)
# $npmFilesSearchedUnique.foreach({npm install $($_.split(" ")[0])})
# When using a -p in the search:::
Write-Host "-------------------------------------------------------------------------------"
Write-Host "Downloading $($npmFilesSearchedUnique.count) packages. Not Including deps."
Write-Host "-------------------------------------------------------------------------------"
# $npmFilesSearchedUnique.foreach({npm install --legacy-peer-deps $($_.split("`t")[0])})

$npmFilesClean = $npmFilesSearchedUnique.foreach({$($_.split("`t")[0])})

npm install --legacy-peer-deps $npmFilesClean[0..200]
npm install --legacy-peer-deps $npmFilesClean[201..400]
npm install --legacy-peer-deps $npmFilesClean[401..600]
npm install --legacy-peer-deps $npmFilesClean[601..800]
npm install --legacy-peer-deps $npmFilesClean[801..1000]
npm install --legacy-peer-deps $npmFilesClean[1001..1200]
npm install --legacy-peer-deps $npmFilesClean[1201..1400]
npm install --legacy-peer-deps $npmFilesClean[1401..1600]
npm install --legacy-peer-deps $npmFilesClean[1601..1800]
npm install --legacy-peer-deps $npmFilesClean[1801..2000]
npm install --legacy-peer-deps $npmFilesClean[2001..2200]
npm install --legacy-peer-deps $npmFilesClean[2201..2400]

# ------------------------------------------------------------

npm audit fix --legacy-peer-deps

npm audit fix -f --legacy-peer-deps

# # When using a -p in the search
# # $npmFilesSearchedUnique.foreach({npm pack $($_.split(" ")[0])})
# $npmFilesSearchedUnique.foreach({npm pack $($_.split("`t")[0])})
# #

# cd node_modules
# # cd C:\\Users\\$env:USERNAME\\Downloads\\Transfer\\ToMove\\node\\node_modules\\
# $directory=$(pwd)
$folders = gci -Recurse -Directory
$folders.foreach({cd "$_" && npm i --legacy-peer-deps && npm audit fix --force })


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