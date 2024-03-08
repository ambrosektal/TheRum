# docker run --rm --name nuget-server -p 5555:80 --env-file "D:\\Transfer\\ToMove\\BaGet_Shared\\baget.env" -v "D:\\Transfer\\ToMove\\BaGet_Shared:/var/baget" loicsharma/baget:latest

# # # # # # # # # 

# TODO:: Testing...
# Save-PowerShellGetForOffline

# Requires -RunAsAdministrator
#Download the OfflinePowerShellGetDeploy to a location that can be accessed
# by both the connected and disconnected systems.
Save-Module -Name OfflinePowerShellGetDeploy -Path 'D:\' -Repository PSGallery
Import-Module D:\OfflinePowerShellGetDeploy

# Put PowerShellGet somewhere locally
Save-PowerShellGetForOffline -LocalFolder 'D:\OfflinePowerShellGet'

Import-Module F:\OfflinePowerShellGetDeploy
Install-PowerShellGetOffline -LocalFolder 'D:\OfflinePowerShellGet'


# Publish to a NuGet Server repository using my NuGetAPI key
$publishModuleSplat = @{
    Path        = 'D:\OfflinePowershellGet'
    Repository  = 'LocalPsRepo'
    NuGetApiKey = $nuGetApiKey
}
Publish-Module @publishModuleSplat


# Publish to a file share repo - the NuGet API key must be a non-blank string
$publishModuleSplat = @{
    Path        = 'D:\OfflinePowerShellGet'
    Repository  = 'LocalPsRepo'
    NuGetApiKey = 'AnyStringWillDo'
}
Publish-Module @publishModuleSplat

# # # # # # # # # 


#! DO NOT USE!!! WASTE OF TIME!!!
# #Testing another method.
# nugetmirror.exe nupkgs "https://api.nuget.org/v3/index.json" -o D:\Transfer\ToMove\nupkg --ignore-errors --latest-only --include-id "Microsoft.*" --start $((Get-Date).AddDays(-25))
# nugetmirror.exe nupkgs "https://www.powershellgallery.com/api/v2" -o D:\Transfer\ToMove\nupkg --ignore-errors --latest-only --include-id "Microsoft.*" --start $((Get-Date).AddDays(-25))
# nugetmirror.exe nupkgs "https://pkgs.dev.azure.com/ms/terminal/_packaging/TerminalDependencies/nuget/v3/index.json" -o D:\Transfer\ToMove\nupkg --ignore-errors --latest-only --include-id "Microsoft.*" --start $((Get-Date).AddDays(-25))
# nugetmirror.exe nupkgs "https://pkgs.dev.azure.com/dnceng/public/_packaging/nuget-build/nuget/v3/index.json" -o D:\Transfer\ToMove\nupkg --ignore-errors --latest-only --include-id "Microsoft.*" --start $((Get-Date).AddDays(-25))

# nugetmirror.exe nupkgs "https://pkgs.dev.azure.com/dnceng/public/_packaging/dotnet-eng/nuget/v3/index.json" -o D:\Transfer\ToMove\nupkg --ignore-errors --latest-only --include-id "Microsoft.*" --start $((Get-Date).AddDays(-25))
# nugetmirror.exe nupkgs "https://pkgs.dev.azure.com/dnceng/public/_packaging/dotnet-public/nuget/v3/index.json" -o D:\Transfer\ToMove\nupkg --ignore-errors --latest-only --include-id "Microsoft.*" --start $((Get-Date).AddDays(-25))
# nugetmirror.exe nupkgs "https://pkgs.dev.azure.com/dnceng/public/_packaging/myget-legacy%40Local/nuget/v3/index.json" -o D:\Transfer\ToMove\nupkg --ignore-errors --latest-only --include-id "Microsoft.*" --start $((Get-Date).AddDays(-25))
# nugetmirror.exe nupkgs "https://pkgs.dev.azure.com/dnceng/public/_packaging/nuget-build/nuget/v3/index.json" -o D:\Transfer\ToMove\nupkg --ignore-errors --latest-only --include-id "Microsoft.*" --start $((Get-Date).AddDays(-25))
# nugetmirror.exe nupkgs "https://pkgs.dev.azure.com/azure-public/vside/_packaging/msft_consumption/nuget/v3/index.json" -o D:\Transfer\ToMove\nupkg --ignore-errors --latest-only --include-id "Microsoft.*" --start $((Get-Date).AddDays(-25))


