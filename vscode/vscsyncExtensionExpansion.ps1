
$directories = (gci -Recurse -Filter "latest.json" | where-object {$_.Length -gt 7000}).Directory

foreach($directory in $directories){
	# cd $directory
	$files = $(gc $directory\latest.json | convertfrom-json)
	
	# if (!$(Test-Path $directory\$($_.version)\$($_.targetPlatform))) {
		($files.versions).foreach({$(mkdir $directory\$($_.version)\$($_.targetPlatform) ) })	
		($files.versions).foreach({$(cd $directory\$($_.version)\$($_.targetPlatform) && ($_.files.source).foreach({Invoke-WebRequest $_ -OutFile $_.Split("/")[-1]  }) ) })
	# } else {
		# Write-Host "Newest version of $directory\$($_.version)\$($_.targetPlatform) already exists"
	# }
}


# Remove extensions with under X installs
# (gc latest.json | convertfrom-json).statistics.GetValue(0).value
# (gci -Recurse -Filter "latest.json" | where-object {(gc $_ | convertfrom-json).statistics.GetValue(0).value -lt 10000 }).Directory | rm -r -force
(((gci -Recurse -Filter "latest.json" | where-object {(gc $_ | convertfrom-json).statistics.GetValue(0).value -lt 5000 }).Directory) | Where-Object {($_.Name -notlike "ms-*") -and ($_.Name -notlike "*svelte*")}).count
$removeMe = (((gci -Recurse -Filter "latest.json" | where-object {(gc $_ | convertfrom-json).statistics.GetValue(0).value -lt 1000 }).Directory) | Where-Object {($_.Name -notlike "ms-*") -and ($_.Name -notlike "*svelte*")})
$keepMe = (((gci -Recurse -Filter "latest.json" | where-object {(gc $_ | convertfrom-json).statistics.GetValue(0).value -gt 5000 }).Directory) )
# (((gci -Recurse -Filter "latest.json" | where-object {(gc $_ | convertfrom-json).statistics.GetValue(0).value -lt 2000 }).Directory) | Where-Object {($_.Name -notlike "ms-*") -and ($_.Name -notlike "*svelte*")}) | rm -r -Force


# clean up specified.json
$currentNames = <"paste in list from json">
$removeNames = (((gci -Recurse -Filter "latest.json" | where-object {(gc $_ | convertfrom-json).statistics.GetValue(0).value -lt 5000 }).Directory) | Where-Object {($_.Name -notlike "ms-*") -and ($_.Name -notlike "*svelte*")}).name
($currentNames | Where-Object {$_ -notin $removeNames})
# Paste the output into the json

# Remove the folders from the cache, based on number of downloads.
(((gci -Recurse -Filter "latest.json" | where-object {(gc $_ | convertfrom-json).statistics.GetValue(0).value -lt 5000 }).Directory) | Where-Object {($_.Name -notlike "ms-*") -and ($_.Name -notlike "*svelte*")}) | rm -r -Force


# Finding folders modified only in the last X days
gci -Recurse | Where{$($_.GetType().Name -eq "DirectoryInfo") -and $($_.LastWriteTime -ge (Get-Date).AddDays(-7))}

# Finding files modified only in the last X days
gci -Recurse | Where{$($_.GetType().Name -eq "FileInfo") -and $($_.LastWriteTime -ge (Get-Date).AddDays(-7))}

# finding files that are older than X days:
gci -Recurse | Where{$($_.GetType().Name -eq "FileInfo") -and $($_.LastWriteTime -le (Get-Date).AddDays(-2))} 

# tgz files modified in the last 12 hours
$bunFiles = gci -Recurse -Filter "*.tgz" | Where-Object {$_.LastWriteTime -ge (Get-Date).AddHours(-12) }

# Clean up extra extension version folders
## Return the first 3 folders in each extension folder
(gci ).foreach({Get-ChildItem $_ -Directory|Sort-Object Fullname -Desc|Select-Object -First 3})

## Skip the first 3 folders(versions) in the extensions folders and return the rest.
(gci ).foreach({Get-ChildItem $_ -Directory|Sort-Object FullName -Desc|Select-Object -Skip 3})

