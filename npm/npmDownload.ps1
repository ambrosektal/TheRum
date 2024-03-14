
#### NPM for Windows
# <EXAMPLE 1>
# If Verdaccio is not working, this can be used to download all the packages from the npm registry.

##################################################################################################################
# TESTING!!!!!!!!!!!!
    # $txtfiles = (gc C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\requests\\dotenv.txt)
    # $txtfiles = (gc C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\packageLists\\pocketbase.txt)
    # $txtfiles = (gc C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\requests\\gyp.txt)
    # $txtfiles = (gc C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\packageLists\\fastify.txt)
    # $txtfiles = (gc C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\packageLists\\Microsoft.txt)
    # $txtfiles = (gc C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\requests\\react.txt)
    # $txtfiles = (gc C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\requests\\faye.txt)
    # $txtfiles = (gc C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\requests\\bun.txt)
    # $txtfiles = (gc C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\requests\\vite.txt)
    # $txtfiles = (gc C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\requests\\esbuild.txt)
    # $txtfiles = (gc C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\requests\\firebase.txt)
    # $txtfiles = (gc C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\requests\\babel.txt)
    # $txtfiles = (gc C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\requests\\ripgrep.txt)
    # $txtfiles = (gc C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\requests\\kevin.txt)
    # $txtfiles = (gc C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\requests\\eslint.txt)
    # $txtfiles = (gc C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\requests\\rails.txt)
    # $txtfiles = (gc C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\requests\\typescript.txt)
    # $txtfiles = (gc C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\requests\\kube.txt)
    # $txtfiles = (gc C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\requests\\jspdf.txt)
    # $txtfiles = (gc C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\requests\\bootstrap.txt)
    # $txtfiles = (gc C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\requests\\uiw.txt)
    # $txtfiles = (gc C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\requests\\mdxeditor.txt)
    # $txtfiles = (gc C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\requests\\react-mde.txt)
    # $txtfiles = (gc C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\packageLists\\datatables.txt)
    # $txtfiles = (gc "C:\Users\$env:USERNAME\Downloads\gits\TheRum\npmPackageFiles\requests\idb.txt")
    # $txtfiles = (gc C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\firstHalf.txt)
    # $txtfiles = (gc C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\secondHalf.txt)


Start-Transcript -Path "D:\Transfer\newlog_$(Get-Random).txt"
$executionTime = Measure-Command {
    
    
    $registry = "https://registry.npmjs.org/"
    # $registry = "http://127.0.0.1:4873/"
    
    $txtfiles | ForEach-Object -Parallel {
        $registry = $using:registry
        $outputBaseDirectory = "D:\\Transfer\\ToMove\\nodepack"
        $npmBaseDirectory = "D:\\Transfer\\ToMove\\node"
        $random = Get-Random
        $outputDirectory = "$outputBaseDirectory\\$random"
        $npmDirectory = "$npmBaseDirectory\\$random"

        if (-not (Test-Path -Path $outputDirectory -PathType Container)) {
            New-Item -Path $outputDirectory -ItemType Directory -Force
            New-Item -Path $npmDirectory -ItemType Directory -Force
        }
        # Set-Location -Path $outputDirectory
        npm i $_ --force --prefix $npmDirectory --registry $registry

        # npm list --all --parseable -l --prefix $npmDirectory --registry $registry | ForEach-Object {
        npm list --all --parseable -l --prefix $npmDirectory --registry $registry | ForEach-Object -Parallel {
            $registry = $using:registry
            $outputDirectory = $using:outputDirectory
            $packagePath = $_.Split(":")[2].Trim()
            npm pack --registry $registry --pack-destination $outputDirectory $packagePath

        }

        Remove-Item -r -Force $npmDirectory
    }

}
Stop-Transcript
Write-Host "Total execution time: $($executionTime.TotalMilliseconds) ms"
##################################################################################################################

# <EXAMPLE 2>

Start-Transcript -Path "D:\Transfer\newlog_$(Get-Random).txt"
$executionTime = Measure-Command {
    
    
    $registry = "https://registry.npmjs.org/"
    # $registry = "http://127.0.0.1:4873/"
    
    $txtfiles | ForEach-Object -Parallel {
        $registry = $using:registry
        $outputBaseDirectory = "D:\\Transfer\\ToMove\\nodepack"
        $npmBaseDirectory = "D:\\Transfer\\ToMove\\node"
        $random = Get-Random
        $outputDirectory = "$outputBaseDirectory\\$random"
        $npmDirectory = "$npmBaseDirectory\\$random"

        if (-not (Test-Path -Path $outputDirectory -PathType Container)) {
            New-Item -Path $outputDirectory -ItemType Directory -Force
            New-Item -Path $npmDirectory -ItemType Directory -Force
        }
        # Set-Location -Path $outputDirectory
        npm i $_ --force --prefix $npmDirectory --registry $registry

        # npm list --all --parseable -l --prefix $npmDirectory --registry $registry | ForEach-Object -Parallel {
        #     $registry = $using:registry
        #     $outputDirectory = $using:outputDirectory
        #     $packagePath = $_.Split(":")[2].Trim()
        #     npm pack --registry $registry --pack-destination $outputDirectory $packagePath
        # }

        Remove-Item -r -Force $npmDirectory
    }

}
Stop-Transcript
Write-Host "Total execution time: $($executionTime.TotalMilliseconds) ms"
##################################################################################################################

