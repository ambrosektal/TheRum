# # # # # # # # # # 
# # # # # # # # # # 
# # # # # # # # # # 
# # # # # # # # # # 

# ----------------------------------------------------------------------------

$Sources = "https://api.nuget.org/v3/index.json",
"https://www.powershellgallery.com/api/v2"
# "https://pkgs.dev.azure.com/ms/terminal/_packaging/TerminalDependencies/nuget/v3/index.json",
# "https://pkgs.dev.azure.com/dnceng/public/_packaging/nuget-build/nuget/v3/index.json",
# "https://pkgs.dev.azure.com/dnceng/public/_packaging/dotnet-eng/nuget/v3/index.json",
# "https://pkgs.dev.azure.com/dnceng/public/_packaging/dotnet-public/nuget/v3/index.json"
# "https://pkgs.dev.azure.com/dnceng/public/_packaging/myget-legacy%40Local/nuget/v3/index.json",
# "https://pkgs.dev.azure.com/azure-public/vside/_packaging/msft_consumption/nuget/v3/index.json"

$PackageList = gc  "C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\nugetPackageFiles\\Terminal\\all.txt"
foreach ($Source in $Sources) {
    Invoke-ParNugetDown -AllVersions -PackageList $PackageList
}



foreach ($Source in $Sources) {
    Invoke-ParNugetDown -Directory "C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\nugetPackageFiles\\Microsoft2" -Source $Source
    Invoke-ParNugetDown -Directory "C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\nugetPackageFiles\\packageLists2" -Source $Source
    Invoke-ParNugetDown -Directory "C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\nugetPackageFiles\\PSGallery" -Source $Source
}


foreach ($Source in $Sources) {
    Invoke-ParNugetDown -FirstHalf -Directory "C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\nugetPackageFiles\\Microsoft2" -Source $Source
    Invoke-ParNugetDown -FirstHalf -Directory "C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\nugetPackageFiles\\packageLists2" -Source $Source
    Invoke-ParNugetDown -FirstHalf -Directory "C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\nugetPackageFiles\\PSGallery" -Source $Source
}


foreach ($Source in $Sources) {
    Invoke-ParNugetDown -SecondHalf -Directory "C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\nugetPackageFiles\\Microsoft2" -Source $Source
    Invoke-ParNugetDown -SecondHalf -Directory "C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\nugetPackageFiles\\packageLists2" -Source $Source
    Invoke-ParNugetDown -SecondHalf -Directory "C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\nugetPackageFiles\\PSGallery" -Source $Source
}



# # ----------------------------------------------------------------------------
# Invoke-ParNugetDown -FirstHalf -Directory "C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\nugetPackageFiles\\Microsoft2"
# Invoke-ParNugetDown -FirstHalf -Directory "C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\nugetPackageFiles\\packageLists2"
# Invoke-ParNugetDown -FirstHalf -Directory "C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\nugetPackageFiles\\PSGallery"
# # Invoke-ParNugetDown -FirstHalf -Directory "C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\nugetPackageFiles\\PSGallery" -Source "BaGet_Posh"


