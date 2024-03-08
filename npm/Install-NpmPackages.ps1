

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
# $packageArray = gc "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\requests\\esbuild.txt" 
# $packageArray = gc "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\requests\\" 
# $packageArray = gc "C:\\Users\\$env:USERNAME\\Downloads\\gits\\TheRum\\npmPackageFiles\\requests\\font-awesome.txt" 
# Install-NpmPackages -PackageArray $packageArray -AllLatest
# Install-NpmPackages -PackageArray $packageArray -AllMajorVersions -UpperVersionRange 20 -LowerVersionRange 0 -BaseVersion '0'


# $(0..20) | foreach-object -Parallel {
#     $BaseVersion = $_
#     $packageArray = $using:PackageArray
#     Install-NpmPackages -PackageArray $packageArray -AllMajorVersions -UpperVersionRange 20 -LowerVersionRange 0 -BaseVersion $BaseVersion
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
                        # npm i "$PackageName@$BaseVersion.$_" --force --prefix "D:\\Transfer\\ToMove\\node\\$random"; 
                    }
                    else {
                        # npm i "$PackageName@$_" --force --prefix "D:\\Transfer\\ToMove\\node\\$random"; 
                        npm i "$PackageName@~$_" --force --prefix "D:\\Transfer\\ToMove\\node\\$random"; 
                        # npm i "$PackageName@$_" --force --prefix "D:\\Transfer\\ToMove\\node\\$random"; 
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
                    # npm i "$PackageName@$BaseVersion.$_" --force --prefix "D:\\Transfer\\ToMove\\node\\$random"; 
                }
                else {
                    npm i "$PackageName@~$_" --force --prefix "D:\\Transfer\\ToMove\\node\\$random"; 
                    # npm i "$PackageName@$_" --force --prefix "D:\\Transfer\\ToMove\\node\\$random"; 
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


