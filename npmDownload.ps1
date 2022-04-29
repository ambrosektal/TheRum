
#### NPM for Windows

$npmFiles = New-Object System.Collections.Generic.HashSet[string]
$npmFilesArray = New-Object System.Collections.ArrayList

$npmFiles.Add($(Get-Content "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackages.txt"))
$npmFiles.foreach({$_.split(" ")}).foreach({$npmFilesArray.add($_)}) 
# Neat little addition to searching over all the alphabet
# $(65..90).foreach({npm search "@mapbox/$([char]$_)"})
# $npmFilesSearched += $(97..122).foreach({npm search -p "@mapbox/$([char]$_)"})

# Get all the versions of something
# $(0..20).foreach({npm i "vue@3.2.$_"})


while ($npmFilesArray.count -gt 0) {
    $npmFilesLimit = $npmFilesArray[0..24]

    $npmFilesSearched = $npmFilesLimit.foreach({ $(npm search -p "$_") })
    $npmFilesSearchedUnique = $($npmFilesSearched | sort | unique)
    $npmFilesSearchedUnique = $($npmFilesSearchedUnique | sort | unique)
    $npmFilesSearchedUnique = $($npmFilesSearchedUnique | sort | unique)

    # $npmFilesSearchedUnique.foreach({npm install $($_.split(" ")[0])})
    # When using a -p in the search:::
    Write-Host "-------------------------------------------------------------------------------"
    Write-Host "Downloading $($npmFilesSearchedUnique.count) packages. Not Including deps."
    Write-Host "-------------------------------------------------------------------------------"
    # $npmFilesSearchedUnique.foreach({npm install --legacy-peer-deps $($_.split("`t")[0])})

    $npmFilesClean = $npmFilesSearchedUnique.foreach({ $($_.split("`t")[0]) })

    # Yes I know it is dumb, but I am still testing and don't trust it.
    $npmFilesCleanYarn = $npmFilesClean
    $npmFilesCleanNpm = $npmFilesClean

    while ($npmFilesCleanNpm.count -gt 0) {
        npm install --legacy-peer-deps $npmFilesCleanNpm[0..25]
        npm audit fix --legacy-peer-deps
        npm audit fix -f --legacy-peer-deps
        rm -r -force package*
        rm -r -force node_modules/
        $npmFilesCleanNpm = ($npmFilesCleanNpm[25..($npmFilesCleanNpm.Count)])
    }

    while ($npmFilesCleanYarn.count -gt 0) {
        yarn add $npmFilesCleanYarn[0] --non-interactive
        yarn audit
        rm -r -force package*
        rm -r -force node_modules/
        rm -force yarn.lock
        $npmFilesCleanYarn = ($npmFilesCleanYarn[1..($npmFilesCleanYarn.Count)])
    }

    $npmFilesArray = ($npmFilesArray[25..($npmFilesArray.Count)])
}