# Invoke-ParNugetDown -SecondHalf -Directory "C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\nugetPackageFiles\\Microsoft2"
# Invoke-ParNugetDown -SecondHalf -Directory "C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\nugetPackageFiles\\packageLists2"
# Invoke-ParNugetDown -SecondHalf -Directory "C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\nugetPackageFiles\\PSGallery"
# # Invoke-ParNugetDown -SecondHalf -Directory "C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\nugetPackageFiles\\PSGallery" -Source "BaGet_Posh"

    # Invoke-ParNugetDown -FirstHalf -Directory "C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\nugetPackageFiles\\Microsoft2"
    # Invoke-ParNugetDown -SecondHalf -Directory "C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\nugetPackageFiles\\Microsoft2"
    # 
    # Invoke-ParNugetDown -FirstHalf -Directory "C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\nugetPackageFiles\\packageLists2"
    # Invoke-ParNugetDown -SecondHalf -Directory "C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\nugetPackageFiles\\packageLists2"
    # 
    # Invoke-ParNugetDown -FirstHalf -Directory "C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\nugetPackageFiles\\PSGallery" -Source "BaGet_Posh"
    # Invoke-ParNugetDown -SecondHalf -Directory "C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\nugetPackageFiles\\PSGallery" -Source "BaGet_Posh"
    #
    # $PackageList = gc  "C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\nugetPackageFiles\\Terminal\\all.txt"
    # $PackageList = gc  "C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\nugetPackageFiles\\packageLists2\\docfx.txt"
    # $PackageList = gc  "C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\nugetPackageFiles\\Microsoft2\\System.txt"
    # $PackageList = gc  "C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\nugetPackageFiles\\Microsoft2\\runtime.txt"
    # $PackageList = gc  "C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\nugetPackageFiles\\Microsoft2\\aspnetcore.txt"
    # $PackageList = gc  "C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\nugetPackageFiles\\Microsoft2\\dotnetcore.txt"
    # $PackageList = gc  "C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\nugetPackageFiles\\Microsoft2\\upgrade.txt"
    # $PackageList = gc  "C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\nugetPackageFiles\\PSGallery\\packagerepos.txt"
    # Invoke-ParNugetDown -FirstHalf -PackageList $PackageList
    # Invoke-ParNugetDown -SecondHalf -PackageList $PackageList
    # Invoke-ParNugetDown -AllVersions -PackageList $PackageList
    # Invoke-ParNugetDown -FirstHalf -AllVersions -PackageList $PackageList
    # Invoke-ParNugetDown -SecondHalf -AllVersions -PackageList $PackageList



function Invoke-ParNugetDown {

    [CmdletBinding()]
    param (
        [switch]$FirstHalf,
        [switch]$SecondHalf,
        [System.Array]$PackageList,
        [System.Array]$Files,
        [string]$Directory,
        [string]$Source = "nuget.org",
        [switch]$AllVersions
    )
    
    begin {
        if ($PackageList) {
            $Files = $PackageList
        }
        if ($null -eq $Files -and $null -eq $Directory) {
            $Files = Get-Content "C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\nugetPackageFiles\\Microsoft2\\*.txt"
        }
        elseif ($Directory) {
            $Files = Get-Content (Get-ChildItem -Recurse  -Path $Directory -Filter "*.txt")
        }
        else {
            Write-Host "Please provide a directory or a list of files, or a collection of packages." -ForegroundColor Red
        }
        if ($FirstHalf) {
            $Files = $Files | Sort-Object -Unique

            $Files = $Files[0..$($Files.count * .50)]
            $Files.count
        }
        elseif ($SecondHalf) {
            $Files = $Files | Sort-Object -Unique

            $Files = $Files[$($Files.count * .50)..$($Files.count)]
            $Files.count

        }
        else {
            $Files = $Files | Sort-Object -Unique
            Write-Host "Not spliting up list. Pulling: $($Files.count) files."

        }
    }
    
    process {
        $Files | ForEach-Object -Parallel ({
                $Source = $using:Source
                $AllVersions = $using:AllVersions
                [string]$random = Get-Random -Maximum 99999999 -Minimum 1000000
                mkdir "D:\\Transfer\\ToMove\\nupkg\\$random"
                if ($AllVersions) {
                    try {
                    (find-package "$_**") | foreach-object ({
                                $(find-package -Name "$($_.Name)" -AllVersions -Source $Source) | Sort-Object Version -Desc | Select-Object -First 20 | foreach-object -Parallel {
                                    $Source = $using:Source
                                    $random = $using:random
                                    nuget install -OutputDirectory "D:\\Transfer\\ToMove\\nupkg\\$random" $($_.Name) -Version $($_.version) -Source $Source }
                                [System.GC]::Collect()
                            })
                    }
                    catch {
                        [string]$random = Get-Random -Maximum 99999999 -Minimum 1000000
                        mkdir "D:\\Transfer\\ToMove\\nupkg\\$random"
                        nuget install -OutputDirectory "D:\\Transfer\\ToMove\\nupkg\\$random" $_ -Source $Source
                    }
                    Get-ChildItem -Recurse -Path "D:\\Transfer\\ToMove\\nupkg\\$random" -File -Filter "*.*nupkg" | ForEach-Object -Parallel {
                        $_ | Where-Object {
                            $_.Length -gt 0
                        } | Foreach-Object {
                            Move-Item $_ "D:\\Transfer\\ToMove\\nupkg\\"
                        }
                    }
                }
                else {
                    try {
                        nuget install -OutputDirectory "D:\\Transfer\\ToMove\\nupkg\\$random" $_ -Source $Source
                    }
                    catch {
                        [string]$random = Get-Random -Maximum 99999999 -Minimum 1000000
                        mkdir "D:\\Transfer\\ToMove\\nupkg\\$random"
                        nuget install -OutputDirectory "D:\\Transfer\\ToMove\\nupkg\\$random" $_ -Source $Source
                    }
                    Get-ChildItem -Recurse -Path "D:\\Transfer\\ToMove\\nupkg\\$random" -File -Filter "*.*nupkg" | ForEach-Object -Parallel {
                        $_ | Where-Object {
                            $_.Length -gt 0
                        } | Foreach-Object {
                            Move-Item $_ "D:\\Transfer\\ToMove\\nupkg\\"
                        }
                    }
                }
                if ($null -ne $random) {
                    Remove-Item -Recurse -Force "D:\\Transfer\\ToMove\\nupkg\\$random"
                }
                [System.GC]::Collect()
            })
    }
    
    end {
        
    }
}



