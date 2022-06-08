
#### NPM for Windows

# # Splitting up the packages in 3rds
# $files = get-content "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\npmPackages.txt"
# $totalFiles = $files.count
# $split3rdFiles = $totalFiles / 3
# $1splitFiles = $($files[1..$($totalFiles - ($split3rdFiles*2))])
# $2splitFiles = $($files[$split3rdFiles..($totalFiles - $split3rdFiles)])
# $3splitFiles = $($files[($split3rdFiles * 2)..$totalFiles])

function Invoke-DownloadNpmPackages {
    param (
        [string]$npmPackageList,
        [switch]$Top1000NpmPackages,
        [int]$Iterations,
        [array]$npmPackageArray,
        [switch]$yarn
    )
    $npmFiles = New-Object System.Collections.Generic.HashSet[string]
    $npmFilesArray = New-Object System.Collections.ArrayList

    if ($npmPackageList -and $Top1000NpmPackages) {
        write-host "Set the npmPackageList OR Top1000NpmPackages." -ForegroundColor Red
        write-host "NOT BOTH." -ForegroundColor Red
        break
    }
    if ($npmPackageArray) {
        if ($(get-member -InputObject $npmPackageArray).GetType().BaseType.Name -eq "Array") {
            $npmFiles = $npmPackageArray
        }
        else {
            $npmFiles.Add($(Get-Content $npmPackageArray))
        }
    }
    elseif ($Top1000NpmPackages) {
        $npmFiles.Add($(Get-Content "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\Top1000npmPackages.txt"))
    }
    elseif ($npmPackageList) {
        $npmFiles.Add($(Get-Content $npmPackageList))
    }
    else {
        $npmFiles.Add($(Get-Content "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\npmPackages.txt"))
    }

    # $npmFiles.Add($(Get-Content "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\Top1000npmPackages.txt"))

    $npmFiles.foreach({ $_.split(" ") }).foreach({ $npmFilesArray.add($_) }) 
    
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
        if ($yarn) {
            while ($npmFilesCleanYarn.count -gt 0) {
                yarn add $npmFilesCleanYarn[0] --non-interactive
                yarn audit
                rm -r -force package*
                rm -r -force node_modules/
                rm -force yarn.lock
                $npmFilesCleanYarn = ($npmFilesCleanYarn[1..($npmFilesCleanYarn.Count)])
            }
        }
        $npmFilesArray = ($npmFilesArray[25..($npmFilesArray.Count)])
    }
}

function Find-SimilarNpmNames {
    param (
        [string]$PackageName,
        [int]$Iterations
    )
    $npmFilesSearched += $PackageName.foreach({ npm search -p "$_" })
    $npmFilesSearchedUnique = $($npmFilesSearched | Sort-Object | Get-Unique)
    $npmFilesSearchedUnique = $($npmFilesSearchedUnique | Sort-Object | Get-Unique)
    $npmFilesSearchedUnique = $($npmFilesSearchedUnique | Sort-Object | Get-Unique)
    $npmFilesClean = $npmFilesSearchedUnique.foreach({ $($_.split("`t")[0]) })
    if ($Iterations) {
        while ($Iterations -gt 1) {
            Write-Host "Iteration $Iterations"
            $Iterations -= 1
            # Search based on files found in previous search - expands on the limited results from the default npm search.
            $npmFilesSearched += $npmFilesClean.foreach({ npm search -p "$_" })
            $npmFilesSearchedUnique = $($npmFilesSearched | Sort-Object | Get-Unique)
            $npmFilesSearchedUnique = $($npmFilesSearchedUnique | Sort-Object | Get-Unique)
            $npmFilesSearchedUnique = $($npmFilesSearchedUnique | Sort-Object | Get-Unique)
            $npmFilesClean = $npmFilesSearchedUnique.foreach({ $($_.split("`t")[0]) })
        }
    }
    return $npmFilesClean
}


function Find-AllScopedPackages {
    param (
        [string]$PackageName
    )
    # NOTES
    # If you see ~1.0.2 it means to install version 1.0.2 or the latest patch version such as 1.0.4. 
    # If you see ^1.0.2 it means to install version 1.0.2 or the latest minor or patch version such as 1.1.0.
    if ($PackageArray) {
        Remove-Variable PackageArray
    }
    
    if ($PackageName) {
        if ($PackageName.EndsWith("/")) {
            $PackageName = $PackageName.Trim("/")
        }
        $PackageArray += $(97..122).foreach({ npm search -p "$PackageName/$([char]$_)" })
        $npmFilesSearchedUnique = $($PackageArray | Sort-Object | Get-Unique)
        $npmFilesSearchedUnique = $($npmFilesSearchedUnique | Sort-Object | Get-Unique)
        $npmFilesSearchedUnique = $($npmFilesSearchedUnique | Sort-Object | Get-Unique)
        $PackageArray = $npmFilesSearchedUnique.foreach({ $($_.split("`t")[0]) })
    }
    else {
        Write-Host "Must provide a PackageName."
    }
    return $PackageArray
}

function Install-NpmPackages {
    param (
        [string]$PackageName,
        [System.Collections.ArrayList]$PackageArray,
        [switch]$AllLatest,
        [switch]$AllNext,
        [switch]$AllMajorVersions,
        [int]$UpperVersionRange,
        [int]$LowerVersionRange
    )
    # NOTES
    # If you see ~1.0.2 it means to install version 1.0.2 or the latest patch version such as 1.0.4. 
    # If you see ^1.0.2 it means to install version 1.0.2 or the latest minor or patch version such as 1.1.0.

    if (!$LowerVersionRange) {
        $LowerVersionRange = 0
    }
    if (!$UpperVersionRange) {
        $UpperVersionRange = 10
    }

    if ($AllLatest) {
        if ($PackageArray) {
            foreach ($PackageName in $PackageArray) { npm i "$PackageName@latest" --legacy-peer-deps }
        }
        elseif ($PackageName) {
            npm i "$PackageName@latest" --legacy-peer-deps
        }
        else {
            Write-Host "PackageName OR PackageArray required with the AllLatest option."
        }
    }
    if ($AllNext) {
        if ($PackageArray) {
            foreach ($PackageName in $PackageArray) { npm i "$PackageName@next" --legacy-peer-deps }
        }
        elseif ($PackageName) {
            npm i "$PackageName@next" --legacy-peer-deps
        }
        else {
            Write-Host "PackageName OR PackageArray required with the AllNext option."
        }
    }
    if ($AllMajorVersions) {
        if ($PackageArray) {
            foreach ($PackageName in $PackageArray) { $($LowerVersionRange..$UpperVersionRange).foreach({ npm i "$PackageName@^$_" --legacy-peer-deps }) }    
        }
        elseif ($PackageName) {
            $($LowerVersionRange..$UpperVersionRange).foreach({ npm i "$PackageName@^$_" --legacy-peer-deps })
        }
        else {
            Write-Host "PackageName OR PackageArray required with the AllMajorVersions option."
        }
    }
}
