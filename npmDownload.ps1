
#### NPM for Windows

# $outfile = "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\npmPackages.txt"
# $searchterm = "svelte"
# (npm search -p $searchterm).foreach({ ($_.split(" ")[0]).split("`t")[0] })

# # Pulling all previously downloaded packages
# ## Yes I know I am doing more operations than needed. Leave me alone. I'm sick of these things failing and starting the process over.
# (gci -recurse -Directory "D:\Transfer\ToMove\software\verdaccio\storage\data\").FullName.Trim('D:\Transfer\ToMove\software\verdaccio\storage\data\').TrimEnd("-").TrimStart("-").Replace("\","/") > D:\Transfer\packagenames.txt
# $checkfiles = gc D:\Transfer\packagenames.txt | Sort-Object -Unique
# Install-NpmPackages -PackageArray $checkfiles -AllLatest
# Install-NpmPackages -PackageArray $($files | Select-String mui) -AllLatest
#
## Another window:::
# while($true){ 
# rm -Force D:\Transfer\ToMove\node\package* ; 
# rm -Force D:\Transfer\Staging\node\package* ; 
# rm -Force D:\Transfer\Moved\node\package* ; 
# Start-Sleep 120
# }

# Finding files modified only in the last X days
# gci -Recurse -Filter "*.tgz" | Where{$($_.GetType().Name -eq "FileInfo") -and $($_.LastWriteTime -ge (Get-Date).AddDays(-4))}

# Powershell backup new and cleanup
# UNTESTED!!!
# $dirs = (gci -Recurse | Where{$($_.GetType().Name -eq "DirectoryInfo") -and $($_.LastWriteTime -ge (Get-Date).AddDays(-1))})
# $dirs.foreach({cp -recurse $_ D:\Transfer\ToMove\software\verdaccio\backup\ })
# gci -Recurse -Filter "*.tgz" | Where{$($_.GetType().Name -eq "FileInfo") -and $($_.LastWriteTime -ge (Get-Date).AddDays(+4))} | remove-item -force


# # Splitting up the packages in 3rds
# $files = get-content "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\npmPackages.txt"
# $totalFiles = $files.count
# $split3rdFiles = $totalFiles / 3
# $1splitFiles = $($files[1..$($totalFiles - ($split3rdFiles*2))])
# $2splitFiles = $($files[$split3rdFiles..($totalFiles - $split3rdFiles)])
# $3splitFiles = $($files[($split3rdFiles * 2)..$totalFiles])

# Clean list from git up
# $topfiles = (gc C:\Users\$env:USERNAME\Documents\npm.txt).foreach({$_.split('[').split(']')[1]})
# $topfiles = $topfiles | sort-object -unique
# $topfiles > C:\Users\$env:USERNAME\Downloads\gits\TheRum\npmPackageFiles\TopPackages.txt

# pull a bunch of github repos from a list
# $gits = gc ..\..\..\gits\TheRum\npmPackageFiles\github\svelte.txt
# $gits.foreach({git clone --recurse $_})

# Git Repo cycle through:
# $files = gci . -Recurse -Filter package.json
# # $files.foreach({cd $_.Directory && npm i --legacy-peer-deps && npm audit fix --force})
# $files.foreach({cd $_.Directory && npm i --force && npm audit fix --force})
# $files.foreach({cd $_.Parent && npm i --force && npm audit fix --force})

# $reactFiles = $(97..122).foreach({ npm search -p "react-$([char]$_)" })
# $reactFiles.foreach({npm install --force $($_.split("`t")[0])})

# $(npm search react ).foreach({npm install --force $($_.split("`t")[0])})

# # Basic Download
# $files = gc "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\react.txt"
# $files = $files | Sort-Object | Get-unique
# $files.foreach({npm i $_ --force ; npm audit fix ; npm audit fix --force ;  rm -r -Force "D:\Transfer\Moved\node\*"})