$Directory = "C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\nugetPackageFiles\\Microsoft2"
# $Directory = "C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\nugetPackageFiles\\packageLists2"
# $Directory = "C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\nugetPackageFiles\\PSGallery"
$Files = Get-Content (Get-ChildItem -Recurse  -Path $Directory -Filter "*.txt")
# $Files = Get-Content (Get-ChildItem -Recurse  -Path $Directory -Filter "terminal.txt")
$Files = $Files | Sort-Object -Unique
$Sources = "https://api.nuget.org/v3/index.json",
"https://pkgs.dev.azure.com/ms/terminal/_packaging/TerminalDependencies/nuget/v3/index.json",
"https://pkgs.dev.azure.com/dnceng/public/_packaging/nuget-build/nuget/v3/index.json",
"https://pkgs.dev.azure.com/dnceng/public/_packaging/dotnet-eng/nuget/v3/index.json",
"https://pkgs.dev.azure.com/dnceng/public/_packaging/dotnet-public/nuget/v3/index.json",
"https://pkgs.dev.azure.com/dnceng/public/_packaging/myget-legacy%40Local/nuget/v3/index.json",
"https://pkgs.dev.azure.com/azure-public/vside/_packaging/msft_consumption/nuget/v3/index.json"
# "https://www.powershellgallery.com/api/v2",


ForEach ($Source in $Sources) {
    $Files | ForEach-Object ({
            # $Source = $using:Source
            # nugetmirror.exe nupkgs $Source -o D:\Transfer\ToMove\nupkg --ignore-errors --latest-only --stable-only --include-id "$_*" --start $((Get-Date).AddDays(-45))
            # nugetmirror.exe nupkgs $Source -o D:\Transfer\ToMove\nupkg --ignore-errors --stable-only --include-id "$_*" --start $((Get-Date).AddDays(-45))
            # nugetmirror.exe nupkgs $Source -o D:\Transfer\ToMove\nupkg2 --ignore-errors --stable-only --include-id "$_*" --start $((Get-Date).AddDays(-45))
            nugetmirror.exe nupkgs $Source -o D:\Transfer\ToMove\nupkg3 --ignore-errors --include-id "$_*" --start $((Get-Date).AddDays(-365))
            [System.GC]::Collect()
        })
}


# $Files = "microsoft*","nuget*","typescript*","system*","runtime*","nuke*","dotnet*","blazor*","powershell*","vmware*","docker*","kube*","cake*"
# $arguments = ""
# $arguments += $Files | foreach({"`"$_*`" "})


ForEach ($Source in $Sources) {
    nugetmirror.exe nupkgs $Source -o D:\Transfer\ToMove\nupkg --ignore-errors --latest-only --stable-only --include-id "microsoft*" --include-id "nuget*" --include-id "typescript*"  --include-id "system*" --include-id "runtime*" --include-id "nuke*" --include-id "dotnet*" --include-id "blazor*" --include-id "powershell*" --include-id "vmware*" --include-id "docker*" --include-id "kube*" --include-id "cake*" --include-id "dapper*" --include-id "syncfusion*" --include-id "skia*" --include-id "lucern*"  --start $((Get-Date).AddDays(-360))
    [System.GC]::Collect()
}


ForEach ($Source in $Sources) {
    nugetmirror.exe nupkgs $Source -o D:\Transfer\ToMove\nupkg --ignore-errors --latest-only --stable-only --start $((Get-Date).AddDays(-360))
    [System.GC]::Collect()
}