# <EXAMPLE 3>
## Build text files of all the npm packages to download

$txtfiles = (gci -recurse C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\ -Filter "*.txt")
# $txtfiles = (gci -recurse C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\requests\\ -Filter "*.txt")
# $txtfiles = (gci -recurse C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\packageLists\\ -Filter "*.txt")
# $txtfiles = (gci -recurse C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\others\\ -Filter "*.txt")
$files = $txtfiles | foreach { gc $_ }
$files = $files | Sort-Object -Unique
$files = $files | Sort-Object -Unique

$first50files = $files[0..$($files.count * .50)]
$second50files = $files[$($files.count * .50)..$($files.count)]

$25files = $files[0..$($files.count * .25)]
$50files = $files[$($files.count * .25)..$($files.count * .50)]
$75files = $files[$($files.count * .50)..$($files.count * .75)]
$100files = $files[$($files.count * .75)..$($files.count)]

$25files.count
$50files.count
$75files.count
$100files.count


$first50files.count
$second50files.count

$first50files > C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\firstHalf.txt
$second50files > C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\secondHalf.txt

$25files > C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\firstQuarter.txt
$50files > C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\secondQuarter.txt
$75files > C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\thirdQuarter.txt
$100files > C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\fourthQuarter.txt


############################


$txtfiles = (gci -recurse C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\ -Filter "*.txt")
$files = $txtfiles | foreach { gc $_ }
$files = $files | Sort-Object -Unique
$files = $files | Sort-Object -Unique

$files = $files[$($files.count * .50)..$($files.count)]
$files.count

$files > C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\secondHalf.txt

############################

SimpleNPMDownload -PackageListTxtFile "C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\firstHalf.txt" 

SimpleNPMDownload -PackageListTxtFile "C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\secondHalf.txt" 


SimpleNPMDownload -PackageListTxtFile "C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\firstQuarter.txt" 
SimpleNPMDownload -PackageListTxtFile "C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\secondQuarter.txt" 
SimpleNPMDownload -PackageListTxtFile "C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\thirdQuarter.txt" 
SimpleNPMDownload -PackageListTxtFile "C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\fourthQuarter.txt" 

# $files = gc "C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\firstQuarter.txt" 
# $files = $files[$($files.count * .50)..$($files.count)]
# $files > "C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\firstQuarter.txt" 

# $files = gc "C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\secondQuarter.txt" 
# $files = $files[$($files.count * .50)..$($files.count)]
# $files > "C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\secondQuarter.txt" 

# $files = gc "C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\thirdQuarter.txt" 
# $files = $files[$($files.count * .50)..$($files.count)]
# $files > "C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\thirdQuarter.txt" 

# $files = gc "C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\fourthQuarter.txt" 
# $files = $files[$($files.count * .50)..$($files.count)]
# $files > "C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\fourthQuarter.txt" 


############################

# SimpleNPMDownload -PackageListTxtFile "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\requests\\vmware.txt"
# SimpleNPMDownload -PackageListTxtFile "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\requests\\react.txt"
# SimpleNPMDownload -PackageListTxtFile "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\requests\\svelte.txt"
# SimpleNPMDownload -PackageListTxtFile "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\packageLists\\requests.txt" 
# SimpleNPMDownload -PackageListTxtFile "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\packageLists\\missingFiles.txt" 
# SimpleNPMDownload -PackageListTxtFile "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\requests\\createapps.txt" 
# SimpleNPMDownload -PackageListTxtFile "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\requests\\others.txt" 
# SimpleNPMDownload -PackageListTxtFile "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\requests\\esbuild.txt" 
# SimpleNPMDownload -PackageListTxtFile "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\requests\\bun.txt" 
# SimpleNPMDownload -PackageListTxtFile "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\requests\\mantine.txt" 
# SimpleNPMDownload -PackageListTxtFile "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\requests\\webpacker.txt" 
# SimpleNPMDownload -PackageListTxtFile "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\requests\\rails.txt" 
# SimpleNPMDownload -PackageListTxtFile "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\requests\\babel.txt" 
# SimpleNPMDownload -PackageListTxtFile "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\requests\\vite.txt" 
# SimpleNPMDownload -PackageListTxtFile "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\requests\\nettest.txt" 
# SimpleNPMDownload -PackageListTxtFile "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\requests\\typescript.txt" 
# SimpleNPMDownload -PackageListTxtFile "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\requests\\kube.txt" 
# SimpleNPMDownload -PackageListTxtFile "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\requests\\iconify.txt" 
# SimpleNPMDownload -PackageListTxtFile "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\requests\\font-awesome.txt" 
# SimpleNPMDownload -PackageListTxtFile "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\requests\\axios.txt" 
# SimpleNPMDownload -PackageListTxtFile "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\requests\\dotenv.txt" 
# SimpleNPMDownload -PackageListTxtFile "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\requests\\faye.txt" 
# SimpleNPMDownload -PackageListTxtFile "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\requests\\gyp.txt" 
# SimpleNPMDownload -PackageListTxtFile "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\requests\\misc.txt" 
# SimpleNPMDownload -PackageListTxtFile "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\requests\\redux.txt" 
# SimpleNPMDownload -PackageListTxtFile "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\requests\\swagger.txt" 
# SimpleNPMDownload -PackageListTxtFile "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\requests\\vsphere.txt" 
# SimpleNPMDownload -PackageListTxtFile "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\requests\\uiw.txt" 
# SimpleNPMDownload -PackageListTxtFile "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\requests\\mdxeditor.txt" 
# SimpleNPMDownload -PackageListTxtFile "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\requests\\rehyperemark.txt" 
# SimpleNPMDownload -PackageListTxtFile "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\others\\needsUpdates.txt" 
# SimpleNPMDownload -PackageListTxtFile "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\requests\\testing.txt" 
# SimpleNPMDownload -PackageListTxtFile "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\TopLists\\TopPackages20230227.txt" 