# # crazy way of getting all listed packages
# ## really think this will be stupid....
# ## Seems to work, but need to test out garbage collection.
####TODO Breaks at some point. Need to look into this.
# //?
# //!
# cd "D:\Transfer\ToMove\node\"
# $txtfiles = (gci -recurse C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\*.txt)
# foreach($file in $txtfiles){$(gc $file | Sort-Object -Unique ).Foreach({
#     npm i $_ --force ; npm audit fix ; npm audit fix --force ; rm -r -Force "D:\Transfer\ToMove\node\*"
#     [System.GC]::Collect()
#     })
# }
### Alternative method
$txtfiles = (gci -recurse C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\react.txt)

$txtfiles = (gci -recurse C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\bun.txt)
$txtfiles = (gci -recurse C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\mantine.txt)
$txtfiles = (gci -recurse C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\svelte.txt)
$txtfiles = (gci -recurse C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\express.txt)
$txtfiles = (gci -recurse C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\firebase.txt)
$txtfiles = (gci -recurse C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\packageLists\\mattermost.txt)
$txtfiles = (gci -recurse C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\packageLists\\requests.txt)
$txtfiles = (gci -recurse C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\requests\\createapps.txt)


############################

$txtfiles = (gci -recurse C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\ -Filter "*.txt")
$files = $txtfiles | foreach {gc $_}
$files = $files | Sort-Object -Unique
$files = $files | Sort-Object -Unique

$files = $files[0..$($files.count * .50)]
$files.count

$files > C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\firstHalf.txt

############################


$txtfiles = (gci -recurse C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\ -Filter "*.txt")
$files = $txtfiles | foreach {gc $_}
$files = $files | Sort-Object -Unique
$files = $files | Sort-Object -Unique

$files = $files[$($files.count * .50)..$($files.count)]
$files.count

$files > C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\secondHalf.txt

############################

SimpleNPMDownload -PackageListTxtFile "C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\firstHalf.txt" 

SimpleNPMDownload -PackageListTxtFile "C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\secondHalf.txt" 

############################