nugetmirror.exe nupkgs "https://api.nuget.org/v3/index.json" -o D:\Transfer\ToMove\nupkg --ignore-errors --latest-only --stable-only --start $((Get-Date).AddDays(-360))


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



# ----------------------------------------------------------------------------
Invoke-ParNugetDown -FirstHalf -Directory "C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\nugetPackageFiles\\Microsoft2"
Invoke-ParNugetDown -FirstHalf -Directory "C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\nugetPackageFiles\\packageLists2"
Invoke-ParNugetDown -FirstHalf -Directory "C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\nugetPackageFiles\\PSGallery"
# Invoke-ParNugetDown -FirstHalf -Directory "C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\nugetPackageFiles\\PSGallery" -Source "BaGet_Posh"


Invoke-ParNugetDown -SecondHalf -Directory "C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\nugetPackageFiles\\Microsoft2"
Invoke-ParNugetDown -SecondHalf -Directory "C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\nugetPackageFiles\\packageLists2"
Invoke-ParNugetDown -SecondHalf -Directory "C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\nugetPackageFiles\\PSGallery"
# Invoke-ParNugetDown -SecondHalf -Directory "C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\nugetPackageFiles\\PSGallery" -Source "BaGet_Posh"



function Invoke-ParNugetDown {
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
    [CmdletBinding()]
    param (
        [switch]$FirstHalf,
        [switch]$SecondHalf,
        # [System.Collections.Generic]$Files,
        [System.Array]$PackageList,
        [System.Array]$Files,
        [string]$Directory,
        # [string]$Source = "BaGet"
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



# # Function to calculate the hash value of a file
# function Get-FileHash($filePath) {
#     $hashAlgorithm = Get-FileHash -Algorithm MD5 -Path $filePath
#     return $hashAlgorithm.Hash
# }

# # Function to remove duplicate files from a directory
# function Remove-DuplicateFiles($directoryPath) {
#     # Get all files in the directory
#     $files = Get-ChildItem -File -Recurse $directoryPath -Filter "*.*nupkg"

#     # Create a hashtable to store the hash values of files
#     $hashTable = @{}

#     # Iterate through each file
#     foreach ($file in $files) {
#         # Get the hash value of the file
#         $hash = Get-FileHash $file.FullName

#         # Check if the hash value already exists in the hashtable
#         if ($hashTable.ContainsKey($hash)) {
#             # If the hash value exists, remove the duplicate file
#             Write-Host "Removing duplicate file: $($file.FullName)"
#             Remove-Item -Path $file.FullName -Force
#         }
#         else {
#             # If the hash value doesn't exist, add it to the hashtable
#             $hashTable[$hash] = $null
#         }
#     }
# }

# # # Usage: Remove-DuplicateFiles "C:\Path\To\Directory"
# # Remove-DuplicateFiles "C:\Path\To\Directory"

# ----------------------------------------------------------------------------


# Function to calculate the hash value of a file
function Get-FileHash($filePath) {
    $hashAlgorithm = Get-FileHash -Algorithm MD5 -Path $filePath
    return $hashAlgorithm.Hash
}
# Function to remove duplicate files from a directory
function Remove-DuplicateFiles($parentDirectories) {
    # Get all files in the directories
    $files = [System.Collections.ArrayList]@()
    foreach ($directoryPath in $parentDirectories) {
        $files += Get-ChildItem -File -Recurse $directoryPath -Filter "*.*nupkg"
    }

    # Create a hashtable to store the hash values of files
    $hashTable = @{}

    # Iterate through each file
    foreach ($file in $files) {
        # Get the hash value of the file
        $hash = Get-FileHash $file.FullName

        # Check if the hash value already exists in the hashtable
        if ($hashTable.ContainsKey($hash)) {
            # If the hash value exists, remove the duplicate file
            Write-Host "Removing duplicate file: $($file.FullName)"
            Remove-Item -Path $file.FullName -Force
        }
        else {
            # If the hash value doesn't exist, add it to the hashtable
            $hashTable[$hash] = $null
        }
    }
}


# Parent directories to process
$parentDirectories = @(
    "D:\\Transfer\\ToMove\\nupkg\\",
    "D:\\Transfer\\ToMove\\BaGet_Shared"
)

# # Process each parent directory in parallel
# $parentDirectories | ForEach-Object -Parallel {
#     $parentDir = $_
#     Remove-DuplicateFiles $parentDir
# }
Remove-DuplicateFiles $parentDirectories



# ----------------------------------------------------------------------------

$files = New-Object System.Collections.ArrayList

# $files = gc "C:\\users\\$env:USERNAME\\Downloads\\gits\\TheRum\\nugetPackageFiles\\packageLists2\\terminal.txt"
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
        try {
            nuget install -OutputDirectory "D:\\Transfer\\ToMove\\nupkg\\$random" $_ -Source "BaGet"
        }
        catch {
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




$files | ForEach-Object -Parallel { dotnet tool install --tool-path "D:\\Transfer\\ToMove\\nupkg\\" --add-source "http://localhost:9999/v3/index.json" --add-source "http://localhost:9889/v3/index.json" --add-source "http://localhost:7777/v3/index.json" --add-source "http://localhost:5555/v3/index.json" $_.split(" ")[0] --arch x64 ; [System.GC]::Collect() }
$(dotnet tool search "microsoft.powershell.commands*" --take 50) | ForEach-Object -Parallel { dotnet tool install --tool-path "D:\\Transfer\\ToMove\\nupkg\\" $_.split(" ")[0] --arch x64 ; [System.GC]::Collect() }

$(dotnet tool search "vmware.*" --take 500) | ForEach-Object -Parallel { dotnet tool install --tool-path "D:\\Transfer\\ToMove\\nupkg\\" --add-source "http://localhost:7777/v3/index.json" --add-source "http://localhost:5555/v3/index.json" $_.split(" ")[0] --arch x64 }

$(dotnet tool search "system.*" --take 500) | ForEach-Object -Parallel { dotnet tool install --tool-path "D:\\Transfer\\ToMove\\nupkg\\" --add-source "http://localhost:7777/v3/index.json" --add-source "http://localhost:5555/v3/index.json" $_.split(" ")[0] --arch x64 }

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

# Parallel Attempt W/O presearch
$files | ForEach-Object -Parallel ({
        [string]$random = Get-Random -Maximum 99999999 -Minimum 1000000
        mkdir "D:\\Transfer\\ToMove\\nupkg\\$random"
        try {
            nuget install -OutputDirectory "D:\\Transfer\\ToMove\\nupkg\\$random" $_ -Source "BaGet_Posh"
        }
        catch {
            [string]$random = Get-Random -Maximum 99999999 -Minimum 1000000
            mkdir "D:\\Transfer\\ToMove\\nupkg\\$random"
            nuget install -OutputDirectory "D:\\Transfer\\ToMove\\nupkg\\$random" $_ -Source "BaGet_Posh" 
        }
        [System.GC]::Collect()
    })

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
$files | Foreach-Object -Parallel {
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


# $allFiles = "C:\Program Files (x86)\Microsoft SDKs", "C:\Users\$env:USERNAME\.nuget\packages", "D:\\Transfer\\ToMove", "C:\\Users\\$env:USERNAME\\AppData\\Local\\NuGet\\v3-cache", "C:\\Users\\$env:USERNAME\\source\\repos", "C:\\Users\\$env:USERNAME\\AppData\\Local\\PackageManagement\\NuGet\\Packages", "C:\\Program Files\\PackageManagement\\NuGet\\Packages"
# # Remove-Variable allFiles
# # DeDupe
# # $toDeDupeCopy = gci "*.nupkg" -Recurse -Path "D:\\Transfer\\ToMove\\BaGet_Shared\\packages\\packages"

# function DeDupe-Nupkg() {
#     param(
#         [System.Collections.Arraylist]$allFiles
#     )

#     if (!$allFiles) {
#         # $toDeDupeCopy = Get-ChildItem "*.nupkg" -Recurse -Path "D:\\Transfer\\ToMove\\BaGet_Shared"    
#         $toDeDupeCopy = Get-ChildItem "*.*nupkg" -Recurse -Path "D:\\Transfer\\ToMove\\BaGet_Shared" | Where-Object { $($_.GetType().Name -eq "FileInfo") -and $($_.LastWriteTime -ge (Get-Date).AddDays(-5)) }
#     }
#     else {
#         # $toDeDupeCopy = $allFiles.foreach({ Get-ChildItem "*.nupkg" -Recurse -Path $_ })
#         $toDeDupeCopy = $allFiles | foreach-object -Parallel ({ Get-ChildItem "*.nupkg" -Recurse -Path $_ })
#     }
#     # $toDeDupeCopy = gci "*.nupkg" -Recurse -Path "D:\\Transfer\\ToMove\\BaGet_Shared"
#     $toDeDupeCopy | Where-Object { $_.Length -le 0 } | Remove-Item -force
#     # $toDeDupeCopy. foreach({ Copy-Item $_ -Destination "D:\\Transfer\\ToMove\\nupkg\\" })
#     $toDeDupeCopy | ForEach-Object -Parallel ({ Copy-Item $_ -Destination "D:\\Transfer\\ToMove\\nupkg\\" })
#     $moved = Get-ChildItem "*.*nupkg" -Recurse -Path "D:\\Transfer\\Moved\\nupkg\\" -File
#     $moved | Where-Object { $_.Length -le 0 } | Remove-Item -force
#     $moved = $moved | Where-Object { $_.Length -gt 0 } 
#     # $moved = Get-ChildItem "*.*nupkg" -Recurse -Path "D:\\Transfer\\Moved\\nupkg\\"
#     $toMove = Get-ChildItem -recurse "*.*nupkg" -Path "D:\\Transfer\\ToMove\\nupkg\\" -File
#     $toMove | Where-Object { $_.Length -le 0 } | Remove-Item -force
#     $toMove = $toMove | Where-Object { $_.Length -gt 0 } 
#     # $toMove = Get-ChildItem -recurse "*.*nupkg" -Path "D:\\Transfer\\ToMove\\nupkg\\"
#     [system.gc]::collect()
#     $staging = "D:\\Transfer\\Staging\\nupkg\\"
#     # $count = 0
#     # $leavingCount = 0
#     # # $toMove.foreach({ if ($_.name -notin $moved) { $count++ } })
#     # $moved.foreach({ if ($_.name -notin $toMove) { $count++ } })
#     # $moved.foreach({ if ($_.name -in $toMove) { $leavingCount++ } })
#     # write-host "Going to move $count packages"
#     # write-host "$leavingCount duplicate packages"

#     # Move Files
#     if (!$ImportedMoved) {
#         # $toMove.foreach({ if ($_.name -notin $moved.Name) { move-item $_ $staging } })    
#         $toMove | ForEach-Object -Parallel ({
#                 $staging = $using:staging
#                 $moved = $using:moved
#                 if ($_.name -notin $moved.Name) { move-item $_ $staging } })    
#         [system.gc]::collect()
#     }
#     else {
#         # $toMove.foreach({ if ($_.name -notin $ImportedMoved -or $_.name -notin $($ImportedMoved).Name) { move-item $_ $staging } })
#         $toMove | ForEach-Object -Parallel ({ 
#                 $staging = $using:staging
#                 $ImportedMoved = $using:ImportedMoved
#                 if ($_.name -notin $ImportedMoved -or $_.name -notin $($ImportedMoved).Name) { move-item $_ $staging } })
#         [system.gc]::collect()
#     }

# }




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
        # $toDeDupeCopy = $allFiles.foreach({ Get-ChildItem "*.nupkg" -Recurse -Path $_ })
        $toDeDupeCopy = $allFiles | foreach-object -Parallel ({ Get-ChildItem "*.nupkg" -Recurse -Path $_ })
    }
    # $toDeDupeCopy = gci "*.nupkg" -Recurse -Path "D:\\Transfer\\ToMove\\BaGet_Shared"
    $toDeDupeCopy | Where-Object { $_.Length -le 0 } | Remove-Item -force
    # $toDeDupeCopy. foreach({ Copy-Item $_ -Destination "D:\\Transfer\\ToMove\\nupkg\\" })
    $toDeDupeCopy | ForEach-Object -Parallel ({ Copy-Item $_ -Destination "D:\\Transfer\\ToMove\\nupkg\\" })
    $moved = Get-ChildItem "*.*nupkg" -Recurse -Path "D:\\Transfer\\Moved\\nupkg\\" -File
    $moved | Where-Object { $_.Length -le 0 } | Remove-Item -force
    $moved = $moved | Where-Object { $_.Length -gt 0 } 
    # $moved = Get-ChildItem "*.*nupkg" -Recurse -Path "D:\\Transfer\\Moved\\nupkg\\"
    $toMove = Get-ChildItem -recurse "*.*nupkg" -Path "D:\\Transfer\\ToMove\\nupkg\\" -File
    $toMove | Where-Object { $_.Length -le 0 } | Remove-Item -force
    $toMove = $toMove | Where-Object { $_.Length -gt 0 } 
    # $toMove = Get-ChildItem -recurse "*.*nupkg" -Path "D:\\Transfer\\ToMove\\nupkg\\"
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
    # if (!$ImportedMoved) {
    if (!$UseUpdateJson) {
        # $toMove.foreach({ if ($_.name -notin $moved.Name) { move-item $_ $staging } })    
        $toMove | ForEach-Object -Parallel ({
                $staging = $using:staging
                $moved = $using:moved
                if ($_.name -notin $moved.Name) { move-item $_ $staging } })    
        [system.gc]::collect()
    }
    else {
        # $toMove.foreach({ if ($_.name -notin $ImportedMoved -or $_.name -notin $($ImportedMoved).Name) { move-item $_ $staging } })
        # $toMove | ForEach-Object -Parallel ({ 
        #         $staging = $using:staging
        # $ImportedMoved = $using:ImportedMoved

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

# $tomove = gci -Recurse -Filter "*.*nupkg" -Path D:\Transfer\ToMove\nupkg
$tomove = gci -Recurse -Filter "*.*nupkg" -Path D:\Transfer\ToMove

# $tomove | Where-Object { $_.Name -inotin $files.name } | Foreach-Object { mv $_ D:\transfer\Staging\nupkg\ }
$tomove | Foreach-Object -Parallel {
    $tomovefile = $_
    $files = $using:files
    Where-Object { $tomovefile.Name -inotin $files.name } | Foreach-Object { mv $tomovefile D:\transfer\Staging\nupkg\ }
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

# Sample array of variable names
# $variableNames = @("abc.def.ghi", "jkl.mno", "pqr.stu.vwx.yz")
$list = gc "C:\Users\$env:USERNAME\Downloads\gits\TheRum\nugetPackageFiles\Microsoft2\aspnetcore.txt"

# Loop through each variable name
$newList = New-Object 'System.Collections.ArrayList'
foreach ($name in $list) {
    # Trim any leading and trailing white spaces
    $trimmedName = $name.Trim()

    # Split the name by the period character
    $splitName = $trimmedName -split '\.'

    # Remove the last item from the array
    $splitName = $splitName[0..($splitName.Length - 2)]

    # Join the array back into a string, separated by periods
    $newName = $splitName -join '.'

    # Add to ArrayList
    $newList.Add($newName) | Out-Null  # | Out-Null suppresses the output of Add method

    # Output the new name
    Write-Host $newName
}

$newList = $newList.Trim() | Sort-Object -Unique
$newList.Count

################# 