# SimpleNPMDownload -InstallDirectory "D:\Transfer\Staging\node" -PackageListTxtFile "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\svelte.txt"
# SimpleNPMDownload -InstallDirectory "D:\Transfer\Moved\node" -PackageListTxtFile "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\packageLists\\requests.txt" 

# SimpleNPMDownload -DirectoryOfPackageListTxtFiles "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\requests"
# SimpleNPMDownload -DirectoryOfPackageListTxtFiles "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\others"
# SimpleNPMDownload -DirectoryOfPackageListTxtFiles "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\TopLists"
# SimpleNPMDownload -DirectoryOfPackageListTxtFiles "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\packageLists"

function SimpleNPMDownload {

    param (
        [string]$npmPackageList,
        [string]$PackageListTxtFile,
        [string]$DirectoryOfPackageListTxtFiles,
        [string]$InstallDirectory,
        [array]$npmPackageArray,
        # [string]$Registry = "https://registry.npmjs.org/",
        [string]$Registry = "http://127.0.0.1:4873/",
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
        try {
            $clean = $unclean.Replace('\', '/') | Sort-Object -Unique    
        }
        catch {
            $clean = $unclean | Sort-Object -Unique
        }
        
        Write-Host "yay, I'm in the correct directory!!!"
        # $clean | foreach-object -Parallel ({
        $clean | foreach-object -ThrottleLimit 5 -Parallel ({
            [System.GC]::Collect()
                $Registry = $using:Registry
                write-host "Downloading $_ ..."
                [string]$random = Get-Random -Maximum 999999 -Minimum 100000
                mkdir "D:\\Transfer\\ToMove\\node\\$random"
                if (!$(Test-Path "D:\\Transfer\\ToMove\\node\\$random")) {
                    mkdir "D:\\Transfer\\ToMove\\node\\$random"
                }
                try {
                    npm i $_"@latest" --force --registry $Registry --prefix "D:\\Transfer\\ToMove\\node\\$random"; 
                    Remove-Item -r -Force "D:\\Transfer\\ToMove\\node\\$random\\*" ;
                    npm i $_ --force --registry $Registry --prefix "D:\\Transfer\\ToMove\\node\\$random" ; 
                }
                catch {
                    Write-Host "Failed to install $_" ; 
                }
                try {
                    npm i $_ --force --prefix "D:\\Transfer\\ToMove\\node\\$random" --registry $Registry; 
                }
                catch {
                    Write-Host "Failed to install $_" ; 
                }
                # npm i $_ --force --prefix "D:\\Transfer\\ToMove\\node\\$random"; 
                cd "D:\\Transfer\\ToMove\\node\\$random"; 
                npm audit fix --registry $Registry; 
                npm audit fix --force --registry $Registry; 
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
        [string]$BaseVersion = $null

    )
    # NOTES
    # If you see ~1.0.2 it means to install version 1.0.2 or the latest patch version such as 1.0.4. 
    # If you see ^1.0.2 it means to install version 1.0.2 or the latest minor or patch version such as 1.1.0.
    # Install-NpmPackages -PackageName svelte -AllMajorVersions
    # $packageArray = gc "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\newnet.txt"
    # $packageArray = gc "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\requests\\react-router.txt" 
    # $packageArray = gc "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\requests\\react.txt" 
    # $packageArray = gc "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\requests\\esbuild.txt" 
    # $packageArray = gc "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\requests\\babel.txt" 
    # $packageArray = gc "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\requests\\svelte.txt" 
    # $packageArray = gc "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\requests\\font-awesome.txt" 
    # $packageArray = gc "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\requests\\webpacker.txt" 
    # $packageArray = gc "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\requests\\rails.txt" 
    # $packageArray = gc "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\requests\\nettest.txt" 
    # Install-NpmPackages -PackageArray $packageArray -AllLatest
    # Install-NpmPackages -PackageArray $packageArray -AllMajorVersions -UpperVersionRange 20 -LowerVersionRange 0 -BaseVersion '0'

    # & "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\Install-NpmPackages.ps1" -PackageArray $packageArray -AllMajorVersions -LowerVersionRange 0 -UpperVersionRange 25

    # # This method cycles over all the packages in an array and pulls all the versions you pass into it.
    # $(0..25) | foreach-object -Parallel {
    #     $BaseVersion = $_
    #     $packageArray = $using:PackageArray
    #     & "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\Install-NpmPackages.ps1" -PackageArray $packageArray -AllMajorVersions -LowerVersionRange 0 -UpperVersionRange 20 -BaseVersion 18
    #     # & "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\Install-NpmPackages.ps1" -PackageName @devcontainers/cli -AllMajorVersions -LowerVersionRange 0 -UpperVersionRange 53 -BaseVersion 0.$BaseVersion
    # }
    

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
            foreach ($PackageName in $PackageArray) {
                Foreach-Object -parallel ({ 
                        $PackageName = $using:PackageName
                        $Directory = $using:Directory
                        write-host "Downloading $PackageName ..."
                        [string]$random = Get-Random -Maximum 999999 -Minimum 100000
                        mkdir "D:\\Transfer\\ToMove\\node\\$random"
                        try {
                            npm i "$PackageName@latest" --force --prefix "D:\\Transfer\\ToMove\\node\\$random"; 
                        }
                        catch {
                            npm i "$PackageName" --force --prefix "D:\\Transfer\\ToMove\\node\\$random"; 
                        }
                        cd "D:\\Transfer\\ToMove\\node\\$random"; 
                        npm audit fix ; 
                        npm audit fix --force ; 
                        cd "D:\\Transfer\\ToMove\\node\\"; 
                        Remove-Item -r -Force "D:\\Transfer\\ToMove\\node\\$random"
                        [System.GC]::Collect()
                    }) 
            }
        }
        elseif ($PackageName) {
            Foreach-Object -Parallel ({ 
                    $PackageName = $using:PackageName
                    $Directory = $using:Directory
                    write-host "Downloading $_ ..."
                    [string]$random = Get-Random -Maximum 999999 -Minimum 100000
                    mkdir "D:\\Transfer\\ToMove\\node\\$random"
                    try {
                        npm i "$PackageName@latest" --force --prefix "D:\\Transfer\\ToMove\\node\\$random"; 
                    }
                    catch {
                        npm i "$PackageName" --force --prefix "D:\\Transfer\\ToMove\\node\\$random"; 
                    }
                    cd "D:\\Transfer\\ToMove\\node\\$random"; 
                    npm audit fix ; 
                    npm audit fix --force ; 
                    cd "D:\\Transfer\\ToMove\\node\\"; 
                    Remove-Item -r -Force "D:\\Transfer\\ToMove\\node\\$random"
                    [System.GC]::Collect()
                })
        }

        # if ($PackageArray) {
        #     # foreach ($PackageName in $PackageArray) { npm i "$PackageName@latest" --legacy-peer-deps }
        #     # foreach ($PackageName in $PackageArray) { npm i "$PackageName@latest" --force }
        #     foreach ($PackageName in $PackageArray) { 
        #         # npm i "$PackageName@latest" --force ;
        #         npm i "$PackageName" --force ;
        #         npm audit fix ; 
        #         npm audit fix --force ;  
        #         Remove-Item -r -Force "$Directory\\*"
        #         # Remove-Item -r -Force "$Directory\\node_modules"
        #         # Remove-Item -r -Force "$Directory\\package.json"
        #         # Remove-Item -r -Force "$Directory\\package-lock.json"
        #         [System.GC]::Collect()
        #     }
        # }
        # elseif ($PackageName) {
        #     # npm i "$PackageName@latest" --legacy-peer-deps
        #     # npm i "$PackageName@latest" --force
        #     # npm i "$PackageName@latest" --force ;
        #     npm i "$PackageName" --force ;
        #     npm audit fix ; 
        #     npm audit fix --force ;  
        #     Remove-Item -r -Force "$Directory\\*"
        #     # Remove-Item -r -Force "$Directory\\node_modules"
        #     # Remove-Item -r -Force "$Directory\\package.json"
        #     # Remove-Item -r -Force "$Directory\\package-lock.json"
        #     [System.GC]::Collect()
        # }
        else {
            Write-Host "PackageName OR PackageArray required with the AllLatest option."
        }
    }
    if ($AllNext) {
        if ($PackageArray) {
            foreach ($PackageName in $PackageArray) {
                foreach-object -parallel ({ 
                        $PackageName = $using:PackageName
                        $Directory = $using:Directory
                        write-host "Downloading $PackageName ..."
                        [string]$random = Get-Random -Maximum 999999 -Minimum 100000
                        mkdir "D:\\Transfer\\ToMove\\node\\$random"
                        try {
                            npm i "$PackageName@next" --force --prefix "D:\\Transfer\\ToMove\\node\\$random"; 
                        }
                        catch {
                            npm i "$PackageName" --force --prefix "D:\\Transfer\\ToMove\\node\\$random"; 
                        }
                        cd "D:\\Transfer\\ToMove\\node\\$random"; 
                        npm audit fix ; 
                        npm audit fix --force ; 
                        cd "D:\\Transfer\\ToMove\\node\\"; 
                        Remove-Item -r -Force "D:\\Transfer\\ToMove\\node\\$random"
                        [System.GC]::Collect()
                    }) 
            }
        }
        elseif ($PackageName) {
            Foreach-Object -Parallel ({ 
                    $PackageName = $using:PackageName
                    $Directory = $using:Directory
                    write-host "Downloading $PackageName ..."
                    [string]$random = Get-Random -Maximum 999999 -Minimum 100000
                    mkdir "D:\\Transfer\\ToMove\\node\\$random"
                    try {
                        npm i "$PackageName@next" --force --prefix "D:\\Transfer\\ToMove\\node\\$random"; 
                    }
                    catch {
                        npm i "$PackageName" --force --prefix "D:\\Transfer\\ToMove\\node\\$random"; 
                    }
                    cd "D:\\Transfer\\ToMove\\node\\$random"; 
                    npm audit fix ; 
                    npm audit fix --force ; 
                    cd "D:\\Transfer\\ToMove\\node\\"; 
                    Remove-Item -r -Force "D:\\Transfer\\ToMove\\node\\$random"
                    [System.GC]::Collect()
                })
        }


        # if ($PackageArray) {
        #     # foreach ($PackageName in $PackageArray) { npm i "$PackageName@next" --legacy-peer-deps }
        #     # foreach ($PackageName in $PackageArray) { npm i "$PackageName@next" --force }
        #     foreach ($PackageName in $PackageArray) { 
        #         npm i "$PackageName@next" --force ;
        #         npm audit fix ; 
        #         npm audit fix --force ;  
        #         Remove-Item -r -Force "$Directory\\*"
        #         # Remove-Item -r -Force "$Directory\\node_modules"
        #         # Remove-Item -r -Force "$Directory\\package.json"
        #         # Remove-Item -r -Force "$Directory\\package-lock.json"
        #         [System.GC]::Collect()
        #     }
        # }
        # elseif ($PackageName) {
        #     # npm i "$PackageName@next" --legacy-peer-deps
        #     # npm i "$PackageName@next" --force
        #     npm i "$PackageName@next" --force ;
        #     npm audit fix ; 
        #     npm audit fix --force ;  
        #     Remove-Item -r -Force "$Directory\\*"
        #     # Remove-Item -r -Force "$Directory\\node_modules"
        #     # Remove-Item -r -Force "$Directory\\package.json"
        #     # Remove-Item -r -Force "$Directory\\package-lock.json"
        #     [System.GC]::Collect()
        # }
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
                        if ($using:BaseVersion) {
                            $BaseVersion = $using:BaseVersion
                        }
                        write-host "Downloading $_ ..."
                        [string]$random = Get-Random -Maximum 999999 -Minimum 100000
                        mkdir "D:\\Transfer\\ToMove\\node\\$random"
                        if ($BaseVersion ) {
                            npm i "$PackageName@~$BaseVersion.$_" --force --prefix "D:\\Transfer\\ToMove\\node\\$random"; 
                        }
                        else {
                            # npm i "$PackageName@$_" --force --prefix "D:\\Transfer\\ToMove\\node\\$random"; 
                            npm i "$PackageName@~$_" --force --prefix "D:\\Transfer\\ToMove\\node\\$random"; 
                            # npm i "$PackageName@^$_" --force --prefix "D:\\Transfer\\ToMove\\node\\$random"; 
                        }
                        cd "D:\\Transfer\\ToMove\\node\\$random"; 
                        npm audit fix ; 
                        npm audit fix --force ; 
                        cd "D:\\Transfer\\ToMove\\node\\"; 
                        Remove-Item -r -Force "D:\\Transfer\\ToMove\\node\\$random"
                        [System.GC]::Collect()
                    }) 
            }
        }
        elseif ($PackageName) {
            # $($LowerVersionRange..$UpperVersionRange).foreach({ npm i $PackageName"@^"$_ --legacy-peer-deps })
            # $($LowerVersionRange..$UpperVersionRange).foreach({ 
            # $($LowerVersionRange..$UpperVersionRange).foreach({ 
            $($LowerVersionRange..$UpperVersionRange) | Foreach-Object -Parallel ({ 
                    # if ($null -ne $BaseVersion -or $BaseVersion -ne "" -or $BaseVersion -eq [int] ) {
                    $PackageName = $using:PackageName
                    $Directory = $using:Directory
                    if ($using:BaseVersion) {
                        $BaseVersion = $using:BaseVersion
                    }
                    write-host "Downloading $_ ..."
                    [string]$random = Get-Random -Maximum 999999 -Minimum 100000
                    mkdir "D:\\Transfer\\ToMove\\node\\$random"
                    if ($BaseVersion ) {
                        npm i "$PackageName@~$BaseVersion.$_" --force --prefix "D:\\Transfer\\ToMove\\node\\$random"; 
                    }
                    else {
                        npm i "$PackageName@~$_" --force --prefix "D:\\Transfer\\ToMove\\node\\$random"; 
                    }
                    cd "D:\\Transfer\\ToMove\\node\\$random"; 
                    npm audit fix ; 
                    npm audit fix --force ; 
                    cd "D:\\Transfer\\ToMove\\node\\"; 
                    Remove-Item -r -Force "D:\\Transfer\\ToMove\\node\\$random"
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
    # $(97..122).foreach({ Build-NPMList -PackageName "@novnc/$([char]$_)" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\npmPackageFiles\requests\novnc.txt" })
    # $(97..122).foreach({ Build-NPMList -PackageName "vcenter-$([char]$_)" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\npmPackageFiles\requests\vmware.txt" })
    # $(97..122).foreach({ Build-NPMList -PackageName "@vcenter/$([char]$_)" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\npmPackageFiles\requests\vmware.txt" })
    # $(97..122).foreach({ Build-NPMList -PackageName "vmware-$([char]$_)" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\npmPackageFiles\requests\vmware.txt" })
    # $(97..122).foreach({ Build-NPMList -PackageName "@vmware/$([char]$_)" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\npmPackageFiles\requests\vmware.txt" })
    # $(97..122).foreach({ Build-NPMList -PackageName "vsphere-$([char]$_)" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\npmPackageFiles\requests\vmware.txt" })
    # $(97..122).foreach({ Build-NPMList -PackageName "@vsphere/$([char]$_)" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\npmPackageFiles\requests\vmware.txt" })
    # $(97..122).foreach({ Build-NPMList -PackageName "@babel/$([char]$_)" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\npmPackageFiles\requests\babel.txt" })
    # $(97..122).foreach({ Build-NPMList -PackageName "@devcontainers/$([char]$_)" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\npmPackageFiles\requests\devcontainers.txt" })
    # $(97..122).foreach({ Build-NPMList -PackageName "react-mde-$([char]$_)" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\npmPackageFiles\requests\react-mde.txt" })
    # Build-NPMList -PackageName "sveltejs" 
    # Add to and clean up a txt file
    # Build-NPMList -PackageName "ripgrep" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\npmPackageFiles\requests\ripgrep.txt"
    # Build-NPMList -PackageName "novnc" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\npmPackageFiles\requests\novnc.txt"
    # Build-NPMList -PackageName "split-file" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\npmPackageFiles\requests\split-file.txt"
    # Build-NPMList -PackageName "sveltejs" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\npmPackageFiles\requests\svelte.txt"
    # Build-NPMList -PackageName "vcenter" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\npmPackageFiles\requests\vcenter.txt"
    # Build-NPMList -PackageName "vsphere" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\npmPackageFiles\requests\vsphere.txt"
    # Build-NPMList -PackageName "@babel/runtime" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\npmPackageFiles\requests\babel.txt"
    # Build-NPMList -PackageName "react-useanimations" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\npmPackageFiles\requests\react-useanimations.txt"
    # Build-NPMList -PackageName "react-" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\npmPackageFiles\requests\react.txt"
    # Build-NPMList -PackageName "cra-template" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\npmPackageFiles\requests\react.txt"
    # Build-NPMList -PackageName "cra-template-" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\npmPackageFiles\requests\react.txt"
    # Build-NPMList -PackageName "jsdoc" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\npmPackageFiles\requests\jsdoc.txt"
    # Build-NPMList -PackageName "faye" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\npmPackageFiles\requests\faye.txt"
    # Build-NPMList -PackageName "font-awesome" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\npmPackageFiles\requests\font-awesome.txt"
    # Build-NPMList -PackageName "@uiw" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\npmPackageFiles\requests\uiw.txt"
    # Build-NPMList -PackageName "idb-kv-store" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\npmPackageFiles\requests\idb.txt"
    # Add to and clean up a txt file based on an array of packages
    # Build-NPMList PackageArray $PackageArray -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\npmPackageFiles\packageLists\random.txt"
    param (
        [string]$PackageName,
        [System.Collections.ArrayList]$PackageArray,
        [string]$OutputFile,
        [string]$Registry = "https://registry.npmjs.org/"
    )
    $TempFile = "C:\Windows\Temp\npmFiles.txt"
    $null > $TempFile
    if ($PackageArray) {
        foreach ($PackageName in $PackageArray) { 
            (npm search -p $PackageName --registry $Registry).foreach({ ($_.split(" ")[0]).split("`t")[0] }) | Sort-Object -Unique >> $TempFile
            [System.GC]::Collect()
        }
    }
    elseif ($PackageName) {
        (npm search -p $PackageName --registry $Registry).foreach({ ($_.split(" ")[0]).split("`t")[0] }) | Sort-Object -Unique >> $TempFile
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
$newFiles = $files | foreach { $_.Replace('D:\Transfer\toMove\Software\Verdaccio\Storage\data\', '') }
$newfiles = $newfiles.Replace('\', '/')
$newfiles.count
$newFiles > "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\packageLists\\missingFiles2.txt" 
################# 


$packageArray = "react","react-dom","react-router","react-router-dom","dotenv"

# $packageArray = gc "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\requests\\kevin.txt"
$packageArray = gc "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\requests\\angular.txt"

$(0..20) | foreach-object -Parallel {
    $BaseVersion = $_
    $packageArray = $using:PackageArray
    & "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\Install-NpmPackages.ps1" -PackageArray $packageArray -AllMajorVersions -UpperVersionRange 20 -LowerVersionRange 0 -BaseVersion $BaseVersion 
    # Write-Host $BaseVersion
}


# $PackageName = "npm"
# $PackageName = "dotenv"
$PackageName = "split-file"
$(0..20) | foreach-object -Parallel {
    $BaseVersion = $_
    # $packageArray = $using:PackageArray
    $PackageName = $using:PackageName
    & "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\Install-NpmPackages.ps1" -PackageName $PackageName -AllMajorVersions -UpperVersionRange 20 -LowerVersionRange 0 -BaseVersion $BaseVersion 
    # Write-Host $BaseVersion
}


# # Plull all the files from a directory and subdirectories and then make it a list that can be used to install packages.
$files = (gci -recurse -Filter "package.json" | Where-Object { $_.CreationTime -lt (Get-Date).AddDays(-30) }).Directory.FullName
$directoryToRemove = 'D:\Transfer\software\verdaccio\storage\data\'
$files = $files -replace [regex]::Escape($directoryToRemove), ''
$files = $files -replace [regex]::Escape('\'), '/'
$files





# get the npm info as a json object
$package = npm info @rails/webpacker --json | convertFrom-json


$package.versions | Foreach-Object -Parallel {
    $package=$using:package
    # npm i --force "$($($package.name).trim())@$_"
    $packageToDownload = "$($($package.name).Trim())@$_"
    Write-Host "npm i --force $packageToDownload"
    npm i --force $packageToDownload
}

# Testing JSON downloads....
function NPMVersionsDownload {
    # SimpleNPMDownload -PackageListTxtFile "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\requests\\vmware.txt"
    # NPMVersionsDownload -PackageListTxtFile "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\requests\\react.txt"
    # SimpleNPMDownload -PackageListTxtFile "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\requests\\svelte.txt"
    # SimpleNPMDownload -PackageListTxtFile "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\packageLists\\requests.txt" 
    # SimpleNPMDownload -PackageListTxtFile "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\packageLists\\missingFiles.txt" 
    # SimpleNPMDownload -PackageListTxtFile "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\requests\\createapps.txt" 
    # SimpleNPMDownload -PackageListTxtFile "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\requests\\others.txt" 
    # SimpleNPMDownload -PackageListTxtFile "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\requests\\esbuild.txt" 
    # SimpleNPMDownload -PackageListTxtFile "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\requests\\bun.txt" 
    # SimpleNPMDownload -PackageListTxtFile "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\requests\\mantine.txt" 
    # NPMVersionsDownload -PackageListTxtFile "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\requests\\webpacker.txt" 
    # NPMVersionsDownload -PackageListTxtFile "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\requests\\rails.txt" 
    # NPMVersionsDownload -PackageListTxtFile "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\requests\\babel.txt" 
    # NPMVersionsDownload -PackageListTxtFile "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\requests\\nettest.txt" 
    # NPMVersionsDownload -PackageListTxtFile "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\requests\\faye.txt" 
    # NPMVersionsDownload -PackageListTxtFile "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\requests\\idb.txt" 
    # SimpleNPMDownload -PackageListTxtFile "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\others\\needsUpdates.txt" 
    # SimpleNPMDownload -PackageListTxtFile "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\TopLists\\TopPackages20230227.txt" 
    # SimpleNPMDownload -InstallDirectory "D:\Transfer\Staging\node" -PackageListTxtFile "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\svelte.txt"
    # SimpleNPMDownload -InstallDirectory "D:\Transfer\Moved\node" -PackageListTxtFile "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\packageLists\\requests.txt" 
    # NPMVersionsDownload -DirectoryOfPackageListTxtFiles "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\requests"
    # NPMVersionsDownload -DirectoryOfPackageListTxtFiles "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\others"
    # NPMVersionsDownload -DirectoryOfPackageListTxtFiles "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\TopLists"
    # NPMVersionsDownload -DirectoryOfPackageListTxtFiles "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\packageLists"
    param (
        [string]$npmPackageList,
        [string]$PackageListTxtFile,
        [string]$DirectoryOfPackageListTxtFiles,
        [string]$InstallDirectory,
        [array]$npmPackageArray,
        # [string]$Registry = "https://registry.npmjs.org/",
        [string]$Registry = "http://127.0.0.1:4873/",
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
        try {
            $clean = $unclean.Replace('\', '/') | Sort-Object -Unique    
        }
        catch {
            $clean = $unclean | Sort-Object -Unique
        }
        
        Write-Host "yay, I'm in the correct directory!!!"
        # $clean | foreach-object -Parallel ({
        $clean | foreach-object -ThrottleLimit 5 -Parallel ({
            [System.GC]::Collect()
                $Registry = $using:Registry
                write-host "Downloading $_ ..."
                [string]$random = Get-Random -Maximum 999999 -Minimum 100000
                mkdir "D:\\Transfer\\ToMove\\node\\$random"
                if (!$(Test-Path "D:\\Transfer\\ToMove\\node\\$random")) {
                    mkdir "D:\\Transfer\\ToMove\\node\\$random"
                }
                try {
                    $package = npm info $_ --json | convertFrom-json
                    # $package.versions[$($($package.versions).count/2)..$($($package.versions).count)]
                    # $package.versions | Foreach-Object -Parallel {
                    $package.versions | Sort-Object Version -Desc | Select-Object -First 10 | Foreach-Object {
                    # $package.versions[$($($package.versions).count/2)..$($($package.versions).count)] | Foreach-Object -Parallel {
                    # $package.versions[$($($package.versions).count/2)..$($($package.versions).count)] | Foreach-Object {
                        # $package=$using:package
                        # $Registry = $using:Registry
                        # $random = $using:random
                        [string]$random2 = Get-Random -Maximum 9999999 -Minimum 1000000
                        mkdir "D:\\Transfer\\ToMove\\node\\$random\\$random2"
                        if (!$(Test-Path "D:\\Transfer\\ToMove\\node\\$random\\$random2")) {
                            mkdir "D:\\Transfer\\ToMove\\node\\$random\\$random2"
                        }
                        $packageToDownload = "$($($package.name).Trim())@$_"
                        npm i $packageToDownload --force --registry $Registry --prefix "D:\\Transfer\\ToMove\\node\\$random\\$random2" ; 
                        [System.GC]::Collect()
                    }
                }
                catch {
                    Write-Host "Failed to install $_" ; 
                }
                # try {
                #     npm i $_ --force --prefix "D:\\Transfer\\ToMove\\node\\$random" --registry $Registry; 
                # }
                # catch {
                #     Write-Host "Failed to install $_" ; 
                # }
                # # npm i $_ --force --prefix "D:\\Transfer\\ToMove\\node\\$random"; 
                # cd "D:\\Transfer\\ToMove\\node\\$random"; 
                # npm audit fix --registry $Registry; 
                # npm audit fix --force --registry $Registry; 
                # cd "D:\\Transfer\\ToMove\\node\\"; 
                # Remove-Item -r -Force "D:\\Transfer\\ToMove\\node\\$random"
                # [System.GC]::Collect()
            })
    }
    # Remove-Item -r -Force "$InstallDirectory\*"
}



function Prep-NpmJson() {
    param(
        [System.Collections.Arraylist]$allFiles
    )

    if (!$allFiles) {
        $toDeDupeCopy = Get-ChildItem -Filter "*.tgz" -Recurse -Path "D:\\Transfer\\software\\verdaccio\\storage\\data" | Where-Object { $($_.GetType().Name -eq "FileInfo") }
    }
    else {
        $toDeDupeCopy = $allFiles | foreach-object -Parallel ({ Get-ChildItem "*.tgz" -Recurse -Path $_ })
    }
        # Comparing file list with actual file names
        $outputdir = "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum"

        if (Test-Path "$outputdir\npmOutput.json") {
            $files = gc "$outputdir\npmOutput.json" | convertfrom-json
            $files += Get-ChildItem -Recurse -Path 'D:\Transfer\software\verdaccio\storage\data' -Filter "*.tgz" | Select-Object Name, FullName, CreationTime, LastWriteTime, Length 
        }
        else {
            $files += Get-ChildItem -Recurse -Path 'D:\Transfer\software\verdaccio\storage\data' -Filter "*.tgz" | Select-Object Name, FullName, CreationTime, LastWriteTime, Length 
        }

        # Use a hashtable to remember which names have been seen
        $seenNames = @{}

        # Create an array to store the objects with unique names
        $uniqueObjects = @()

        $files.count

        # Loop through each object in the original array
        foreach ($object in $files) {
            # Check if the name has been seen before
            if (-not $seenNames.ContainsKey($object.name)) {
                # Add the name to the hashtable
                $seenNames[$object.name] = $true

                # Add the object to the array of unique objects
                $uniqueObjects += $object
            }
        }

        $files = $uniqueObjects

        $files.count

        Write-Host "Creating new output file..."

        $files | ConvertTo-Json | Out-File "$outputdir\$(Get-Date -Format "yyyyMMdd")_npmOutput.json"

        Write-Host "Copying new output file..."

        Copy-Item -Force "$outputdir\$(Get-Date -Format "yyyyMMdd")_npmOutput.json" "$outputdir\npmOutput.json"

        Write-Host "Gathering ToMove Files..."

        [system.gc]::collect()

}