# ----------------------------------------------------------------------------

# ----------------------------------------------------------------------------

#############################################################

# Build Package files based off all entires in package files.

$files = New-Object System.Collections.ArrayList
# $tmpfiles = gci "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\packageLists2\*.txt"
# $tmpfiles = gci "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\Microsoft2\*.txt"
# $tmpfiles = gci "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\Microsoft2\aspnetcore.txt"
# $tmpfiles = gci "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\PSGallery\*.txt"
# $tmpfiles = gci "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\Terminal\*.txt"
foreach ($tmpfile in $tmpfiles) {
    $files = gc $tmpfile
    foreach ($file in $files) {
        BuildPackageList -PackageName "$($file)*" -OutputFile $tmpfile 
        # BuildPackageList -PackageName "$($file)*" -OutputFile $tmpfile -SerachSource "BaGet_Posh"
    }
}


$Sources = "https://api.nuget.org/v3/index.json",
"https://pkgs.dev.azure.com/ms/terminal/_packaging/TerminalDependencies/nuget/v3/index.json",
"https://pkgs.dev.azure.com/dnceng/public/_packaging/nuget-build/nuget/v3/index.json",
"https://pkgs.dev.azure.com/dnceng/public/_packaging/dotnet-eng/nuget/v3/index.json",
"https://pkgs.dev.azure.com/dnceng/public/_packaging/dotnet-public/nuget/v3/index.json",
"https://pkgs.dev.azure.com/dnceng/public/_packaging/myget-legacy%40Local/nuget/v3/index.json",
"https://pkgs.dev.azure.com/azure-public/vside/_packaging/msft_consumption/nuget/v3/index.json",
"https://www.powershellgallery.com/api/v2"


foreach ($tmpfile in $tmpfiles) {
    $files = gc $tmpfile
    foreach ($file in $files) {
        foreach ($Source in $Sources) {
            BuildPackageList -PackageName "$($file)*" -OutputFile $tmpfile -SerachSource $Source
        }
    }
}

# $tmpfile = "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\Microsoft2\Microsoft.Internal.txt"
# $tmpfile = "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\Microsoft2\winappdriver.txt"
# $tmpfile = "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\Microsoft2\calc.txt"
$tmpfile = "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\PSGallery\packagerepos.txt"

$SearchString = "microsoft.internal*"
$SearchString = "microsoft.winappdriver*"
$SearchString = "microsoft*calc*"
$SearchString = "windows*calc*"

foreach ($Source in $Sources) {
    BuildPackageList -PackageName "$SearchString" -OutputFile $tmpfile -SerachSource $Source
}

