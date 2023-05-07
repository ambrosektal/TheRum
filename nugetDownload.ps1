# docker run --rm --name nuget-server -p 5555:80 --env-file "D:\\Transfer\\ToMove\\BaGet_Shared\\baget.env" -v "D:\\Transfer\\ToMove\\BaGet_Shared:/var/baget" loicsharma/baget:latest

# ----------------------------------------------------------------------------


# ----------------------------------------------------------------------------

$files = New-Object System.Collections.ArrayList

$files = gc "C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\nugetPackageFiles\\packageLists2\\vmware.txt"
$files += gc "C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\nugetPackageFiles\\PSGallery\\vmware.txt"
$files += gc "C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\nugetPackageFiles\\packageLists2\\serilog.txt"
$files += gc "C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\nugetPackageFiles\\packageLists2\\skiasharp.txt"
$files += gc "C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\nugetPackageFiles\\packageLists2\\mongo.txt"
$files += gc "C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\nugetPackageFiles\\packageLists2\\dapper.txt"


$files = gc "C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\nugetPackageFiles\\packageLists\\*.txt"
# $files = gc "C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\nugetPackageFiles\\packageLists2\\*.txt"
# $files = gc "C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\nugetPackageFiles\\Microsoft\\*.txt"
# $files = gc "C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\nugetPackageFiles\\Microsoft2\\*.txt"
# $files = gc "C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\nugetPackageFiles\\PSGallery\\*.txt"
$files = $files | Sort-Object -Unique
$files = $files | Sort-Object -Unique

$files = $files[0..$($files.count * .50)]
$files.count



$files = gc "C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\nugetPackageFiles\\packageLists\\*.txt"
# $files = gc "C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\nugetPackageFiles\\packageLists2\\*.txt"
# $files = gc "C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\nugetPackageFiles\\Microsoft\\*.txt"
# $files = gc "C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\nugetPackageFiles\\Microsoft2\\*.txt"
# $files = gc "C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\nugetPackageFiles\\PSGallery\\*.txt"
$files = $files | Sort-Object -Unique
$files = $files | Sort-Object -Unique

$files = $files[$($files.count * .50)..$($files.count)]
$files.count


$files | ForEach-Object -Parallel ({
    nuget install -OutputDirectory "D:\\Transfer\\ToMove\\nupkg\\" $_ 
    [System.GC]::Collect()
})

$files | ForEach-Object -Parallel ({
    nuget install -OutputDirectory "D:\\Transfer\\ToMove\\nupkg\\" $_ -Prerelease
    [System.GC]::Collect()
    })


# nuget

$files.foreach({
        $((find-package "$_**" -Source nuget.org).name).foreach({
                nuget install -OutputDirectory "D:\\Transfer\\ToMove\\nupkg\\" $_ -Source "BaGet"
            })
        [System.GC]::Collect()
    })

$files.foreach({
        $((find-package "$_**" -Source nuget.org).name).foreach({
                nuget install -OutputDirectory "D:\\Transfer\\ToMove\\nupkg\\" $_ -Source "BaGet" -Prerelease
            })
        [System.GC]::Collect()
    })


# Parallel Attempt
$files | ForEach-Object -Parallel ({
        $((find-package "$_**" -Source nuget.org).name).foreach({
                nuget install -OutputDirectory "D:\\Transfer\\ToMove\\nupkg\\" $_ -Source "BaGet"
            })
        [System.GC]::Collect()
    })

$files | ForEach-Object -Parallel ({
        $((find-package "$_**" -Source nuget.org).name).foreach({
                nuget install -OutputDirectory "D:\\Transfer\\ToMove\\nupkg\\" $_ -Source "BaGet" -Prerelease
            })
        [System.GC]::Collect()
    })


# Parallel Attempt W/O presearch
$files | ForEach-Object -Parallel ({
    [string]$random = Get-Random -Maximum 99999999 -Minimum 1000000
    mkdir "D:\\Transfer\\ToMove\\nupkg\\$random"
    try{
        nuget install -OutputDirectory "D:\\Transfer\\ToMove\\nupkg\\$random" $_ -Source "BaGet"
    } catch {
        [string]$random = Get-Random -Maximum 99999999 -Minimum 1000000
        mkdir "D:\\Transfer\\ToMove\\nupkg\\$random"
        nuget install -OutputDirectory "D:\\Transfer\\ToMove\\nupkg\\$random" $_ -Source "BaGet" 
    }
    [System.GC]::Collect()
})

$files | ForEach-Object -Parallel ({
    nuget install -OutputDirectory "D:\\Transfer\\ToMove\\nupkg\\" $_ -Source "BaGet" -Prerelease
    [System.GC]::Collect()
})


# Parallel Attempt W/O presearch or source
$files | ForEach-Object -Parallel ({
    nuget install -OutputDirectory "D:\\Transfer\\ToMove\\nupkg\\" $_ 
    [System.GC]::Collect()
})