## Skip the first 3 folders(versions) in the extensions folders and remove the rest.
(gci ).foreach({Get-ChildItem $_ -Directory|Sort-Object FullName -Desc|Select-Object -Skip 3|Remove-Item -Confirm:$false -Force -Recurse})

## Skip the first 3 json files(LastWriteTime), including "latest.json", in each stable installer folder and return the rest.
(gci -Directory).foreach({
	(gci $_ "stable" ).foreach({
		Get-ChildItem $_ -File -Filter "*.json" | Sort-Object LastWriteTime -Desc | Select-Object -Skip 4 
	})
})

## Skip the first 3 json files(LastWriteTime), including "latest.json", in each stable installer folder and Remove the rest.
(gci -Directory).foreach({
	(gci $_ "stable" ).foreach({
		Get-ChildItem $_ -File -Filter "*.json" | Sort-Object LastWriteTime -Desc | Select-Object -Skip 4 | Remove-Item -Confirm:$false -Force -Recurse
	})
})

## Skip the first 3 zip files(LastWriteTime), including "latest.json", in each stable installer folder and return the rest.
(gci -Directory).foreach({
	(gci $_ "stable" ).foreach({
		Get-ChildItem $_ -File -Filter "*.zip" | Sort-Object LastWriteTime -Desc | Select-Object -Skip 4 
	})
})

## Skip the first 3 exe files(LastWriteTime), including "latest.json", in each stable installer folder and return the rest.
(gci -Directory).foreach({
	(gci $_ "stable" ).foreach({
		Get-ChildItem $_ -File -Filter "*.exe" | Sort-Object LastWriteTime -Desc | Select-Object -Skip 4 
	})
})

## Skip the first 3 tar.gz files(LastWriteTime), including "latest.json", in each stable installer folder and return the rest.
(gci -Directory).foreach({
	(gci $_ "stable" ).foreach({
		Get-ChildItem $_ -File -Filter "*.tar.gz" | Sort-Object LastWriteTime -Desc | Select-Object -Skip 4 
	})
})

## Skip the first 3 snap files(LastWriteTime), including "latest.json", in each stable installer folder and return the rest.
(gci -Directory).foreach({
	(gci $_ "stable" ).foreach({
		Get-ChildItem $_ -File -Filter "*.snap" | Sort-Object LastWriteTime -Desc | Select-Object -Skip 4 
	})
})


## Skip the first 3 deb files(LastWriteTime), including "latest.json", in each stable installer folder and return the rest.
(gci -Directory).foreach({
	(gci $_ "stable" ).foreach({
		Get-ChildItem $_ -File -Filter "*.deb" | Sort-Object LastWriteTime -Desc | Select-Object -Skip 4 
	})
})

## Skip the first 3 rpm files(LastWriteTime), including "latest.json", in each stable installer folder and return the rest.
(gci -Directory).foreach({
	(gci $_ "stable" ).foreach({
		Get-ChildItem $_ -File -Filter "*.rpm" | Sort-Object LastWriteTime -Desc | Select-Object -Skip 4 
	})
})



# This has become where I store basic functions and math stuff... Really not sure how that happened, but here we are...
$results = for($i=101010101; $i -le 9999999999 ; $i++ ){
	[PSCustomObject]@{
		Number = $i
		x3 = $i % 3 -eq 0
		x6 = $i % 6 -eq 0
		x9 = $i % 9 -eq 0
	} | Where-Object {
		$_.x3 -eq "True" -and $_.x6 -eq "True" -and $_.x9 -eq "True"
	}
}

$results = for($i=100000000; $i -le 9999999999 ; $i++ ){
	[PSCustomObject]@{
		Number = $i
		x18 = $i % 18 -eq 0
	} | Where-Object {
		$_.x18 -eq "True"	
	}
}

# Returns this error
# OperationStopped: Value was either too large or too small for an Int32.
# need to make it a [long] instead of int32.
10000000000..706968676625 | Foreach-Object -Parallel {
    if ($_ % 18 -eq 0) {
        Write-Output $_
    }
}

# Trim off the nupkg and the version from the nupkg file names
($moved.foreach({$_.Name.TrimStart('.0123456789').TrimEnd(".nupkg") })).trimstart('.0123456789').trimend('.0123456789')