# BuildPackageList -PackageName "system.collections*" 
# Add to and clean up a txt file
# BuildPackageList -PackageName "*vmware*" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\packageLists2\vmware.txt"
# BuildPackageList -PackageName "*vagrant*" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\packageLists2\vagrant.txt"
# BuildPackageList -PackageName "*ldap*" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\packageLists2\ldap.txt"
# BuildPackageList -PackageName "system.collections*" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\Microsoft2\system.txt"
# BuildPackageList -PackageName "mediatr*" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\packageLists2\mediatr.txt"
# BuildPackageList -PackageName "HotChocolate*" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\packageLists2\HotChocolate.txt"
# BuildPackageList -PackageName "Automapper*" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\packageLists2\Automapper.txt"
# BuildPackageList -PackageName "polly*" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\packageLists2\polly.txt"
# BuildPackageList -PackageName "fluentemail*" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\packageLists2\fluent.txt"
# BuildPackageList -PackageName "fluentassertions*" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\packageLists2\fluent.txt"
# BuildPackageList -PackageName "swagger.*" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\packageLists2\swagger.txt"
# BuildPackageList -PackageName "Nswag.*" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\packageLists2\swagger.txt"
# BuildPackageList -PackageName "Microsoft.*javascript*" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\Microsoft2\javascript.txt"
# BuildPackageList -PackageName "Microsoft.*typescript*" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\Microsoft2\javascript.txt"
# BuildPackageList -PackageName "Microsoft.*nodejs*" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\Microsoft2\javascript.txt"
# BuildPackageList -PackageName "swashbuckle.*" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\packageLists2\swashbuckle.txt"
# BuildPackageList -PackageName "nodatime*" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\packageLists2\nodatime.txt"
# BuildPackageList -PackageName "docfx*" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\packageLists2\docfx.txt"
# BuildPackageList -PackageName "SharpZipLib*" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\packageLists2\SharpZipLib.txt"
# BuildPackageList -PackageName "*kubernetes*" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\packageLists2\kube.txt"
# BuildPackageList -PackageName "*kube*" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\packageLists2\kube.txt"
# BuildPackageList -PackageName "*helm*" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\packageLists2\kube.txt"
# BuildPackageList -PackageName "*fleet*" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\packageLists2\kube.txt"
# BuildPackageList -PackageName "*rancher*" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\packageLists2\kube.txt"
# BuildPackageList -PackageName "HtmlAgilityPack*" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\packageLists2\HtmlAgilityPack.txt"
# BuildPackageList -PackageName "mailkit*" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\packageLists2\mailkit.txt"
# BuildPackageList -PackageName "restsharp*" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\packageLists2\restsharp.txt"
# BuildPackageList -PackageName "autofac*" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\packageLists2\autofac.txt"
# BuildPackageList -PackageName "autofac.*" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\packageLists2\autofac.txt"
# BuildPackageList -PackageName "autofac.core.*" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\packageLists2\autofac.txt"
# BuildPackageList -PackageName "autofac.core.Resolving*" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\packageLists2\autofac.txt"
# BuildPackageList -PackageName "autofac.core.Lifetime*" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\packageLists2\autofac.txt"
# BuildPackageList -PackageName "rsync" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\packageList2\rsync.txt"
# BuildPackageList -PackageName "rsync*" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\packageList2\rsync.txt"
# BuildPackageList -PackageName "microsoft.net*" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\Microsoft2\dotnet.txt"
# BuildPackageList -PackageName "microsoft.netCore*" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\Microsoft2\dotnetcore.txt"
# BuildPackageList -PackageName "microsoft.*blazor*" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\Microsoft2\blazor.txt"
# BuildPackageList -PackageName "blazor*" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\packageLists2\blazor.txt"
# BuildPackageList -PackageName "runtime.*" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\Microsoft2\runtime.txt"
# BuildPackageList -PackageName "Microsoft.*runtime.*" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\Microsoft2\runtime.txt"
# BuildPackageList -PackageName "Microsoft.*" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\Microsoft2\microsoft.txt"
# BuildPackageList -PackageName "System.*" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\Microsoft2\system.txt"
# BuildPackageList -PackageName "Microsoft.aspnetcore*" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\Microsoft2\aspnetcore.txt"
# BuildPackageList -PackageName "Microsoft.AspNetCore.Mvc.Razor.Extensions*" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\Microsoft2\aspnetcore.txt"
# BuildPackageList -PackageName "Microsoft.WinAppDriver*" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\Microsoft2\winappdriver.txt"
# BuildPackageList -PackageName "Microsoft.WinAppDriver.Appium*" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\Microsoft2\winappdriver.txt"
# BuildPackageList -PackageName "Microsoft.WinAppDriver.Appium.WebDriver*" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\Microsoft2\winappdriver.txt"
# BuildPackageList -PackageName "Microsoft.AspNetCore.Mvc.Razor*" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\Microsoft2\aspnetcore.txt"
# BuildPackageList -PackageName "Microsoft.AspNetCore.Mvc*" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\Microsoft2\aspnetcore.txt"
# BuildPackageList -PackageName "Microsoft.AspNetCore*" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\Microsoft2\aspnetcore.txt"
# BuildPackageList -PackageName "microsoft.entityframework*" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\Microsoft2\efcore.txt"
# BuildPackageList -PackageName "microsoft.aspnetcore.auth*" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\Microsoft2\aspnetcoreAuthentication.txt"
# BuildPackageList -PackageName "microsoft.*powershell*" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\Microsoft2\powershell.txt"
# BuildPackageList -PackageName "powershell.*" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\Microsoft2\powershell.txt"
# BuildPackageList -PackageName "microsoft.*.signalr*" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\Microsoft2\signalr.txt"
# BuildPackageList -PackageName "signalr.*" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\Microsoft2\signalr.txt"
# BuildPackageList -PackageName "nuget.*" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\Microsoft2\nuget.txt"
# Add to and clean up a txt file based on an array of packages
# BuildPackageList -PackageArray $PackageArray -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\packageLists2\system.txt"
# Specify SearchSource
# BuildPackageList -PackageName "*vmware*" -SearchSource "BaGet_Posh" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\PSGallery\vmware.txt"
# BuildPackageList -PackageName "powershell.*" -SearchSource "BaGet_Posh" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\PSGallery\powershell.txt"