$files | ForEach-Object -Parallel ({
    nuget install -OutputDirectory "D:\\Transfer\\ToMove\\nupkg\\" $_ -Prerelease
    [System.GC]::Collect()
})




$files | ForEach-Object -Parallel {dotnet tool install --tool-path "D:\\Transfer\\ToMove\\nupkg\\" --add-source "http://localhost:9999/v3/index.json" --add-source "http://localhost:9889/v3/index.json" --add-source "http://localhost:7777/v3/index.json" --add-source "http://localhost:5555/v3/index.json" $_.split(" ")[0] --arch x64 ; [System.GC]::Collect()}
$(dotnet tool search "microsoft.powershell.commands*" --take 50) | ForEach-Object -Parallel {dotnet tool install --tool-path "D:\\Transfer\\ToMove\\nupkg\\" $_.split(" ")[0] --arch x64 ; [System.GC]::Collect()}

$(dotnet tool search "vmware.*" --take 500) | ForEach-Object -Parallel {dotnet tool install --tool-path "D:\\Transfer\\ToMove\\nupkg\\" --add-source "http://localhost:7777/v3/index.json" --add-source "http://localhost:5555/v3/index.json" $_.split(" ")[0] --arch x64}

$(dotnet tool search "system.*" --take 500) | ForEach-Object -Parallel {dotnet tool install --tool-path "D:\\Transfer\\ToMove\\nupkg\\" --add-source "http://localhost:7777/v3/index.json" --add-source "http://localhost:5555/v3/index.json" $_.split(" ")[0] --arch x64}

# foreach($file in $(dotnet tool search "blazor" --take 500)) {dotnet tool install --tool-path "D:\\Transfer\\ToMove\\nupkg\\" --add-source "http://localhost:7777/v3/index.json" $file.split(" ")[0] --arch x64}

#     $files | foreach { $newname = $_.Name -replace ("^(\d+ )", "")
#     write-host $newname
#     Rename-Item -Path $_.FullName -NewName $newname
# }

# POSH
$files.foreach({
    $((find-package "$_**" -Source PSGallery).name).foreach({
        nuget install -OutputDirectory "D:\\Transfer\\ToMove\\nupkg\\" $_ -Source "BaGet_Posh" 
    })
    [System.GC]::Collect()
})

$files.foreach({
    $((find-package "$_**" -Source PSGallery).name).foreach({
        nuget install -OutputDirectory "D:\\Transfer\\ToMove\\nupkg\\" $_ -Source "BaGet_Posh" -Prerelease
    })
    [System.GC]::Collect()
})

# POSH Parallel W/O search
$files | ForEach-Object -Parallel ({
    nuget install -OutputDirectory "D:\\Transfer\\ToMove\\nupkg\\" $_ -Source "BaGet_Posh" 
    [System.GC]::Collect()
})

$files | ForEach-Object -Parallel ({
    nuget install -OutputDirectory "D:\\Transfer\\ToMove\\nupkg\\" $_ -Source "BaGet_Posh" -Prerelease
    [System.GC]::Collect()
})

# # Get all the versions
# $((find-package "microsoft.powershell**" -Source nuget.org ) ).foreach({  find-package -Name "$($_.Name)" -AllVersions -Source nuget.org}).foreach({nuget install -OutputDirectory "D:\\Transfer\\ToMove\\nupkg\\" $($_.Name) -Version $($_.version) -Source "BaGet" })

# Gett all versions
(find-package "microsoft.jsinterop**") | foreach-object ({
    $(find-package -Name "$($_.Name)" -AllVersions -Source nuget.org) | foreach-object -Parallel {
        nuget install -OutputDirectory "D:\\Transfer\\ToMove\\nupkg\\" $($_.Name) -Version $($_.version) -Source "BaGet" }
    [System.GC]::Collect()
    })


# Gett the 3 newest PRERELEASE versions in Parallel
$files.foreach({
    $(find-package -Name "$($_)" -AllVersions -AllowPrereleaseVersions -Source nuget.org) | Sort-Object Version -Desc | Select-Object -First 3 | foreach-object -Parallel {
        nuget install -OutputDirectory "D:\\Transfer\\ToMove\\nupkg\\" $($_.Name) -Version $($_.version) -Source "BaGet" }
    [System.GC]::Collect()
    })

# Gett the 5 newest versions in Parallel
$files = gc "C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\nugetPackageFiles\\Microsoft2\\*.txt"
# $files = gc "C:\users\joesp\Downloads\gits\TheRum\nugetPackageFiles\PSGallery\TopModules.txt"  
# $files.foreach({
$files | Foreach-Object -Parallel  {
    $(find-package -Name "$($_)" -AllVersions -Source nuget.org) | Sort-Object Version -Desc | Select-Object -First 5 | foreach-object -Parallel {
        nuget install -OutputDirectory "D:\\Transfer\\ToMove\\nupkg\\" $($_.Name) -Version $($_.version) -Source "BaGet" }
    [System.GC]::Collect()
    }