function SimpleNPMDownload {
    # SimpleNPMDownload -PackageListTxtFile "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\packageLists\\react.txt"
    # SimpleNPMDownload -PackageListTxtFile "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\requests\\svelte.txt"
    # SimpleNPMDownload -PackageListTxtFile "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\packageLists\\requests.txt" 
    # SimpleNPMDownload -PackageListTxtFile "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\packageLists\\missingFiles.txt" 
    # SimpleNPMDownload -PackageListTxtFile "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\requests\\createapps.txt" 
    # SimpleNPMDownload -PackageListTxtFile "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\requests\\esbuild.txt" 
    # SimpleNPMDownload -PackageListTxtFile "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\TopLists\\TopPackages20230227.txt" 
    # SimpleNPMDownload -InstallDirectory "D:\Transfer\Staging\node" -PackageListTxtFile "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\svelte.txt"
    # SimpleNPMDownload -InstallDirectory "D:\Transfer\Moved\node" -PackageListTxtFile "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\packageLists\\requests.txt" 
    # SimpleNPMDownload -DirectoryOfPackageListTxtFiles "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\requests"
    # SimpleNPMDownload -DirectoryOfPackageListTxtFiles "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\others"
    # SimpleNPMDownload -DirectoryOfPackageListTxtFiles "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\TopLists"
    # SimpleNPMDownload -DirectoryOfPackageListTxtFiles "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\packageLists"
    param (
        [string]$npmPackageList,
        [string]$PackageListTxtFile,
        [string]$DirectoryOfPackageListTxtFiles,
        [string]$InstallDirectory,
        [array]$npmPackageArray,
        [switch]$yarn
    )
    if ($PackageListTxtFile) {
        $txtfiles = (Get-ChildItem $PackageListTxtFile)
    }
    elseif ($DirectoryOfPackageListTxtFiles) {
        $txtfiles = (Get-ChildItem "$DirectoryOfPackageListTxtFiles\*")
    }
    else {
        Write-host "Must give a Packagelist, or directory of text files.  " -ForegroundColor Red
    }
    write-host "Number of txtfiles: $($txtfiles.count)"
    Write-Host "Text Files: $txtfiles"
    if (!$InstallDirectory) {
        $InstallDirectory = "D:\Transfer\ToMove\node"
    }
    else {
        while ($InstallDirectory.EndsWith("\") ) {
            $InstallDirectory = $InstallDirectory.TrimEnd("\")
        }
    }
    
    Set-Location -Path $InstallDirectory

    if ($(Get-Location ).Path -notlike $InstallDirectory ) {
        Write-Host "I'm not where I expected I was. I'm quitting."
        break;
    }
    else {
        $unclean = $txtfiles.foreach({ gc $_ })
        # $clean = $unclean | Sort-Object -Unique
        $clean = $unclean.Replace('\','/') | Sort-Object -Unique
        Write-Host "yay, I'm in the correct directory!!!"
        $clean | foreach-object -Parallel ({
                write-host "Downloading $_ ..."
                [string]$random = Get-Random -Maximum 999999 -Minimum 100000
                mkdir "D:\\Transfer\\ToMove\\node\\$random"
                try{
                    npm i $_"@latest" --force --prefix "D:\\Transfer\\ToMove\\node\\$random"; 
                } catch {
                    npm i $_ --force --prefix "D:\\Transfer\\ToMove\\node\\$random"; 
                }
                # npm i $_ --force --prefix "D:\\Transfer\\ToMove\\node\\$random"; 
                cd "D:\\Transfer\\ToMove\\node\\$random"; 
                npm audit fix ; 
                npm audit fix --force ; 
                cd "D:\\Transfer\\ToMove\\node\\"; 
                Remove-Item -r -Force "D:\\Transfer\\ToMove\\node\\$random"
                [System.GC]::Collect()
            })
    }
    # Remove-Item -r -Force "$InstallDirectory\*"
}


function Invoke-DownloadNpmPackages {
    # Invoke-DownloadNpmPackages -npmPackageList "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\react.txt"
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
        $npmFilesLimit = $npmFilesArray[0..9]

        $npmFilesSearched = $npmFilesLimit.foreach({ $(npm search -p "$_") })
        $npmFilesSearchedUnique = $($npmFilesSearched | sort | unique)
        $npmFilesSearchedUnique = $($npmFilesSearchedUnique | sort | unique)
        # $npmFilesSearchedUnique = $($npmFilesSearchedUnique | sort | unique)

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
            # npm install --legacy-peer-deps $npmFilesCleanNpm[0..25]
            npm install --force $npmFilesCleanNpm[0..10]
            # npm audit fix --legacy-peer-deps
            npm audit fix --force
            # npm audit fix -f --legacy-peer-deps
            npm audit fix -f --force
            rm -r -force package*
            rm -r -force node_modules/
            $npmFilesCleanNpm = ($npmFilesCleanNpm[10..($npmFilesCleanNpm.Count)])
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
        $npmFilesArray = ($npmFilesArray[10..($npmFilesArray.Count)])
    }
}

function Find-SimilarNpmNames {
    # Cycle through package name and search for similar names.
    # Find-SimilarNpmNames -PackageName "svelte-" -Iterations 1
    param (
        [string]$PackageName,
        [int]$Iterations
    )
    $npmFilesSearched += $PackageName.foreach({ npm search -p "$_" })
    $npmFilesSearchedUnique = $($npmFilesSearched | Sort-Object | Get-Unique)
    $npmFilesSearchedUnique = $($npmFilesSearchedUnique | Sort-Object | Get-Unique)
    # $npmFilesSearchedUnique = $($npmFilesSearchedUnique | Sort-Object | Get-Unique)
    $npmFilesClean = $npmFilesSearchedUnique.foreach({ $($_.split("`t")[0]) })
    if ($Iterations) {
        while ($Iterations -gt 0) {
            Write-Host "Iteration $Iterations"
            $Iterations -= 1
            # Search based on files found in previous search - expands on the limited results from the default npm search.
            $npmFilesSearched += $npmFilesClean.foreach({ npm search -p "$_" })
            $npmFilesSearchedUnique = $($npmFilesSearched | Sort-Object | Get-Unique)
            $npmFilesSearchedUnique = $($npmFilesSearchedUnique | Sort-Object | Get-Unique)
            # $npmFilesSearchedUnique = $($npmFilesSearchedUnique | Sort-Object | Get-Unique)
            $npmFilesClean = $npmFilesSearchedUnique.foreach({ $($_.split("`t")[0]) })
        }
    }
    return $npmFilesClean
}


function Find-AllPackages {
    # Find all packages based on a name
    # cycles through every letter in the alphabet after known package name
    
    # EXAMPLE:::
    # Find-AllPackages -PackageName "svelte-"
    ## cycles through svelte-[a-z]
    # Find-AllPackages -Scoped -PackageName "@sveltejs" 
    ## cycles through @sveltejs/[a-z]
    
    param (
        [string]$PackageName,
        [switch]$Scoped
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
        if ($Scoped) {
            $PackageArray += $(97..122).foreach({ npm search -p "$PackageName/$([char]$_)" })    
        }
        else {
            $PackageArray += $(97..122).foreach({ npm search -p "$PackageName$([char]$_)" })
        }
        $npmFilesSearchedUnique = $($PackageArray | Sort-Object | Get-Unique)
        $npmFilesSearchedUnique = $($npmFilesSearchedUnique | Sort-Object | Get-Unique)
        # $npmFilesSearchedUnique = $($npmFilesSearchedUnique | Sort-Object | Get-Unique)
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
        [int]$LowerVersionRange,
        [string]$BaseVersion

    )
    # NOTES
    # If you see ~1.0.2 it means to install version 1.0.2 or the latest patch version such as 1.0.4. 
    # If you see ^1.0.2 it means to install version 1.0.2 or the latest minor or patch version such as 1.1.0.
    # Install-NpmPackages -PackageName svelte -AllMajorVersions
    # $packageArray = gc "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\newnet.txt"
    # $packageArray = gc "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\requests\\esbuild.txt" 
    # Install-NpmPackages -PackageArray $packageArray -AllMajorVersions -UpperVersionRange 20 -LowerVersionRange 0 -BaseVersion '0'
    $Directory = Get-Location
    if (!$LowerVersionRange) {
        $LowerVersionRange = 0
    }
    if (!$UpperVersionRange) {
        $UpperVersionRange = 10
    }
    # if (!$BaseVersion) {
    #     $BaseVersion = 0
    # }
    if ($AllLatest) {
        if ($PackageArray) {
            # foreach ($PackageName in $PackageArray) { npm i "$PackageName@latest" --legacy-peer-deps }
            # foreach ($PackageName in $PackageArray) { npm i "$PackageName@latest" --force }
            foreach ($PackageName in $PackageArray) { 
                # npm i "$PackageName@latest" --force ;
                npm i "$PackageName" --force ;
                npm audit fix ; 
                npm audit fix --force ;  
                Remove-Item -r -Force "$Directory\\*"
                # Remove-Item -r -Force "$Directory\\node_modules"
                # Remove-Item -r -Force "$Directory\\package.json"
                # Remove-Item -r -Force "$Directory\\package-lock.json"
                [System.GC]::Collect()
            }
        }
        elseif ($PackageName) {
            # npm i "$PackageName@latest" --legacy-peer-deps
            # npm i "$PackageName@latest" --force
            # npm i "$PackageName@latest" --force ;
            npm i "$PackageName" --force ;
            npm audit fix ; 
            npm audit fix --force ;  
            Remove-Item -r -Force "$Directory\\*"
            # Remove-Item -r -Force "$Directory\\node_modules"
            # Remove-Item -r -Force "$Directory\\package.json"
            # Remove-Item -r -Force "$Directory\\package-lock.json"
            [System.GC]::Collect()
        }
        else {
            Write-Host "PackageName OR PackageArray required with the AllLatest option."
        }
    }
    if ($AllNext) {
        if ($PackageArray) {
            # foreach ($PackageName in $PackageArray) { npm i "$PackageName@next" --legacy-peer-deps }
            # foreach ($PackageName in $PackageArray) { npm i "$PackageName@next" --force }
            foreach ($PackageName in $PackageArray) { 
                npm i "$PackageName@next" --force ;
                npm audit fix ; 
                npm audit fix --force ;  
                Remove-Item -r -Force "$Directory\\*"
                # Remove-Item -r -Force "$Directory\\node_modules"
                # Remove-Item -r -Force "$Directory\\package.json"
                # Remove-Item -r -Force "$Directory\\package-lock.json"
                [System.GC]::Collect()
            }
        }
        elseif ($PackageName) {
            # npm i "$PackageName@next" --legacy-peer-deps
            # npm i "$PackageName@next" --force
            npm i "$PackageName@next" --force ;
            npm audit fix ; 
            npm audit fix --force ;  
            Remove-Item -r -Force "$Directory\\*"
            # Remove-Item -r -Force "$Directory\\node_modules"
            # Remove-Item -r -Force "$Directory\\package.json"
            # Remove-Item -r -Force "$Directory\\package-lock.json"
            [System.GC]::Collect()
        }
        else {
            Write-Host "PackageName OR PackageArray required with the AllNext option."
        }
    }
    if ($AllMajorVersions) {
        if ($PackageArray) {
            # foreach ($PackageName in $PackageArray) { $($LowerVersionRange..$UpperVersionRange).foreach({ npm i $PackageName"@^"$_ --legacy-peer-deps }) }    
            foreach ($PackageName in $PackageArray) {
                # $($LowerVersionRange..$UpperVersionRange).foreach({ 
                $($LowerVersionRange..$UpperVersionRange) | foreach-object -parallel ({ 
                    $PackageName = $using:PackageName
                    $Directory = $using:Directory
                    if($null -ne $using:BaseVersion){
                        $BaseVersion = $using:BaseVersion
                    }
                    
                        if ($null -ne $BaseVersion ) {
                            npm i "$PackageName@^$BaseVersion.$_" --force ;
                        }
                        else {
                            npm i "$PackageName@^$_" --force ;
                        }
                        npm audit fix ; 
                        npm audit fix --force ;  
                        Remove-Item -r -Force "$Directory\\*"
                        # Remove-Item -r -Force "$Directory\\node_modules"
                        # Remove-Item -r -Force "$Directory\\package.json"
                        # Remove-Item -r -Force "$Directory\\package-lock.json"
                        [System.GC]::Collect()
                    }) 
            }
        }
        elseif ($PackageName) {
            # $($LowerVersionRange..$UpperVersionRange).foreach({ npm i $PackageName"@^"$_ --legacy-peer-deps })
            $($LowerVersionRange..$UpperVersionRange).foreach({ 
                    if ($BaseVersion -eq "") {
                        npm i $PackageName"@^"$BaseVersion.$_ --force 
                    }
                    else {
                        npm i $PackageName"@^"$_ --force 
                    }
                
                    npm audit fix ; 
                    npm audit fix --force ;  
                    Remove-Item -r -Force "$Directory\\*"
                    # Remove-Item -r -Force "$Directory\\node_modules"
                    # Remove-Item -r -Force "$Directory\\package.json"
                    # Remove-Item -r -Force "$Directory\\package-lock.json"
                    [System.GC]::Collect()
                })
        }
        else {
            Write-Host "PackageName OR PackageArray required with the AllMajorVersions option."
        }
    }
}




function Build-NPMList {
    # Return to STDOUT
    # $(97..122).foreach({ Build-NPMList -PackageName "svelte-$([char]$_)" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\npmPackageFiles\requests\svelte.txt" })
    # Build-NPMList -PackageName "sveltejs" 
    # Add to and clean up a txt file
    # Build-NPMList -PackageName "sveltejs" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\npmPackageFiles\requests\svelte.txt"
    # Build-NPMList -PackageName "react" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\npmPackageFiles\requests\react.txt"
    # Build-NPMList -PackageName "react-" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\npmPackageFiles\requests\react.txt"
    # Build-NPMList -PackageName "cra-template" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\npmPackageFiles\requests\react.txt"
    # Build-NPMList -PackageName "cra-template-" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\npmPackageFiles\requests\react.txt"
    # Add to and clean up a txt file based on an array of packages
    # Build-NPMList PackageArray $PackageArray -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\npmPackageFiles\packageLists\random.txt"
    param (
        [string]$PackageName,
        [System.Collections.ArrayList]$PackageArray,
        [string]$OutputFile,
        # [int]$Iterations = 2,
        [string]$Registry = "https://registry.npmjs.org/"
    )
    $TempFile = "C:\Windows\Temp\npmFiles.txt"
    $null > $TempFile
    # $count = 0
    # $newfiles = New-Object System.Collections.ArrayList
    if ($PackageArray) {
        foreach ($PackageName in $PackageArray) { 
            (npm search -p $PackageName --registry $Registry).foreach({ ($_.split(" ")[0]).split("`t")[0] }) | Sort-Object -Unique >> $TempFile
            # npm search and clean up
            
            # # New Test START
            
            # $files = (npm search -p $PackageName ).foreach({ $_.split(" ")[0].split("`t")[0] })
            # while ($count -lt $Iterations) {
            #     $count++
            #     ($files |  Foreach-Object -ThrottleLimit 5 -Parallel {
            #             $files += (npm search -p $_ ).foreach({ $_.split(" ")[0].split("`t")[0] })
            #             $files | Sort-Object -Unique >> $TempFile
            #         }
            #     )    
            # }

            # # New Test END
            [System.GC]::Collect()
        }
    }
    elseif ($PackageName) {
        (npm search -p $PackageName --registry $Registry).foreach({ ($_.split(" ")[0]).split("`t")[0] }) | Sort-Object -Unique >> $TempFile
        #  # New Test START
            
        #  $files = (npm search -p $PackageName ).foreach({ $_.split(" ")[0].split("`t")[0] })
        #  while ($count -lt $Iterations) {
        #      $count++
        #      ($files |  Foreach-Object -ThrottleLimit 5 -Parallel {
        #              $files += (npm search -p $_ ).foreach({ $_.split(" ")[0].split("`t")[0] })
        #              $files | Sort-Object -Unique >> $TempFile
        #          }
        #      )    
        #  }

        #  # New Test END
        [System.GC]::Collect()
    }
    else {
        Write-Host "PackageName OR PackageArray required with the AllLatest option."
    }
    if ($OutputFile) {
        $files = Get-Content $OutputFile 
        $files >> $TempFile
        $files = Get-Content $TempFile
        $files = $files | Sort-Object -Unique
        $files = $files | Sort-Object -Unique
        $files > $OutputFile
        $files.Count
    }
    else {
        return $(Get-Content $TempFile | sort-Object -Unique )
    }
    # Remove-Item -Force $TempFile
}

################# 
################# 
################# 
# $directories = [System.IO.Directory]::EnumerateDirectories("D:\Transfer\toMove\Software\Verdaccio\Storage\data\", "*", [System.IO.SearchOption]::TopDirectoryOnly)

# foreach ($dir in $directories) {
#     $files = [System.IO.Directory]::EnumerateFiles($dir)
#     if ($files.Count -eq 1) {
#         Write-Output $dir
#     }
# }

# function Get-DirectoriesWithSingleFile {
#     param(
#         [string]$path
#     )

#     $directories = [System.IO.Directory]::EnumerateDirectories($path)

#     foreach ($directory in $directories) {
#         $files = [System.IO.Directory]::EnumerateFiles($directory)

#         # if ($files.Count -eq 1) {
#         if ($files.Count -lt 1) {
#             Write-Output $directory
#         }

#         Get-DirectoriesWithSingleFile -path $directory
#     }
# }

# Get-DirectoriesWithSingleFile -path "D:\Transfer\toMove\Software\Verdaccio\Storage\data\"
################# 

function Get-DirectoriesWithSingleFile {
    param (
        [string]$path
    )

    $directories = [System.IO.Directory]::GetDirectories($path)

    foreach ($directory in $directories) {
        $files = [System.IO.Directory]::GetFiles($directory)

        if ($files.Count -eq 1) {
            Write-Output $directory
        }

        Get-DirectoriesWithSingleFile -path $directory
    }
}

$files = Get-DirectoriesWithSingleFile -path "D:\Transfer\toMove\Software\Verdaccio\Storage\data\"
$newFiles = $files | foreach {$_.Replace('D:\Transfer\toMove\Software\Verdaccio\Storage\data\','')}
$newfiles = $newfiles.Replace('\','/')
$newfiles.count
$newFiles > "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\packageLists\\missingFiles2.txt" 
################# 