function BuildPackageList {
    # Return to STDOUT
    # BuildPackageList -PackageName "system.collections*" 
    # Add to and clean up a txt file
    # BuildPackageList -PackageName "*vmware*" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\packageLists2\vmware.txt"
    # BuildPackageList -PackageName "Microsoft.*javascript*" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\Microsoft2\javascript.txt"
    # BuildPackageList -PackageName "nuget.*" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\Microsoft2\nuget.txt"
    # Add to and clean up a txt file based on an array of packages
    # BuildPackageList -PackageArray $PackageArray -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\packageLists2\system.txt"
    # Specify SearchSource
    # BuildPackageList -PackageName "*vmware*" -SearchSource "BaGet_Posh" -OutputFile "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\PSGallery\vmware.txt"
    param (
        [string]$PackageName,
        [System.Collections.ArrayList]$PackageArray,
        [string]$OutputFile,
        [string]$SearchSource = "nuget.org"
        # [string]$SearchSource = "https://pkgs.dev.azure.com/ms/terminal/_packaging/TerminalDependencies/nuget/v3/index.json"
        
    )
    [string]$random = Get-Random -Maximum 9999999999 -Minimum 1000000
    $TempFile = "C:\Windows\Temp\nugetFiles_$random.txt"
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
        [string]$PackageName,
        [string]$Source = "https://api.nuget.org/v3/index.json"
        # [string]$Source = "https://pkgs.dev.azure.com/ms/terminal/_packaging/TerminalDependencies/nuget/v3/index.json"
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



$allFiles = "C:\Program Files (x86)\Microsoft SDKs", "C:\Users\$env:USERNAME\.nuget\packages", "D:\\Transfer\\ToMove", "C:\\Users\\$env:USERNAME\\AppData\\Local\\NuGet\\v3-cache", "C:\\Users\\$env:USERNAME\\source\\repos", "C:\\Users\\$env:USERNAME\\AppData\\Local\\PackageManagement\\NuGet\\Packages", "C:\\Program Files\\PackageManagement\\NuGet\\Packages"
# Remove-Variable allFiles
# DeDupe
# $toDeDupeCopy = gci "*.nupkg" -Recurse -Path "D:\\Transfer\\ToMove\\BaGet_Shared\\packages\\packages"

function DeDupe-Nupkg() {
    param(
        [System.Collections.Arraylist]$allFiles,
        [switch]$UseUpdateJson
    )

    if (!$allFiles) {
        # $toDeDupeCopy = Get-ChildItem "*.nupkg" -Recurse -Path "D:\\Transfer\\ToMove\\BaGet_Shared"    
        $toDeDupeCopy = Get-ChildItem "*.*nupkg" -Recurse -Path "D:\\Transfer\\ToMove\\nupkg" | Where-Object { $($_.GetType().Name -eq "FileInfo") -and $($_.LastWriteTime -ge (Get-Date).AddDays(-5)) }
    }
    else {
        $toDeDupeCopy = $allFiles | foreach-object -Parallel ({ Get-ChildItem "*.nupkg" -Recurse -Path $_ })
    }
    $toDeDupeCopy | Where-Object { $_.Length -le 0 } | Remove-Item -force
    $toDeDupeCopy | ForEach-Object -Parallel ({ Copy-Item $_ -Destination "D:\\Transfer\\ToMove\\nupkg\\" })
    $moved = Get-ChildItem "*.*nupkg" -Recurse -Path "D:\\Transfer\\Moved\\nupkg\\" -File
    $moved | Where-Object { $_.Length -le 0 } | Remove-Item -force
    $moved = $moved | Where-Object { $_.Length -gt 0 } 
    $toMove = Get-ChildItem -recurse "*.*nupkg" -Path "D:\\Transfer\\ToMove\\nupkg\\" -File
    $toMove | Where-Object { $_.Length -le 0 } | Remove-Item -force
    $toMove = $toMove | Where-Object { $_.Length -gt 0 } 
    [system.gc]::collect()
    $staging = "D:\\Transfer\\Staging\\nupkg\\"

    # Move Files
    if (!$UseUpdateJson) {
        $toMove | ForEach-Object -Parallel ({
                $staging = $using:staging
                $moved = $using:moved
                if ($_.name -notin $moved.Name) { move-item $_ $staging } })    
        [system.gc]::collect()
    }
    else {
        # Comparing file list with actual file names
        $outputdir = "C:\\users\\$env:USERNAME\\Downloads\\"

        $files = gc "$outputdir\output.json" | convertfrom-json

        # Get-ChildItem -Recurse -Path 'D:\Transfer\Moved\nupkg\' | Select-Object Name, FullName, CreationTime, LastWriteTime, Length | ConvertTo-Json | Out-File "$outputdir\output.json"
        $files += Get-ChildItem -Recurse -Path 'D:\Transfer\Moved\nupkg\' | Select-Object Name, FullName, CreationTime, LastWriteTime, Length 

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

        $files | ConvertTo-Json | Out-File "$outputdir\$(Get-Date -Format "yyyyMMdd")_output.json"

        Copy-Item -Force "$outputdir\$(Get-Date -Format "yyyyMMdd")_output.json" "$outputdir\output.json"

        # $files = gc "$outputdir\output.json" | convertfrom-json

        $tomove = gci -Recurse -Filter "*.*nupkg" -Path D:\Transfer\ToMove
            
        $tomove | Where-Object { $_.Name -inotin $files.name } | ForEach-Object -Parallel ({ 
                $staging = $using:staging
                # $files = $using:files
                mv $_ "$staging\"
            })
        # 7zip the staging folder up.
        # BD size
        # & 'C:\Program Files\7-Zip\7z.exe' a -v23040M -psimnet1 "D:\transfer\$(Get-Date -Format "yyyyMMdd")_nupkg.7z" "D:\transfer\Staging\nupkg\"

        ## DVD size
        # & 'C:\Program Files\7-Zip\7z.exe' a -v8128M -psimnet1 "D:\transfer\$(Get-Date -Format "yyyyMMdd")_nupkg.7z" "D:\transfer\Staging\nupkg\"

        # $shared_destination = "G:\My Drive\Shared\"

        # $gdrive_destination = "G:\My Drive\Shared\$(Get-Date -Format "yyyyMMdd")\"

        # if (!$(Test-Path $gdrive_destination)) {
        #     mkdir $gdrive_destination
        # }

        # gci "D:\Transfer\$(Get-Date -Format "yyyyMMdd")_nupkg.7z*" | foreach ({mv $_ $gdrive_destination\\})

        # Get-FileHash "$gdrive_destination\*.7z*" | Format-List >> "$shared_destination\PRE_DTA_HASH_$(Get-Date -Format "yyyyMMdd")_NAME.txt"

        # if ($_.name -notin $ImportedMoved -or $_.name -notin $($ImportedMoved).Name) { move-item $_ $staging } 
        [system.gc]::collect()
    }

}




$allFiles = "C:\Program Files (x86)\Microsoft SDKs", "C:\Users\$env:USERNAME\.nuget\packages", "D:\\Transfer\\ToMove\\nupkg", "D:\\Transfer\\ToMove\\gits", "C:\\Users\\$env:USERNAME\\AppData\\Local\\NuGet\\v3-cache", "C:\\Users\\$env:USERNAME\\source\\repos", "C:\\Users\\$env:USERNAME\\AppData\\Local\\PackageManagement\\NuGet\\Packages", "C:\\Program Files\\PackageManagement\\NuGet\\Packages"

# Remove-Variable allFiles
# DeDupe
# $toDeDupeCopy = gci "*.nupkg" -Recurse -Path "D:\\Transfer\\ToMove\\BaGet_Shared\\packages\\packages"

# Prep-Nupkg -allFiles $allFiles
# Prep-Nupkg -allFiles $allFiles -UseUpdateJson
# Prep-Nupkg -UseUpdateJson

function Prep-Nupkg() {
    param(
        [System.Collections.Arraylist]$allFiles,
        [switch]$UseUpdateJson
    )

    if (!$allFiles) {
        $toDeDupeCopy = Get-ChildItem "*.*nupkg" -Recurse -Path "D:\\Transfer\\ToMove\\nupkg" | Where-Object { $($_.GetType().Name -eq "FileInfo") -and $($_.LastWriteTime -ge (Get-Date).AddDays(-5)) }
    }
    else {
        $toDeDupeCopy = $allFiles | foreach-object -Parallel ({ Get-ChildItem "*.nupkg" -Recurse -Path $_ })
    }
    $toDeDupeCopy | Where-Object { $_.Length -le 0 } | Remove-Item -force
    $toDeDupeCopy | ForEach-Object -Parallel ({ Copy-Item $_ -Destination "D:\\Transfer\\ToMove\\nupkg\\" })
    $moved = Get-ChildItem "*.*nupkg" -Recurse -Path "D:\\Transfer\\Moved\\nupkg\\" -File
    $moved | Where-Object { $_.Length -le 0 } | Remove-Item -force
    $moved = $moved | Where-Object { $_.Length -gt 0 } 
    $toMove = Get-ChildItem -recurse "*.*nupkg" -Path "D:\\Transfer\\ToMove\\nupkg\\" -File
    $toMove | Where-Object { $_.Length -le 0 } | Remove-Item -force
    $toMove = $toMove | Where-Object { $_.Length -gt 0 } 
    [system.gc]::collect()
    $staging = "D:\\Transfer\\Staging\\nupkg\\"

    # Move Files
    if (!$UseUpdateJson) {
        $toMove | ForEach-Object -Parallel ({
                $staging = $using:staging
                $moved = $using:moved
                if ($_.name -notin $moved.Name) { move-item $_ $staging } })    
        [system.gc]::collect()
    }
    else {
        # Comparing file list with actual file names
        $outputdir = "C:\\Users\\$env:USERNAME\\Downloads\\"

        $files = gc "$outputdir\output.json" | convertfrom-json

        Write-Host "Gathering Moved Files..."

        $files += Get-ChildItem -Recurse -Path 'D:\Transfer\Moved\nupkg\' | Select-Object Name, FullName, CreationTime, LastWriteTime, Length 

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

        $files | ConvertTo-Json | Out-File "$outputdir\$(Get-Date -Format "yyyyMMdd")_output.json"

        Write-Host "Copying new output file..."

        Copy-Item -Force "$outputdir\$(Get-Date -Format "yyyyMMdd")_output.json" "$outputdir\output.json"

        Write-Host "Gathering ToMove Files..."

        $tomove = gci -Recurse -Filter "*.*nupkg" -Path D:\Transfer\ToMove\nupkg
            
        Write-Host "Moving Files..."

        $tomove | Where-Object { $_.Name -inotin $files.name } | ForEach-Object -Parallel ({ 
                $staging = $using:staging
                mv $_ "$staging\"
            })
        [system.gc]::collect()
    }
}



Start-Sleep 3600

$allFiles = "C:\Program Files (x86)\Microsoft SDKs", "C:\Users\$env:USERNAME\.nuget\packages", "D:\\Transfer\\ToMove\\nupkg", "D:\\Transfer\\ToMove\\gits", "C:\\Users\\$env:USERNAME\\AppData\\Local\\NuGet\\v3-cache", "C:\\Users\\$env:USERNAME\\source\\repos", "C:\\Users\\$env:USERNAME\\AppData\\Local\\PackageManagement\\NuGet\\Packages", "C:\\Program Files\\PackageManagement\\NuGet\\Packages"


# DeDupe-Nupkg -allFiles $allFiles
Prep-Nupkg -allFiles $allFiles

# 7zip the staging folder up.
# BD size
# & 'C:\Program Files\7-Zip\7z.exe' a -v23040M -psimnet1 "D:\transfer\dedupe_$(Get-Date -Format "yyyyMMdd")_nupkg.7z" "D:\transfer\Staging\nupkg\"
# 700M size
& 'C:\Program Files\7-Zip\7z.exe' a -v700M -psimnet1 "D:\transfer\dedupe_$(Get-Date -Format "yyyyMMdd")_nupkg.7z" "D:\transfer\Staging\nupkg\"

# $Directory = "D:\\Transfer\\Staging\\nupkg"
# get-filehash "$Directory\\*" | format-list | Out-File "$Directory\\..\\PRE_HASH_$(Get-Date -Format "yyyyMMdd")_nupkg.txt"


################# 
################# 
function Prep-Transfer {
    [CmdletBinding()]
    param (
        [string]$Folder,
        [ValidateSet("23040M", "8128M", "4096M", "2048M", "1024M")]
        [string]$ArchiveSize
    )
    
    begin {
        
        # $shared_destination = "G:\My Drive\Shared\"
        $shared_destination = "D:\Transfer\Shared\"

        # $gdrive_destination = "G:\My Drive\Shared\$(Get-Date -Format "yyyyMMdd")\"
        $drive_destination = "D:\Transfer\Shared\$(Get-Date -Format "yyyyMMdd")\"

        if (!$(Test-Path $drive_destination)) {
            mkdir $drive_destination
        }

    }
    
    process {
        & 'C:\Program Files\7-Zip\7z.exe' a -v$ArchiveSize -psimnet1 "D:\transfer\$(Get-Date -Format "yyyyMMdd")_Transfer.7z" "D:\transfer\Prep\"

        gci "D:\Transfer\$(Get-Date -Format "yyyyMMdd")_Transfer.7z*" | foreach ({ mv $_ $drive_destination\\ })

        # Get-FileHash "*.7z*" | Format-List >> "PRE_DTA_HASH_$(Get-Date -Format "yyyyMMdd")_NAME.txt"
        Get-FileHash "$drive_destination\*.7z*" | Format-List >> "$shared_destination\PRE_DTA_HASH_$(Get-Date -Format "yyyyMMdd")_NAME.txt"

    }
    
    end {
        
    }
}
# 7zip the staging folder up.
# BD size
# & 'C:\Program Files\7-Zip\7z.exe' a -v23040M -psimnet1 "D:\transfer\$(Get-Date -Format "yyyyMMdd")_nupkg.7z" "D:\transfer\Staging\nupkg\"

## DVD size
& 'C:\Program Files\7-Zip\7z.exe' a -v8128M -psimnet1 "D:\transfer\$(Get-Date -Format "yyyyMMdd")_nupkg.7z" "D:\transfer\Staging\nupkg\"

# $shared_destination = "G:\My Drive\Shared\"
$shared_destination = "D:\Transfer\Shared\"

# $gdrive_destination = "G:\My Drive\Shared\$(Get-Date -Format "yyyyMMdd")\"
$gdrive_destination = "D:\Transfer\Shared\$(Get-Date -Format "yyyyMMdd")\"

if (!$(Test-Path $gdrive_destination)) {
    mkdir $gdrive_destination
}

gci "D:\Transfer\$(Get-Date -Format "yyyyMMdd")_nupkg.7z*" | foreach ({ mv $_ $gdrive_destination\\ })

# Get-FileHash "*.7z*" | Format-List >> "PRE_DTA_HASH_$(Get-Date -Format "yyyyMMdd")_NAME.txt"
Get-FileHash "$gdrive_destination\*.7z*" | Format-List >> "$shared_destination\PRE_DTA_HASH_$(Get-Date -Format "yyyyMMdd")_NAME.txt"

################# 
################# 