(find-package "microsoft.powershell**") | foreach-object ({
    $(find-package -Name "$($_.Name)" -AllVersions -AllowPrereleaseVersions -Source nuget.org) | Sort-Object Version -Desc | Select-Object -First 5 | foreach-object -Parallel {
        nuget install -OutputDirectory "D:\\Transfer\\ToMove\\nupkg\\" $($_.Name) -Version $($_.version) -Source "BaGet" }
    [System.GC]::Collect()
    })
(find-package "microsoft.powershell**") | foreach-object -parallel ({
    $(find-package -Name "$($_.Name)" -AllVersions -Source PSGallery) | Sort-Object Version -Desc | Select-Object -First 5 | foreach-object -Parallel {
        nuget install -OutputDirectory "D:\\Transfer\\ToMove\\nupkg\\" $($_.Name) -Version $($_.version) -Source "BaGet_Posh" }
    [System.GC]::Collect()
    })

#############################################################

# Build Package files based off all entires in package files.

$files = New-Object System.Collections.ArrayList
# $tmpfiles = gci "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\packageLists2\*.txt"
# $tmpfiles = gci "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\Microsoft2\*.txt"
# $tmpfiles = gci "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\PSGallery\*.txt"
foreach($tmpfile in $tmpfiles){
    $files = gc $tmpfile
    foreach($file in $files){
        BuildPackageList -PackageName "$($file)*" -OutputFile $tmpfile 
        # BuildPackageList -PackageName "$($file)*" -OutputFile $tmpfile -SerachSource "BaGet_Posh"
    }
}


function BuildPackageList {
    # Return to STDOUT
    # BuildPackageList -PackageName "system.collections*" 
    # Add to and clean up a txt file
    # BuildPackageList -PackageName "*vmware*" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\packageLists\vmware.txt"
    # BuildPackageList -PackageName "*vagrant*" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\packageLists\vagrant.txt"
    # BuildPackageList -PackageName "*ldap*" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\packageLists\ldap.txt"
    # BuildPackageList -PackageName "system.collections*" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\packageLists\system.txt"
    # BuildPackageList -PackageName "mediatr*" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\packageLists2\mediatr.txt"
    # BuildPackageList -PackageName "HotChocolate*" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\packageLists2\HotChocolate.txt"
    # BuildPackageList -PackageName "Automapper*" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\packageLists2\Automapper.txt"
    # BuildPackageList -PackageName "polly*" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\packageLists2\polly.txt"
    # BuildPackageList -PackageName "fluentemail*" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\packageLists2\fluent.txt"
    # BuildPackageList -PackageName "fluentassertions*" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\packageLists2\fluent.txt"
    # BuildPackageList -PackageName "swagger.*" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\packageLists2\swagger.txt"
    # BuildPackageList -PackageName "Nswag.*" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\packageLists2\swagger.txt"
    # BuildPackageList -PackageName "swashbuckle.*" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\packageLists2\swashbuckle.txt"
    # BuildPackageList -PackageName "nodatime*" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\packageLists2\nodatime.txt"
    # BuildPackageList -PackageName "SharpZipLib*" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\packageLists2\SharpZipLib.txt"
    # BuildPackageList -PackageName "HtmlAgilityPack*" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\packageLists2\HtmlAgilityPack.txt"
    # BuildPackageList -PackageName "mailkit*" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\packageLists2\mailkit.txt"
    # BuildPackageList -PackageName "restsharp*" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\packageLists2\restsharp.txt"
    # BuildPackageList -PackageName "microsoft.net*" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\Microsoft\dotnet.txt"
    # BuildPackageList -PackageName "microsoft.netCore*" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\Microsoft\dotnetcore.txt"
    # BuildPackageList -PackageName "blazor*" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\Microsoft2\blazor.txt"
    # BuildPackageList -PackageName "runtime.*" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\Microsoft2\runtime.txt"
    # BuildPackageList -PackageName "Microsoft.*runtime.*" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\Microsoft2\runtime.txt"
    # BuildPackageList -PackageName "Microsoft.*" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\Microsoft2\microsoft.txt"
    # BuildPackageList -PackageName "System.*" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\Microsoft2\system.txt"
    # BuildPackageList -PackageName "Microsoft.aspnetcore*" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\Microsoft2\aspnetcore.txt"
    # BuildPackageList -PackageName "microsoft.entityframework*" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\Microsoft\efcore.txt"
    # BuildPackageList -PackageName "microsoft.aspnetcore.auth*" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\Microsoft\aspnetcoreAuthentication.txt"
    # Add to and clean up a txt file based on an array of packages
    # BuildPackageList -PackageArray $PackageArray -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\packageLists\system.txt"
    # Specify SearchSource
    # BuildPackageList -PackageName "*vmware*" -SearchSource "BaGet_Posh" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\PSGallery\vmware.txt"
    param (
        [string]$PackageName,
        [System.Collections.ArrayList]$PackageArray,
        [string]$OutputFile,
        [string]$SearchSource
    )
    $TempFile = "C:\Windows\Temp\nugetFiles.txt"
    $null > $TempFile
    if (!$SearchSource) {
        $SearchSource = "nuget.org"
    }
    if ($PackageArray) {
        foreach ($PackageName in $PackageArray) { 
            # (find-package $PackageName -source nuget.org).name | Sort-Object -Unique >> $TempFile
                (find-package $PackageName -source $SearchSource).name | Sort-Object -Unique >> $TempFile
            [System.GC]::Collect()
        }
    }
    elseif ($PackageName) {
            (find-package $PackageName -source $SearchSource).name | Sort-Object -Unique >> $TempFile
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



function Find-AllPackages {
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
        if ($PackageName.EndsWith(".")) {
            $PackageName = $PackageName.Trim(".")
        }
        $PackageArray += $(97..122).foreach({ $(find-package "$PackageName.$([char]$_)*").name })
        $nupkgFilesSearchedUnique = $($PackageArray | Sort-Object | Get-Unique)
        $nupkgFilesSearchedUnique = $($nupkgFilesSearchedUnique | Sort-Object | Get-Unique)
        $nupkgFilesSearchedUnique = $($nupkgFilesSearchedUnique | Sort-Object | Get-Unique)
        $PackageArray = $nupkgFilesSearchedUnique
    }
    else {
        Write-Host "Must provide a PackageName."
    }
    return $PackageArray
}


$allFiles = "C:\Program Files (x86)\Microsoft SDKs", "C:\Users\$env:USERNAME\.nuget\packages", "D:\\Transfer\\ToMove\\BaGet_Shared", "C:\\Users\\$env:USERNAME\\AppData\\Local\\NuGet\\v3-cache"
# Remove-Variable allFiles
# DeDupe
# $toDeDupeCopy = gci "*.nupkg" -Recurse -Path "D:\\Transfer\\ToMove\\BaGet_Shared\\packages\\packages"

function DeDupe-Nupkg() {
    param(
        [System.Collections.Arraylist]$allFiles
    )

    if (!$allFiles) {
        $toDeDupeCopy = Get-ChildItem "*.nupkg" -Recurse -Path "D:\\Transfer\\ToMove\\BaGet_Shared"    
    }
    else {
        # $toDeDupeCopy = $allFiles.foreach({ Get-ChildItem "*.nupkg" -Recurse -Path $_ })
        $toDeDupeCopy = $allFiles | foreach-object -Parallel ({ Get-ChildItem "*.nupkg" -Recurse -Path $_ })
    }
    # $toDeDupeCopy = gci "*.nupkg" -Recurse -Path "D:\\Transfer\\ToMove\\BaGet_Shared"
    $toDeDupeCopy | Where-Object { $_.Length -le 0 } | Remove-Item -force
    # $toDeDupeCopy. foreach({ Copy-Item $_ -Destination "D:\\Transfer\\ToMove\\nupkg\\" })
    $toDeDupeCopy | ForEach-Object -Parallel ({ Copy-Item $_ -Destination "D:\\Transfer\\ToMove\\nupkg\\" })
    $moved = Get-ChildItem "*.nupkg" -Recurse -Path "D:\\Transfer\\Moved\\nupkg\\"
    $moved | Where-Object { $_.Length -le 0 } | Remove-Item -force
    $moved = Get-ChildItem "*.nupkg" -Recurse -Path "D:\\Transfer\\Moved\\nupkg\\"
    $toMove = Get-ChildItem -recurse "*.nupkg" -Path "D:\\Transfer\\ToMove\\nupkg\\"
    $toMove | Where-Object { $_.Length -le 0 } | Remove-Item -force
    $toMove = Get-ChildItem -recurse "*.nupkg" -Path "D:\\Transfer\\ToMove\\nupkg\\"
    [system.gc]::collect()
    $staging = "D:\\Transfer\\Staging\\nupkg\\"
    # $count = 0
    # $leavingCount = 0
    # # $toMove.foreach({ if ($_.name -notin $moved) { $count++ } })
    # $moved.foreach({ if ($_.name -notin $toMove) { $count++ } })
    # $moved.foreach({ if ($_.name -in $toMove) { $leavingCount++ } })
    # write-host "Going to move $count packages"
    # write-host "$leavingCount duplicate packages"

    # Move Files
    if (!$ImportedMoved) {
        # $toMove.foreach({ if ($_.name -notin $moved.Name) { move-item $_ $staging } })    
        $toMove | ForEach-Object -Parallel ({
            $staging = $using:staging
            $moved = $using:moved
            if ($_.name -notin $moved.Name) { move-item $_ $staging } })    
            [system.gc]::collect()
    }
    else {
        # $toMove.foreach({ if ($_.name -notin $ImportedMoved -or $_.name -notin $($ImportedMoved).Name) { move-item $_ $staging } })
        $toMove | ForEach-Object -Parallel ({ 
            $staging = $using:staging
            $ImportedMoved = $using:ImportedMoved
            if ($_.name -notin $ImportedMoved -or $_.name -notin $($ImportedMoved).Name) { move-item $_ $staging } })
            [system.gc]::collect()
    }

}





# $Directory = "D:\\Transfer\\Staging\\nupkg"
# get-filehash "$Directory\\*" | format-list | Out-File "$Directory\\..\\PRE_HASH_$(Get-Date -Format "yyyyMMdd")_nupkg.txt"





################# 

# # I don't think this is needed...
## Had to use this to pull the vmware stuff off of powershellgallery
# $(find-module "*vmware*").foreach({save-module $($_.name) -MaximumVersion "100.100.100" -Path "D:\\Transfer\\ToMove\\nupkg\\"})

## DOES NOT get the newest version...  I think...
# $((find-module "vmware*").Name | sort-object -unique).foreach({  save-module -Name "$_" -Path "D:\\Transfer\\ToMove\\nupkg\\" -Repository "BaGet_Posh"})
# $((find-package "*vmware**").Name | sort-object -unique).foreach({  save-package -Name "$_" -Path "D:\\Transfer\\ToMove\\nupkg\\" -Source "BaGet_Posh"})
# $((find-package "*dotnet*").Name | sort-object -unique).foreach({  Save-Module -Name "$_" -Path "D:\\Transfer\\ToMove\\nupkg\\" -Repository "BaGet_Posh"})
# $((find-package "Microsoft.aspnetcore.*")).foreach({  Save-Module -Name "$($_.Name)" -Path "D:\\Transfer\\ToMove\\nupkg\\" -Repository "BaGet_Posh"})

# # TESTING... Seems to be the best option???
# $((find-package "powershell**") ).foreach({  save-package -Name "$($_.Name)" -Path "D:\\Transfer\\ToMove\\nupkg\\" -RequiredVersion $_.version})
# $((find-package "microsoft.**") ).foreach({  save-package -Name "$($_.Name)" -Path "D:\\Transfer\\ToMove\\nupkg\\" -RequiredVersion $_.version})
# $((find-package "microsoft.aspnetcore.**") ).foreach({  save-package -Name "$($_.Name)" -Path "D:\\Transfer\\ToMove\\nupkg\\" -RequiredVersion $_.version})
# $((find-package "microsoft.Netcore.**") ).foreach({  save-package -Name "$($_.Name)" -Path "D:\\Transfer\\ToMove\\nupkg\\" -RequiredVersion $_.version})
# $((find-package "system.**") ).foreach({  save-package -Name "$($_.Name)" -Path "D:\\Transfer\\ToMove\\nupkg\\" -RequiredVersion $_.version})
# # $((find-package "lucene**") ).foreach({  save-package -Name "$($_.Name)" -Path "D:\\Transfer\\ToMove\\nupkg\\" -RequiredVersion $_.version -AllowPrereleaseVersions})
# $((find-package "System.Linq**") ).foreach({  nuget install -OutputDirectory "D:\\Transfer\\ToMove\\nupkg\\" $($_.Name) -Version $($_.Version) -Source "BaGet" })
# $((find-package "lucene**") ).foreach({  nuget install -OutputDirectory "D:\\Transfer\\ToMove\\nupkg\\" $($_.Name) -Version $($_.Version) -Source "BaGet" -Prerelease})
# $((find-package "microsoft.Netcore.**") ).foreach({  nuget install -OutputDirectory "D:\\Transfer\\ToMove\\nupkg\\" $($_.Name) -Version $($_.Version) -Source "BaGet" })
# $((find-package "Microsoft.visualstudio**") ).foreach({  nuget install -OutputDirectory "D:\\Transfer\\ToMove\\nupkg\\" $($_.Name) -Version $($_.Version) -Source "BaGet" })
# $((find-package "Microsoft.*roslyn**") ).foreach({  nuget install -OutputDirectory "D:\\Transfer\\ToMove\\nupkg\\" $($_.Name) -Version $($_.Version) -Source "BaGet" })
### Does not always work.
# $((find-package "microsoft.NETcore**") ).foreach({dotnet tool install --tool-path "D:\\Transfer\\ToMove\\nupkg\\" --add-source "http://localhost:7777/v3/index.json" $_ --arch x64})
# $((find-package "microsoft.NETcore**") ).foreach({dotnet tool install --tool-path "D:\\Transfer\\ToMove\\nupkg\\" --add-source "http://localhost:5555/v3/index.json" $_ --arch x64})


# $toDownload = find-package "microsoft.aspnetcore**"
# $toDownload = find-package "Microsoft**AspNetCore**"
# $toDownload = find-package "Microsoft**blazor**"
# $toDownload = find-package "vmware**" -source "psgallery"
# $toDownload.foreach({  save-package -Name "$($_.Name)" -Path "D:\\Transfer\\ToMove\\nupkg\\" -RequiredVersion $_.version})
# $toDownload.foreach({  nuget install -OutputDirectory "D:\\Transfer\\ToMove\\nupkg\\" $($_.Name) -Version $($_.version) -Source "BaGet" })
# OR
# $toDownload | Save-Package -Path "D:\\Transfer\\ToMove\\nupkg\\" -Source "BaGet"
# $toDownload | Save-Module -Path "D:\\Transfer\\ToMove\\nupkg\\" -Repository "BaGet_Posh"

# ## This one works.
# (find-module "vmware.**").foreach({save-Module -name $_.Name -Path "D:\\Transfer\\ToMove\\nupkg\\" -repository "BaGet_Posh" -RequiredVersion $_.version})
# (find-module "powershell**").foreach({save-Module -name $_.Name -Path "D:\\Transfer\\ToMove\\nupkg\\" -repository "BaGet_Posh" -RequiredVersion $_.version})
# (find-module "nuget.**").foreach({save-Module -name $_.Name -Path "D:\\Transfer\\ToMove\\nupkg\\" -repository "BaGet_Posh" -RequiredVersion $_.version})
# (find-module "Microsoft.**").foreach({save-Module -name $_.Name -Path "D:\\Transfer\\ToMove\\nupkg\\" -repository "BaGet_Posh" -RequiredVersion $_.version})

# FOR DOTNET TOOL
# THIS WORKS!!!!
# foreach($file in $(dotnet tool search "blazor" --take 500)) {dotnet tool install --tool-path "D:\\Transfer\\ToMove\\nupkg\\" --add-source "http://localhost:7777/v3/index.json" $file.split(" ")[0] --arch x64}
# foreach($file in $(dotnet tool search "roslyn" --take 500)) {dotnet tool install --tool-path "D:\\Transfer\\ToMove\\nupkg\\" --add-source "http://localhost:7777/v3/index.json" $file.split(" ")[0] --arch x64}

# (find-package "microsoft*aspnetcore*").foreach({Save-Package -name $_.Name -Path "D:\\Transfer\\ToMove\\nupkg\\" -Source "BaGet_Posh" -RequiredVersion $_.version})

# This one pulls all versions of all the items searched.
## Is really, really slow, because it's running 2 searches. Increases time exponentially. 
# $((find-package "lucene**" ) ).foreach({  find-package -Name "$($_.Name)" -AllVersions}).foreach({save-package -Name "$($_.Name)" -Path "D:\\Transfer\\ToMove\\nupkg\\" -RequiredVersion $($_.version)})
## Trying the same thing, but with nuget...
# $((find-package "lucene**" ) ).foreach({  find-package -Name "$($_.Name)" -AllVersions}).foreach({nuget install -OutputDirectory "D:\\Transfer\\ToMove\\nupkg\\" $($_.Name) -Version $($_.version) -Source "BaGet" })
# $((find-package "runtime.linux**" ) ).foreach({  find-package -Name "$($_.Name)" -AllVersions}).foreach({nuget install -OutputDirectory "D:\\Transfer\\ToMove\\nupkg\\" $($_.Name) -Version $($_.version) -Source "BaGet" })
################# 





# # $files.foreach({
# #     save-package -Name "$_" -Path "D:\\Transfer\\ToMove\\nupkg\\"
# #     [System.GC]::Collect()
# # })

# # $files.foreach({
# #     save-package -Name "$_" -Path "D:\\Transfer\\ToMove\\nupkg\\" -RequiredVersion $_.version -AllowPrereleaseVersions
# #     [System.GC]::Collect()
# # })

# $files.foreach({
#     nuget install -OutputDirectory "D:\\Transfer\\ToMove\\nupkg\\" $_ -Prerelease
#     [System.GC]::Collect()
# })

# $files.foreach({
#     Save-Module -Name "$_" -Path "D:\\Transfer\\ToMove\\nupkg\\"
#     [System.GC]::Collect()
# })

# foreach($file in $(dotnet tool search "blazor" --take 500)) {dotnet tool install --tool-path "D:\\Transfer\\ToMove\\nupkg\\" --add-source "http://localhost:7777/v3/index.json" $file.split(" ")[0] --arch x64}

# foreach($file in $(dotnet tool search "powershell" --take 500)) {dotnet tool install --tool-path "D:\\Transfer\\ToMove\\nupkg\\" --add-source "http://localhost:7777/v3/index.json" $file.split(" ")[0] --arch x64}

# foreach($file in $(dotnet tool search "powershell" --take 500)) {dotnet tool install --tool-path "D:\\Transfer\\ToMove\\nupkg\\" --add-source "http://localhost:5555/v3/index.json" $file.split(" ")[0] --arch x64}

# foreach($file in $(dotnet tool search "blazor" --take 500)) {dotnet tool install --tool-path "D:\\Transfer\\ToMove\\nupkg\\" --add-source "http://localhost:5555/v3/index.json" $file.split(" ")[0] --arch x64}

# foreach($file in $(dotnet tool search "razor" --take 500)) {dotnet tool install --tool-path "D:\\Transfer\\ToMove\\nupkg\\" $file.split(" ")[0] --arch x64 --add-source "http://localhost:5555/v3/index.json"}
# foreach($file in $(dotnet tool search "aspnetcore" --take 500)) {dotnet tool install --tool-path "D:\\Transfer\\ToMove\\nupkg\\" $file.split(" ")[0] --arch x64 --add-source "http://localhost:5555/v3/index.json"}
# foreach($file in $(dotnet tool search "dotnetcore" --take 500)) {dotnet tool install --tool-path "D:\\Transfer\\ToMove\\nupkg\\" $file.split(" ")[0] --arch x64 --add-source "http://localhost:5555/v3/index.json"}
# foreach($file in $(dotnet tool search "dotnet" --take 500)) {dotnet tool install --tool-path "D:\\Transfer\\ToMove\\nupkg\\" $file.split(" ")[0] --arch x64 --add-source "http://localhost:5555/v3/index.json"}
# foreach($file in $(dotnet tool search "aspnet" --take 500)) {dotnet tool install --tool-path "D:\\Transfer\\ToMove\\nupkg\\" $file.split(" ")[0] --arch x64 --add-source "http://localhost:5555/v3/index.json"}
# foreach($file in $(dotnet tool search "blazor" --take 500)) {dotnet tool install --tool-path "D:\\Transfer\\ToMove\\nupkg\\" $file.split(" ")[0] --arch x64 --add-source "http://localhost:5555/v3/index.json"}
# foreach($file in $(dotnet tool search "powershell" --take 500)) {dotnet tool install --tool-path "D:\\Transfer\\ToMove\\nupkg\\" $file.split(" ")[0] --arch x64 --add-source "http://localhost:5555/v3/index.json"}

# foreach($file in $(dotnet tool search "razor" --take 500)) {dotnet tool install --tool-path "D:\\Transfer\\ToMove\\nupkg\\" $file.split(" ")[0] --arch x64 --add-source "http://localhost:7777/v3/index.json"}
# foreach($file in $(dotnet tool search "aspnetcore" --take 500)) {dotnet tool install --tool-path "D:\\Transfer\\ToMove\\nupkg\\" $file.split(" ")[0] --arch x64 --add-source "http://localhost:7777/v3/index.json"}
# foreach($file in $(dotnet tool search "dotnetcore" --take 500)) {dotnet tool install --tool-path "D:\\Transfer\\ToMove\\nupkg\\" $file.split(" ")[0] --arch x64 --add-source "http://localhost:7777/v3/index.json"}
# foreach($file in $(dotnet tool search "dotnet" --take 500)) {dotnet tool install --tool-path "D:\\Transfer\\ToMove\\nupkg\\" $file.split(" ")[0] --arch x64 --add-source "http://localhost:7777/v3/index.json"}
# foreach($file in $(dotnet tool search "aspnet" --take 500)) {dotnet tool install --tool-path "D:\\Transfer\\ToMove\\nupkg\\" $file.split(" ")[0] --arch x64 --add-source "http://localhost:7777/v3/index.json"}
# foreach($file in $(dotnet tool search "blazor" --take 500)) {dotnet tool install --tool-path "D:\\Transfer\\ToMove\\nupkg\\" $file.split(" ")[0] --arch x64 --add-source "http://localhost:7777/v3/index.json"}
# foreach($file in $(dotnet tool search "powershell" --take 500)) {dotnet tool install --tool-path "D:\\Transfer\\ToMove\\nupkg\\" $file.split(" ")[0] --arch x64 --add-source "http://localhost:7777/v3/index.json"}


# ----------------------------------------------------------------------------
# $SearchFiles = "*razor*","*radzen*blazor*","*blazor*radzen*","*radzen*razor*","*razor*","*radzen*","System.Threading.tasks*","System.Threading*","System.Collections.Generic*","System.Collections*","System.Linq*","microsoft.extensions.configuration*","microsoft.extensions.logging*""microsoft.extensions.dependencyinjection*","microsoft.extensions.hosting*","microsoft.extensions*","microsoft.aspnetcore.hosting*","microsoft.aspnetcore.builder*","microsoft.aspnetcore.hosting*","microsoft.aspnetcore*","microsoft.aspnetcore.identity.*","microsoft.aspnetcore.identity.ui*","microsoft.aspnet*","microsoft.powershell*","microsoft.net*","microsoft.dotnet*","powershell*","microsoft.entityframework*","microsoft*csharp*"

# $SearchFiles += "microsoft.aspnetcore.*","microsoft.aspnetcore.mvc*","mvcnet6.models*","mvcnet6.controllers*","mvcnet6.*"

# $SearchFiles += "*lucene*","*lucene.net*","*index*","*indexer*","*ifilescan*","*filesystem*","Microsoft.Extensions.file*","powershell","microsoft.powershell.*","powershell.*"

# $SearchFiles += "*csharp*","*omnisharp*","*roslyn*","*omnisharp*roslyn*","*roslyn*omnisharp*","*docker*","*helm*","*kube*","*vscode*","dotnet-symbol"

# $SearchFiles += "mongocsharpdriver","MongoDB.Bson","MongoDB.Driver","MongoDB.Driver.Core","MongoDB.Driver.GridFS","MongoDB.Libmongocrypt","MongoDB*","Microsoft.AspNetCore.Spa*","Microsoft.AspNetCore.SpaTemplates","*helm*","runtime.*.Netcore*","runtime.*.runtime*","Microsoft.NETCore.App.Runtime.Mono.browser-wasm","Microsoft.NETCore.App.Runtime.Mono*","microsoft.netcore.app.runtime*"

# $SearchFiles = get-content "D:\\gits\\TheRum\\nugetPackageFiles\\mlnetPackages.txt"
# $SearchFiles = get-content "D:\\gits\\TheRum\\nugetPackageFiles\\RandomNuget.txt"
# $SearchFiles = get-content "D:\\gits\\TheRum\\nugetPackageFiles\\aspnetcore.txt"
# $SearchFiles = get-content "D:\\gits\\TheRum\\nugetPackageFiles\\dotnet.txt"
# $SearchFiles = get-content "D:\\gits\\TheRum\\nugetPackageFiles\\powershell.txt"
# $SearchFiles = get-content "D:\\gits\\TheRum\\nugetPackageFiles\\vmware.txt"
$SearchFiles = get-content "D:\\gits\\TheRum\\nugetPackageFiles\\nugetPackages.txt"

$NuGetBinary = "D:\\Transfer\\nuget.exe"

# Fast method of searching and downloading files bsaed off of a single term.
# $((find-package "microsoft.aspnet*" -Source nuget.org).name).foreach({nuget install -OutputDirectory "D:\\Transfer\\ToMove\\nupkg\\" $_ -Source "BaGet"})

Remove-Variable files
Remove-Variable uniqueFilesLimit
$files = New-Object System.Collections.ArrayList
$uniqueFilesLimit = New-Object System.Collections.ArrayList

# $files.add($SearchFiles.foreach({ $((find-package $_ -Source "nuget.org") | where-object {$_.Name -notlike "*arm64*"}).name }))
# $files.add($SearchFiles.foreach({ $((find-package $_ -Source "PSGallery") | where-object {$_.Name -notlike "*arm64*"}).name }))
# WAY SLOWER METHOD
$files = ($SearchFiles.foreach({ $((find-package $_ -Source "nuget.org") | where-object { $_.Name -notlike "*arm64*" }) }))

$uniqueFiles = $files
# $uniqueFiles = $files | Sort-Object | Get-unique
# $uniqueFiles = $uniqueFiles | Sort-Object | Get-unique

Write-Host "$($uniqueFiles.Count) packages to be installed. This does not include dependencies." -ForegroundColor Green

while ($uniqueFiles.count -gt 0) {
    $uniqueFilesLimit = $uniqueFiles[0..24]

    $uniqueFilesLimit.foreach({ 
            try {
                # nuget install -OutputDirectory "D:\\Transfer\\ToMove\\nupkg\\" $_ -Source "BaGet"
                nuget install -OutputDirectory "D:\\Transfer\\ToMove\\nupkg\\" $($_.Name) -Version $($_.version) -Source "BaGet"
            }
            catch {
                dotnet tool install $($_.Name) --tool-path "D:\\Transfer\\ToMove\\nupkg\\" --add-source "http://localhost:5555/v3/index.json" --version "$($_.version)"
            }
        })
    $uniqueFiles = ($uniqueFiles[25..($uniqueFiles.Count)])
}


while ($uniqueFiles.count -gt 0) {
    $uniqueFilesLimit = $uniqueFiles[0..24]

    $uniqueFilesLimit.foreach({ 
            dotnet tool install $($_.Name) --tool-path "D:\\Transfer\\ToMove\\nupkg\\" --add-source "http://localhost:5555/v3/index.json" --version "$($_.version)"
        })
    $uniqueFiles = ($uniqueFiles[25..($uniqueFiles.Count)])
}


################# 

################# 
################# 
